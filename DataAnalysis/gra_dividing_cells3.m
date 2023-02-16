close all
dist_vec = [];
angle_vec = [];
tissueR_vec = [];
figure(1); hold on;
oldFileCellGrowthProgress = [];
cellGrowthProgress = [];
total_divisionNumber = 0 ;
tissueArea = [] ;
cellNum = [] ;
tissueHeight =[];
tissueWidth = [] ;

tmpWidth = [] ;
tmpHeight = [] ;
tmpHvW = [] ;
tmpCN = [] ;
tmpCellNum = 79;
tmpLocY = [] ;
tmpAngleY =[] ;
time = [] ;
timeSeriesCellProgress = zeros(1000,1000);
AllNeighbors = zeros(1000,1000) ;

tissueCenterAllTime = [];

for fileNum = 1:320
    disp(fileNum)
%         if (fileNum == 330 || fileNum == 392 || fileNum == 393)
%             continue ; 
%         end
    if fileNum<10
        filename = ['detailedStat_N01G00_0000' num2str(fileNum) '.txt'];
    elseif fileNum<100
        filename = ['detailedStat_N01G00_000' num2str(fileNum) '.txt'];
    elseif fileNum<1000
        filename = ['detailedStat_N01G00_00' num2str(fileNum) '.txt'];
    else
        filename = ['detailedStat_N01G00_0' num2str(fileNum) '.txt'];
    end
    fileID = fopen(filename);
    C = textscan(fileID,'%s %s','Delimiter',':');
    fclose(fileID);
    char = C{2};
    cellNUM = length(char)/12;
    cellID  = [];
    cellNum = [cellNum,cellNUM];
    time = [ time, fileNum] ;
    oldFileCellGrowthProgress = cellGrowthProgress ;
    cellGrowthProgress = [];
    cellCenter = [];
    cellArea = [] ;
    neighbors = [] ;
    for i = 1:length(char)
        if mod(i,12)==1
            cellID = [cellID;str2double(char{i})];
        end
        if mod(i,12)==2
            cellGrowthProgress = [cellGrowthProgress;str2double(char{i})];
            timeSeriesCellProgress(fileNum, length(cellID) ) = str2double(char{i}) ;
        end
        if mod(i,12)==0
            cellCenter = [cellCenter;str2double(regexp(char{i},'[+-\d.]+','match'))];
        end
        if mod(i,12)== 6
            cellArea = [cellArea;str2double(char{i})];
        end
        if mod(i,12)== 5
            neighbors = [neighbors;str2double(char{i})];
        end
    end
    for k = 1:length(neighbors)
        AllNeighbors(fileNum,k) = neighbors(k) ;
    end
    
     
    cellCenter = cellCenter(:,1:2);
    tissueWidth = [ tissueWidth ; max(cellCenter)-min(cellCenter)];
    if (cellNUM - tmpCellNum > 20 )
        tmp = max(cellCenter)-min(cellCenter) ;
        tmpWidth = [tmpWidth; max(cellCenter)-min(cellCenter) ] ;
        tmpHvW = [tmpHvW ; tmp(2)./tmp(1) ];
        tmpCellNum = tmpCellNum + 20 ;
        tmpCN = [tmpCN ; cellNUM] ;
        
        dist_vec = sort(dist_vec);
        N = 5;
        dist_x = 0:1/N:1-1/N;
        dist_y = zeros(size(dist_x));
        for i = 1:length(dist_x)
            dist_y(i) = sum((dist_vec>=dist_x(i)).*(dist_vec<dist_x(i)+1/N))/(pi/N*(dist_x(i)+dist_x(i)+1/N));
        end
        N2 = 8 ;
        angle_x = -pi:(2*pi)/N2:pi-(2*pi)/N2;
        angle_y = zeros(size(angle_x));
        for i = 1:length(angle_x)
            angle_y(i) = sum((angle_vec>=angle_x(i)).*(angle_vec<angle_x(i)+(2*pi)/N2));
        end    
        tmpLocY = [tmpLocY ; dist_y ] ;
        tmpAngleY = [tmpAngleY ; angle_y ] ;
        
    end
    tissueCenter = mean(cellCenter,1);
    tissueCenterAllTime = [ tissueCenterAllTime; tissueCenter ];
    %tmpTissueCent = ( max(cellCenter)+ min(cellCenter) )/2.0 ;
    %tissueCenter = tmpTissueCent ;
    cellDist = sqrt((cellCenter(:,1)-tissueCenter(1)).^2+(cellCenter(:,2)-tissueCenter(2)).^2);
    cellMaxDist = max(cellDist);
    tissueR_vec = [tissueR_vec, cellMaxDist];
    tissueArea = [tissueArea , sum(cellArea) ];
    if fileNum > 1
        dividing_idCandidate = find(oldFileCellGrowthProgress>=0.8);
        dividing_id = dividing_idCandidate (find ( cellGrowthProgress( dividing_idCandidate) < 0.1  ) );
        total_divisionNumber = total_divisionNumber + size(dividing_id) ;
        dividing_cells = cellCenter(dividing_id,:);
        plot((dividing_cells(:,1)-tissueCenter(1))/cellMaxDist,(dividing_cells(:,2)-tissueCenter(2))/cellMaxDist,'r.','MarkerSize',5);
        dist_vec = [dist_vec; cellDist(dividing_id)/cellMaxDist];
        angle_vec = [angle_vec; atan2(dividing_cells(:,2)-tissueCenter(2),dividing_cells(:,1)-tissueCenter(1))];
    end
   
end
tissueHeight = tissueWidth(:,2);
tissueWidth = tissueWidth(:,1);
tmpHeight = tmpWidth(:,2) ;
tmpWidth = tmpWidth(:,1) ;
hold off;
box on; axis equal
set(gca,'LineWidth',2,'FontSize',25)

dist_vec = sort(dist_vec);
N = 5;
dist_x = 0:1/N:1-1/N;
dist_y = zeros(size(dist_x));
for i = 1:length(dist_x)
    dist_y(i) = sum((dist_vec>=dist_x(i)).*(dist_vec<dist_x(i)+1/N))/(pi/N*(dist_x(i)+dist_x(i)+1/N));
end
N2 = 6 ;
angle_x = -pi:(2*pi)/N2:pi-(2*pi)/N2;
angle_y = zeros(size(angle_x));
for i = 1:length(angle_x)
    angle_y(i) = sum((angle_vec>=angle_x(i)).*(angle_vec<angle_x(i)+(2*pi)/N2));
end    
% figure(2);
% subplot(1,2,1);
% % normalize dist_y
% dist_y = dist_y/(sum(dist_y));
% bar(dist_x,dist_y);
% axis tight
% xlabel('radius for dividing cells');
% set(gca,'LineWidth',2,'FontSize',25)
% subplot(1,2,2);
% % normalize angle_y
%  angle_y = angle_y/sum(angle_y);
% bar(angle_x,angle_y);
% axis tight
% xlabel('angle for dividing cells');
% set(gca,'LineWidth',2,'FontSize',25)
% figure(3);
% plot(tissueR_vec,'LineWidth',5);
% title('Tissue Radius');
% set(gca,'LineWidth',2,'FontSize',25)
% figure(4);
% plot(tissueArea,'LineWidth',5);
% title('Tissue Area');
% set(gca,'LineWidth',2,'FontSize',25)
% plot(tmpWidth,tmpHeight,'LineWidth',5,'Color','b');
% 
% figure(5);
%  plot(tmpCN,tmpHvW,'linestyle','none','marker','p');


    
