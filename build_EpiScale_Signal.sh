#!/bin/bash

set -e

if [[ -z $1 ]]; then echo -e "USAGE\n\t$0 BUILD_NAME" && exit 256; fi
BUILD_NAME=$1


module load cmake
module load cuda/11.4
module load gcc/9.2.1
module load extra
module load openmpi/4.1.2_slurm-21.08.5
rm -rf $BUILD_NAME
mkdir -p $BUILD_NAME && cd $BUILD_NAME

cmake \
-DCMAKE_C_COMPILER=$(which gcc)  \
-DCMAKE_CXX_COMPILER=$(which g++)  \
-DCUDA_INCLUDE_DIRS=${CUDA_HOME}/include \
-DBUILD_TESTING=OFF \
ENABLE_TESTS_COMPILATION=False \
../

make -j 20
