#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=0-2:00:00
#SBATCH --mail-type=ALL
#SBATCH --job-name="TN_Short"
#SBATCH -p short_gpu
#SBATCH --gpus-per-task=1
#SBATCH --output=runs/slurm-TN_Short-%j.out
#SBATCH --error=runs/slurm-TN_Short-%j.err

hostname
echo "Time: $(date)"
echo "Job ID: $SLURM_JOB_ID"

source /etc/profile.d/modules.sh

module load cmake
module load cuda/11.4
module load gcc/9.2.1
module load extra
module load openmpi/4.1.2_slurm-21.08.5

# -----------------------------
# Build executable
# -----------------------------
./build_EpiScale_Signal.sh build

# -----------------------------
# Create organized run folder
# -----------------------------
RUN_BASE="TN"
RUN_NAME="TN_${SLURM_JOB_ID}"
RUN_DIR="./runs/${RUN_NAME}"

mkdir -p "${RUN_DIR}/animation"
mkdir -p "${RUN_DIR}/dataOutput"
mkdir -p "${RUN_DIR}/signalVtkFiles"
mkdir -p "${RUN_DIR}/logs"

# Template config is inside resources/
CONFIG_TEMPLATE="resources/disc_${RUN_BASE}.cfg"

# The executable expects ./resources/disc_<slurm-name>.cfg
CONFIG_RUN_BASENAME="disc_${RUN_NAME}.cfg"
CONFIG_RUN="resources/${CONFIG_RUN_BASENAME}"

# Fail early if template config is missing
if [ ! -f "${CONFIG_TEMPLATE}" ]; then
    echo "ERROR: Missing config template: ${CONFIG_TEMPLATE}"
    echo "Current directory: $(pwd)"
    echo "Available config files:"
    find . -maxdepth 3 -name "disc_*.cfg"
    exit 1
fi

# Copy template config to job-specific config inside resources/
cp "${CONFIG_TEMPLATE}" "${CONFIG_RUN}"

# Replace output paths in the job-specific config
sed -i "s|^AnimationFolder *=.*|AnimationFolder = ${RUN_DIR}/animation/|" "${CONFIG_RUN}"
sed -i "s|^PolygonStatFileName *=.*|PolygonStatFileName = ${RUN_DIR}/dataOutput/polygonStat_|" "${CONFIG_RUN}"
sed -i "s|^DetailStatFileNameBase *=.*|DetailStatFileNameBase = ${RUN_DIR}/dataOutput/detailedStat_|" "${CONFIG_RUN}"
sed -i "s|^SignalFolderName *=.*|SignalFolderName = ${RUN_DIR}/signalVtkFiles/|" "${CONFIG_RUN}"


# Expected VTK names: Single_TN_<jobid>_00000.vtk, etc.
sed -i "s|^AnimationName *=.*|AnimationName = Single_|" "${CONFIG_RUN}"
sed -i "s|^UniqueSymbol *=.*|UniqueSymbol = ${RUN_NAME}_|" "${CONFIG_RUN}"

# Save copies of the template and exact config used inside the run folder
cp "${CONFIG_TEMPLATE}" "${RUN_DIR}/disc_TN_template.cfg"
cp "${CONFIG_RUN}" "${RUN_DIR}/${CONFIG_RUN_BASENAME}"

echo "Run base: ${RUN_BASE}"
echo "Run name: ${RUN_NAME}"
echo "Run directory: ${RUN_DIR}"
echo "Template config: ${CONFIG_TEMPLATE}"
echo "Run config used by executable: ${CONFIG_RUN}"
echo "Slurm out report: runs/slurm-TN_Short-${SLURM_JOB_ID}.out"
echo "Slurm err report: runs/slurm-TN_Short-${SLURM_JOB_ID}.err"

echo "Updated config output settings:"
grep -E "^(AnimationFolder|AnimationName|UniqueSymbol|PolygonStatFileName|DetailStatFileNameBase|SignalFolderName|SimulationTotalTime|SimulationTimeStep|TotalNumOfOutputFrames)" "${CONFIG_RUN}"

# -----------------------------
# Run simulation
# -----------------------------
./bin/runDiscSimulation_M -slurm "${RUN_NAME}"

echo "Finished run: ${RUN_NAME}"
echo "Outputs saved in: ${RUN_DIR}"