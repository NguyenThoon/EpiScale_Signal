
index = 3;
eval(['dist_x' num2str(index)  '=dist_x'])  ;
eval(['dist_y' num2str(index)  '=dist_y'])  ;
eval(['angle_x' num2str(index)  '=angle_x'])  ;
eval(['angle_y' num2str(index)  '=angle_y'])  ;
eval(['tissueR_vec' num2str(index)  '=tissueR_vec'])  ;
eval(['tissueArea' num2str(index)  '=tissueArea'])  ;
eval(['cellNum' num2str(index)  '=cellNum'])  ;
eval(['tissueWidth' num2str(index)  '=tissueWidth'])  ;
eval(['tissueHeight' num2str(index)  '=tissueHeight'])  ;
eval(['tmpCN' num2str(index)  '=tmpCN'])  ;
eval(['tmpHvW' num2str(index)  '=tmpHvW'])  ;
eval(['tmpLocY' num2str(index)  '=tmpLocY'])  ;
eval(['tmpAngleY' num2str(index)  '=tmpAngleY'])  ;
eval(['time' num2str(index)  '=time'])  ;


%  dist_x7 = dist_x ;
%  dist_y7 = dist_y ;
%  angle_x7 = angle_x ;
%  angle_y7 = angle_y ;
%  tissueR_vec7 = tissueR_vec ;
%  tissueArea7 = tissueArea ;
%  cellNum7 = cellNum ;
%  tissueWidth7 = tissueWidth ;
%  tissueHeight7 = tissueHeight ;
%  tmpCN7 = tmpCN ;
%  tmpHvW7 = tmpHvW ;
%  tmpLocY7 = tmpLocY ;
%  tmpAngleY7 = tmpAngleY ;
 
% 
%  figure(2);
%  subplot(1,2,1);
%  hold on
%  bar(dist_x3,dist_y3,'FaceColor',[0.2 0.2 0.5]);
%  bar(dist_x2,dist_y2,0.5,'FaceColor',[0 1 0.]);
%  hold off
%  axis tight
%  xlabel('radius for dividing cells');
%  set(gca,'LineWidth',2,'FontSize',25)
% % 
%  subplot(1,2,2);
%  % normalize angle_y
% hold on
% bar(angle_x3,angle_y3,'FaceColor',[0.2 0.2 0.5]);
% bar(angle_x2,angle_y2,0.5,'FaceColor',[0. 1 0.]);
% hold off
% axis tight
% xlabel('angle for dividing cells');
% set(gca,'LineWidth',2,'FontSize',25)
% legend('kp=2','kp=20')


% figure(3);
% hold on ;
% %plot(tissueR_vec,'LineWidth',5);
% plot(tissueR_vec1,'LineWidth',5,'Color','b');
% plot(tissueR_vec2,'LineWidth',5,'Color','r');
% plot(tissueR_vec3,'LineWidth',5,'Color','g');
% %plot(tissueR_vec4,'LineWidth',5,'Color','y');
% title('Tissue Radius');
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('kp=0.1','kp=1.0','kp=10')

% figure(4);
% hold on ;
% %plot(tissueArea,'LineWidth',5);
% plot(tissueArea1,'LineWidth',5,'Color','b');
% plot(tissueArea2,'LineWidth',5,'Color','r');
% plot(tissueArea3,'LineWidth',5,'Color','g');
% % plot(tissueArea5,'LineWidth',5);
% title('Tissue Area');
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('d=0.04','d=0.4','d=4')
% 
figure(5);
hold on ;
%plot(tissueArea,'LineWidth',5);
%plot(cellNum1,'LineWidth',5,'Color','b');
%plot(cellNum2,'LineWidth',5,'Color','r');
plot(cellNum3,'LineWidth',5,'Color','k');
%plot(cellNum4,'LineWidth',5,'Color','k');
%plot(cellNum5,'LineWidth',5,'Color','y');
%plot(cellNum6,'LineWidth',5,'Color','m');
% plot(tissueArea5,'LineWidth',5);
title('cell numbers');
set(gca,'LineWidth',2,'FontSize',25) 
hold off
legend('kp=0.1','kp=1.0', 'kp=10')
% 
% Diff = 20;
% deg0 = 1.8;
% d1 = 4.0; d2 = 10.0; d3 = 0.1;
% lambdaOverL1 = (Diff/(deg0*d1) )^0.5 ./(tissueArea1 .^0.5)/3.1415 ;
% lambdaOverL2 = (Diff/(deg0*d2) )^0.5 ./(tissueArea2 .^0.5)/3.1415 ;
% lambdaOverL3 = (Diff/(deg0*d3) )^0.5 ./(tissueArea3 .^0.5)/3.1415 ;
% 
% figure(6);
% hold on ;
% plot(lambdaOverL1,'LineWidth',5,'Color','b');
% plot(lambdaOverL2,'LineWidth',5,'Color','r');
% plot(lambdaOverL3,'LineWidth',5,'Color','g');
% title('scaled decay length');
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('d=4.0','d=10.0','d=0.1')

% figure(7);
% hold on ;
% plot(tissueWidth1,'LineWidth',5,'Color','b');
% plot(tissueWidth2,'LineWidth',5,'Color','r');
% plot(tissueWidth3,'LineWidth',5,'Color','g');
% axis( [0 200 20 80])
% title('Tissue Width');
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('d=0.04','d=0.4','d=4.0')

% figure(8);
% hold on ;
% plot(tissueHeight1,'LineWidth',5,'Color','b');
% plot(tissueHeight2,'LineWidth',5,'Color','r');
% plot(tissueHeight3,'LineWidth',5,'Color','g');
% axis( [0 200 20 80])
% title('Tissue Height');
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('d=0.04','d=0.4','d=4.0')

% figure(9);
% hold on ;
% plot(tissueWidth1,tissueHeight1,'LineWidth',5,'Color','b');
% plot(tissueWidth2,tissueHeight2,'LineWidth',5,'Color','r');
% plot(tissueWidth3,tissueHeight3,'LineWidth',5,'Color','g');
% %plot(tissueWidth4,tissueHeight4,'LineWidth',5,'Color','y');
% %plot(tissueHeight3,'LineWidth',5,'Color','g');
% %axis( [0 200 20 80])
% ylabel('tissue Height')
% xlabel('tissue Width')
% set(gca,'LineWidth',2,'FontSize',25) 
% hold off
% legend('kp=0.1','kp=1.0','kp=10')

figure(10);
hold on ;
%plot(tmpCN1,tmpHvW1,'linestyle','none','marker','p','Color','b');
%plot(tmpCN2,tmpHvW2,'linestyle','none','marker','s','Color','r');
plot(tmpCN3,tmpHvW3,'linestyle','none','marker','o','Color','k');
%plot(tmpCN4,tmpHvW4,'linestyle','none','marker','x','Color','k');
%plot(tmpCN5,tmpHvW5,'linestyle','none','marker','*','Color','y');
%plot(tmpCN6,tmpHvW6,'linestyle','none','marker','^','Color','m');
%plot(tmpCN7,tmpHvW7,'linestyle','none','marker','d','Color','k');
%axis( [100 500 0.9 1.4])
ylabel('tissue circularity')
xlabel('CellNumber')
set(gca,'LineWidth',2,'FontSize',25) 
hold off
legend('kp=1','kp=1.0', 'kp=10','kp=0.1','kp=10','kp=100')

% save 'yourFileName.mat'
%save 'March21Advanced_Adv4.mat'
