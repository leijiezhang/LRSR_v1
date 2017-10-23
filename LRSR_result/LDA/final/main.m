% COIL_LRSR_error=LRSR_error;
% COIL_USSR_error=USSR_error;
% COIL_best_k=best_k;
% 
% ISOlet_LRSR_error=LRSR_error;
% ISOlet_USSR_error=USSR_error;
% ISOlet_best_k=best_k;
% 
% MNIST_LRSR_error=LRSR_error;
% MNIST_USSR_error=USSR_error;
% MNIST_best_k=best_k;
% 
% PIE_LRSR_error=LRSR_error;
% PIE_USSR_error=USSR_error;
% PIE_best_k=best_k;
% 
% USPS_LRSR_error=LRSR_error;
% USPS_USSR_error=USSR_error;
% USPS_best_k=best_k;
% 
% YaleB_LRSR_error=LRSR_error;
% YaleB_USSR_error=USSR_error;
% YaleB_best_k=best_k;
% 
% clear LRSR_error USSR_error;
% clear LRSR_result result_com best_k;
% save plot_data.mat *;


figure;
plot(car_idx,LRSR_acc,'r-s',car_idx,USSR_acc,'b-o','LineWidth',1.5);
title('Comparation of LRSR on LDA & USSR @ USPS');
xlabel('Dim','fontsize',12);
ylabel('Accuracy','fontsize',12);
h_leg =legend('LRSR Accuracy','USSR Accuracy');
set(h_leg,'position',[0.725 0.14 0.160714285714286 0.0555555555555556]);
set (gcf,'Position',[0,0,800,500], 'color','w');
set(gca,'FontSize',12);
grid on;

figure;
plot(car_idx,best_k,'r-s',car_idx,car_idx,'b-o','LineWidth',1.5);
title('Comparation of LRSR on LDA & USSR @ USPS');
xlabel('Dim','fontsize',12);
ylabel('Rank','fontsize',12);
h_leg =legend('USSL(Full rank of W)','LRSR(Low rank of W)');
set(h_leg,'position',[0.17 0.84 0.160714285714286 0.0555555555555556]);
set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
set (gcf,'Position',[0,0,800,500], 'color','w');
set(gca,'FontSize',12);
grid on;

% figure;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;
% plot(car_idx,car_idx,'k:','LineWidth',1.5);
% hold on;

%draw the figure of all the rank of all datasets.
% plot(1:1:67,1:1:67,'k:',...
%     1:1:size(COIL_best_k,1),COIL_best_k,'r-s',...
%     1:1:size(ISOlet_best_k,1),ISOlet_best_k,'b-x',...
%     1:1:size(MNIST_best_k,1),MNIST_best_k,'g-+',...
%     1:1:size(PIE_best_k,1),PIE_best_k,'c-*',...
%     1:1:size(USPS_best_k,1),USPS_best_k,'m-d',...
%     1:1:size(YaleB_best_k,1),YaleB_best_k,'y-p',...
%     'LineWidth',1.5);
% title('Real rank of W');
% xlabel('Dim','fontsize',12);
% ylabel('Rank','fontsize',12);
% h_leg =legend('Full rank','COIL','ISOlet','MNIST','PIE','USPS','YaleB');
% set(h_leg,'position',[0.14 0.75 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;
% 
% 
% 
% %draw the figure of all the error rate of all datasets.
% plot(1:1:size(COIL_LRSR_error,1),COIL_LRSR_error,'r-',...
%     1:1:size(ISOlet_LRSR_error,1),ISOlet_LRSR_error,'b-',...
%     1:1:size(MNIST_LRSR_error,1),MNIST_LRSR_error,'g-',...
%     1:1:size(PIE_LRSR_error,1),PIE_LRSR_error,'c-',...
%     1:1:size(USPS_LRSR_error,1),USPS_LRSR_error,'m-',...
%     1:1:size(YaleB_LRSR_error,1),YaleB_LRSR_error,'k-',...
%     'LineWidth',1.5);
% title('Real rank of W');
% xlabel('Dim','fontsize',12);
% ylabel('Error rate','fontsize',12);
% h_leg =legend('COIL','ISOlet','MNIST','PIE','USPS','YaleB');
% % set(h_leg,'position',[0.14 0.75 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;
% 
% plot(1:1:size(COIL_LRSR_error,1),COIL_LRSR_error,'r-',...
%     1:1:size(ISOlet_LRSR_error,1),ISOlet_LRSR_error,'b-',...
%     1:1:size(MNIST_LRSR_error,1),MNIST_LRSR_error,'g-',...
%     1:1:size(PIE_LRSR_error,1),PIE_LRSR_error,'c-',...
%     1:1:size(USPS_LRSR_error,1),USPS_LRSR_error,'m-',...
%     1:1:size(YaleB_LRSR_error,1),YaleB_LRSR_error,'k-',...
%     1:1:size(COIL_LRSR_error,1),COIL_USSR_error,'r:',...
%     1:1:size(ISOlet_USSR_error,1),ISOlet_USSR_error,'b:',...
%     1:1:size(MNIST_USSR_error,1),MNIST_USSR_error,'g:',...
%     1:1:size(PIE_USSR_error,1),PIE_USSR_error,'c:',...
%     1:1:size(USPS_USSR_error,1),USPS_USSR_error,'m:',...
%     1:1:size(YaleB_USSR_error,1),YaleB_USSR_error,'k:',...
%     'LineWidth',1.5);
% title('Real rank of W');
% xlabel('Dim','fontsize',12);
% ylabel('Error rate','fontsize',12);
% h_leg =legend('COIL for LRSR','ISOlet for LRSR','MNIST for LRSR','PIE for LRSR','USPS for LRSR','YaleB for LRSR',...
%     'COIL for USSR','ISOlet for USSR','MNIST for USSR','PIE for USSR','USPS for USSR','YaleB for USSR');
% % set(h_leg,'position',[0.14 0.75 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;

