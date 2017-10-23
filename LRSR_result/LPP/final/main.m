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
title('Comparation of LRSR & USSR @ COIL20');
xlabel('Dim','fontsize',12);
ylabel('Accuracy','fontsize',12);
h_leg =legend('LRSR Accuracy','USSR Accuracy');
set(h_leg,'position',[0.725 0.14 0.160714285714286 0.0555555555555556]);
set (gcf,'Position',[0,0,800,500], 'color','w');
set(gca,'FontSize',12);
grid on;

figure;
plot(car_idx,best_k,'r-s',car_idx,car_idx,'b-o','LineWidth',1.5);
title('Rank of W @ COIL20');
xlabel('Dim','fontsize',12);
ylabel('Rank','fontsize',12);
h_leg =legend('Full rank of W','Real rank of W');
set(h_leg,'position',[0.15 0.85 0.160714285714286 0.0555555555555556]);
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
% plot(car_idx,car_idx,'k:',...
%     car_idx,COIL_best_k,'r-s',...
%     car_idx,ISOlet_best_k,'b-x',...
%     car_idx,MNIST_best_k,'g-+',...
%     car_idx,PIE_best_k,'c-*',...
%     car_idx,USPS_best_k,'m-d',...
%     car_idx,YaleB_best_k,'y-p',...
%     'LineWidth',1.5);
% title('Real rank of W');
% xlabel('Dim','fontsize',12);
% ylabel('Accuracy','fontsize',12);
% h_leg =legend('Full rank','COIL','ISOlet','MNIST','PIE','USPS','YaleB');
% set(h_leg,'position',[0.14 0.75 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;
