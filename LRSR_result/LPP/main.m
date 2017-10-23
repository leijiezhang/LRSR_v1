% car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
% car_num=size(car_idx,2);
 % we set c from the cardinality set car_idx to calculate the error rate of each
% inter medium rank k ,under each c, and we evaluate the low-rank situation
% USSR_error=ones(car_num,1);

% LRSR_result=LRSR_result1;
% 
% ==================================rank first: choose the best result===================
% dim=37;
% car_idx=(1:1:dim)';
% LRSR_error=ones(2,dim);
% for k = 1:dim
%     least_error=1;
%     perfect1=false;
%     rank_per=true;
%     for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0&&real_k<car_idx(k))
%                 LRSR_error(1,k)=real_error;
%                 LRSR_error(2,k)=real_k;
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
%                         rank_per=false;
%                     end
%                 end
%             end
%         end
%     end
%     error_befor=least_error;
% end
% 
% LRSR_error=LRSR_error';
% best_k=LRSR_error(:,2);
% LRSR_error(:,2)=[];
% result_com=[USSR_error,LRSR_error,car_idx,best_k];
% save YaleB__LDA_final.mat LRSR_result USSR_error LRSR_error car_idx best_k result_com;
% 
% %======plot the best choosen result======
% figure;
% subplot(1,2,1);
% plot(car_idx,LRSR_error,'r-o',car_idx,USSR_error,'b-*');
% subplot(1,2,2);
% plot(car_idx,car_idx,'b-s',car_idx,best_k,'r-d');
% % % clear;clc;

% ==================================smooth first: choose the best result===================
% dim=37;
% car_idx=(1:1:dim)';
% LRSR_error=ones(2,dim);
% for k = 1:dim
%     least_error=1;
%     perfect1=false;
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
% 
% LRSR_error=LRSR_error';
% best_k=LRSR_error(:,2);
% LRSR_error(:,2)=[];
% result_com=[USSR_error,LRSR_error,car_idx,best_k];
% save YaleB__LDA_final.mat LRSR_result USSR_error LRSR_error car_idx best_k result_com;
% 
% %======plot the best choosen result======
% figure;
% subplot(1,2,1);
% plot(car_idx,LRSR_error,'r-o',car_idx,USSR_error,'b-*');
% subplot(1,2,2);
% plot(car_idx,car_idx,'b-s',car_idx,best_k,'r-d');
% % % clear;clc;
% 
% % ==================================trade off: choose the best result===================
% 
% dim=37;
% car_idx=(1:1:dim)';
% LRSR_error=ones(2,dim);
% for k = 1:20
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
% for k = 20:dim
%     least_error=1;
%     rank_per=true;
%     for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0&&real_k<car_idx(k))
%                 LRSR_error(1,k)=real_error;
%                 LRSR_error(2,k)=real_k;
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
%                         rank_per=false;
%                     end
%                 end
%             end
%         end
%     end
%     error_befor=least_error;
% end
% 
% 
% LRSR_error=LRSR_error';
% best_k=LRSR_error(:,2);
% LRSR_error(:,2)=[];
% result_com=[USSR_error,LRSR_error,car_idx,best_k];
% save YaleB__LDA_final.mat LRSR_result USSR_error LRSR_error car_idx best_k result_com;
% 
% % ======plot the best choosen result======
% figure;
% subplot(1,2,1);
% plot(car_idx,LRSR_error,'r-o',car_idx,USSR_error,'b-*');
% subplot(1,2,2);
% plot(car_idx,car_idx,'b-s',car_idx,best_k,'r-d');
% grid on;
% clear;clc;


%========get all figure of each dataset with all posible of lambda1 and
% lambda2======

dim=67;
car_idx=(1:1:dim)';
k=7;
for i = 7:7
    LRSR_error=LRSR_result{k,i}(:,1);
    best_k=LRSR_result{k,i}(:,2);

    figure;
    subplot(1,2,1);
    plot(car_idx,LRSR_error,'r-o',car_idx,USSR_error,'b-*');
    subplot(1,2,2);
    plot(car_idx,car_idx,'b-s',car_idx,best_k,'r-d');
end
% USSR_error=LDA(:,12);


% car_idx=(1:1:dim)';

car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
LRSR_error=LRSR_result{7,7};
best_k=LRSR_error(:,2);
LRSR_error(:,2)=[];
LRSR_acc=1-LRSR_error;
USSR_acc=1-USSR_error;
result_com=[LRSR_acc,USSR_acc,car_idx,best_k];
save PIE_LDA_final.mat LRSR_result USSR_error LRSR_error car_idx best_k result_com USSR_acc LRSR_acc;

