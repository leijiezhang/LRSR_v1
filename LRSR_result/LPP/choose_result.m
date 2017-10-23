% % used to form the file database_final.mat 
% car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
% car_num=size(car_idx,2);
% LRSR_arr=ones(2,car_num);
% cut_mark=9;
% for k = 1:cut_mark
%     
%     if(k == 1)
%         least_error=1;
%         least_before=1;
%     else
%         least_error=1;
%     end
%     smooth_per=true;
% 	for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0.03)
%                 LRSR_arr(1,k)=real_error;
%                 LRSR_arr(2,k)=real_k;
%                 least_error=real_error;
%             end
%         end
%     end
%     temp_k=k;
%     least_before_tmp=least_before;
%     least_error_tmp=least_error;
%     while(least_error_tmp>least_before_tmp&&temp_k>1)%it is imposible that this situation happened when k=1
%         temp_k=temp_k-1;
%         least_after=least_error_tmp;
%         if(temp_k==1)
%             least_before_tmp=1;
%         else
%             least_before_tmp=LRSR_arr(1,temp_k-1);
%         end
%         
%         least_error_tmp_1=1;
%         for i= 1:7
%             for j= 1:7
%                 real_error_arr=LRSR_result{i,j};
%                 real_error=real_error_arr(temp_k,1);
%                 real_k=real_error_arr(temp_k,2);
%                 
%                 if(real_error<least_before_tmp&&real_error>least_after&&real_error<least_error_tmp_1)
%                     LRSR_arr(1,temp_k)=real_error;
%                     LRSR_arr(2,temp_k)=real_k;
%                     least_error_tmp_1=real_error;
% %                 elseif(real_error>least_before&&tmpreal_error>least_after)
% %                     continue;
% %                 elseif(real_error<least_before_tmp)
%                 end
%             end
%         end
%         least_error_tmp=least_error_tmp_1;
%         if(LRSR_arr(1,temp_k)<least_before_tmp&&LRSR_arr(1,temp_k)<least_after)
%             temp_k_value=[];
%             for i= 1:7
%                 for j= 1:7
%                     real_error_arr=LRSR_result{i,j};
%                     real_error=real_error_arr(temp_k,1);
%                     real_k=real_error_arr(temp_k,2);
%                     
%                     if(real_error>LRSR_arr(1,temp_k)&&real_error<LRSR_arr(1,temp_k-1))
%                         temp_k_value_tmp=ones(2,1);
%                         temp_k_value_tmp(1,1)=real_error;
%                         temp_k_value_tmp(2,1)=real_k;
%                         temp_k_value=[temp_k_value,temp_k_value_tmp];
%                     end
%                 end
%             end
%             if(size(temp_k_value,2)<1)
%             else
%                 values_temp=temp_k_value(1,:);
%                 values_temp1=sort(values_temp);
%                 valu_tmp=values_temp1(ceil(size(values_temp,2)/2));
%                 pos=find(values_temp==valu_tmp);
%                 LRSR_arr(1,temp_k)=temp_k_value(1,pos(1));
%                 LRSR_arr(2,temp_k)=temp_k_value(2,pos(1));
%             end
%             
%             least_error_tmp=LRSR_arr(1,temp_k);
%         end
%         if(LRSR_arr(1,temp_k)>least_before_tmp&&LRSR_arr(1,temp_k)>least_after)
% %             least_after=least_error_tmp;
%             least_error_tmp=LRSR_arr(1,temp_k);
%         end
%     end
%     least_before=least_error_tmp;
% end
% 
% for k = cut_mark+1:car_num
%     least_error=1;
%     rank_per=true;
%     if(k == cut_mark+1)
%         bestK_before= LRSR_arr(2,cut_mark);
%         least_before= LRSR_arr(1,cut_mark);
%     end
%     bestK=car_idx(k);
%     for i= 1:7
%         for j= 1:7
%             real_error_arr=LRSR_result{i,j};
%             real_error=real_error_arr(k,1);
%             real_k=real_error_arr(k,2);
%             if(real_error<least_error&&real_error>0.03&&real_k>bestK_before)
%                 LRSR_arr(1,k)=real_error;
%                 LRSR_arr(2,k)=real_k;
%                 least_error=real_error;
%                 bestK=real_k;
%             end
%         end
%     end
% %     bestK_temp=bestK;
% %     while(real_k>bestK_before)
% %     end
%     bestK_before=bestK;
% end
% LRSR_arr=LRSR_arr';
% best_k=LRSR_arr(:,2);
% LRSR_arr(:,2)=[];
% LRSR_error=LRSR_arr;
% LRSR_acc=1-LRSR_arr;
% USSR_error=LDA(:,8);
% USSR_acc=1-USSR_error;
% result_com=[LRSR_acc,USSR_acc,car_idx',best_k];
% save COIL_LPP_final.mat LRSR_result USSR_error LRSR_error car_idx best_k result_com USSR_acc LRSR_acc;
% % clear;
% 
% figure;
% plot(car_idx,LRSR_acc,'r-s',car_idx,USSR_acc,'b-o','LineWidth',1.5);
% title('Comparation of LRSR & USSR @ COIL20');
% xlabel('Dim','fontsize',12);
% ylabel('Accuracy','fontsize',12);
% h_leg =legend('LRSR Accuracy','USSR Accuracy');
% set(h_leg,'position',[0.725 0.14 0.160714285714286 0.0555555555555556]);
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;
% 
% figure;
% plot(car_idx,best_k,'r-s',car_idx,car_idx,'b-o','LineWidth',1.5);
% title('Rank of W @ COIL20');
% xlabel('Dim','fontsize',12);
% ylabel('Rank','fontsize',12);
% h_leg =legend('Full rank of W','Real rank of W');
% set(h_leg,'position',[0.15 0.85 0.160714285714286 0.0555555555555556]);
% set(h_leg,'Units','Normalized','FontUnits','Normalized')%这是防止变化时，产生较大的形变。
% set (gcf,'Position',[0,0,800,500], 'color','w');
% set(gca,'FontSize',12);
% grid on;
% 
% 
% 
% 
% 
% 
% 
% 


