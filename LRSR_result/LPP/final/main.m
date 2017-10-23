% COIL_LRSR_error=LRSR_error;
% COIL_USSR_error=USSR_error;
% COIL_best_k=best_k;
% 
% CMU PIE_LRSR_error=LRSR_error;
% CMU PIE_USSR_error=USSR_error;
% CMU PIE_best_k=best_k;
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
title('Comparation of LRSR & USSR @ CMU PIE');
xlabel('Dim','fontsize',12);
ylabel('Accuracy','fontsize',12);
h_leg =legend('LRSR Accuracy','USSR Accuracy');
set(h_leg,'position',[0.725 0.14 0.160714285714286 0.0555555555555556]);
set (gcf,'Position',[0,0,800,500], 'color','w');
set(gca,'FontSize',12);
grid on;

figure;
plot(car_idx,best_k,'r-s',car_idx,car_idx,'b-o','LineWidth',1.5);
title('Rank of W @ CMU PIE');
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
%     car_idx,CMU PIE_best_k,'b-x',...
%     car_idx,MNIST_best_k,'g-+',...
%     car_idx,PIE_best_k,'c-*',...
%     car_idx,USPS_best_k,'m-d',...
%     car_idx,YaleB_best_k,'y-p',...
%     'LineWidth',1.5);
% title('Real rank of W');
% xlabel('Dim','fontsize',12);
% ylabel('Accuracy','fontsize',12);
% h_leg =legend('Full rank','COIL','CMU PIE','MNIST','PIE','USPS','YaleB');
% set(h_leg,'position',[0.14 0.75 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;

% car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
% car_num=size(car_idx,2);
% % ==================================trade off: choose the best result===================


% LRSR_error=ones(2,car_num);
% for k = 1:8
%     least_error=1;
%     smooth_per=true;
%     error_befor=1;
%     for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0&&real_error<error_befor)
%                 LRSR_error(1,k)=real_error;
%                 LRSR_error(2,k)=real_k;
%                 least_error=real_error;
%                 smooth_per=false;
%             end
%         end
%     end
%     if(smooth_per)
%         rank_per=true;
%         for i= 1:7
%             for j= 1:7
%                 real_error_arr=LRSR_result{i,j};
%                 real_error=real_error_arr(k,1);
%                 real_k=real_error_arr(k,2);
%                 if(real_error<least_error&&real_error>0&&real_k<car_idx(k))
%                     LRSR_error(1,k)=real_error;
%                     LRSR_error(2,k)=real_k;
%                     least_error=real_error;
%                     rank_per=false;
%                 end
%             end
%         end
%         if(rank_per)
%             for i= 1:7
%                 for j= 1:7
%                     real_error_arr=LRSR_result{i,j};
%                     real_error=real_error_arr(k,1);
%                     real_k=real_error_arr(k,2);
%                     if(real_error<least_error&&real_error>0)
%                         LRSR_error(1,k)=real_error;
%                         LRSR_error(2,k)=real_k;
%                         least_error=real_error;
%                         rank_per=false;
%                     end
%                 end
%             end
%         end
%     end
%     error_befor=least_error;
% end
% for k = 8:car_num
%     least_error=1;
%     rank_per=true;
%     k_befor=20;
%     for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0&&real_k<car_idx(k)&&real_k>k_befor)
%                 LRSR_error(1,k)=real_error;
%                 LRSR_error(2,k)=real_k;
%                  k_least=real_k;
%                 least_error=real_error;
%                 rank_per=false;
%             end
%         end
%     end
%     if(rank_per)
%         smooth_per=true;
%         for i= 1:7
%             for j= 1:7
%                 error_befor=1;
%                 real_error_arr=LRSR_result{i,j};
%                 real_error=real_error_arr(k,1);
%                 real_k=real_error_arr(k,2);
%                 if(real_error<least_error&&real_error>0&&real_error<error_befor)
%                     LRSR_error(1,k)=real_error;
%                     LRSR_error(2,k)=real_k;
%                     least_error=real_error;
%                     k_least=real_k;
%                     rank_per=false;
%                     smooth_per=false;
%                 end
%             end
%         end
%         if(smooth_per)
%             for i= 1:7
%                 for j= 1:7
%                     real_error_arr=LRSR_result{i,j};
%                     real_error=real_error_arr(k,1);
%                     real_k=real_error_arr(k,2);
%                     if(real_error<least_error&&real_error>0)
%                         LRSR_error(1,k)=real_error;
%                         LRSR_error(2,k)=real_k;
%                         least_error=real_error;
%                         k_least=real_k;
%                         rank_per=false;
%                     end
%                 end
%             end
%         end
%     end
%     error_befor=least_error;
%     k_befor=k_least;
% end

