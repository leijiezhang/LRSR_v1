% h=figure;
% LRSR_error=errorArr(:,1);
% USSL_error=errorArr(:,2);
% %set cardinality set
% car_idx=10:10:100;
% car_idx=[car_idx,150:50:1024,1024];
% car_idx=car_idx';
% plot(car_idx,LRSR_error,'rs-');
% hold on;
% plot(car_idx,USSL_error,'bo-');
% xlabel('Dim');
% ylabel('Error rate (%)');
% title('Comparition of LRSR & USSL @ NPE');
% legend('LRSR','USSL');
% saveas(h,'Yale_npe_67.fig');

% h=figure;
% %set cardinality set
% plot(car_idx,k_best,'rs-');
% hold on;
% plot(car_idx,car_idx,'bo-');
% xlabel('Dim');
% ylabel('Rank num');
% title('Comparition of LRSR & USSL @ NPE');
% legend('low rank','full rank');
% saveas(h,'YaleB_lpp_rank_67.fig');
errorArr_LRSR(end,:) = [];
errorArr_USSR(end) = [];

errorArr_LRSR_mean=mean(errorArr_LRSR,2);
errorArr_LRSR_std = std(errorArr_LRSR,1,2);
[errorArr_LRSR_min,min_pos_row] = min(errorArr_LRSR_mean);
[errorArr_LRSR_min_all,min_pos_col] =  min(errorArr_LRSR(min_pos_row,:));

errorArr_USSR_mean = mean(errorArr_USSR);
errorArr_USSR_min = min(errorArr_USSR);

U_best = U_arr{min_pos_row,min_pos_col};
V_best = V_arr{min_pos_row,min_pos_col};

W = U_best*V_best;
[~,S,~] = svd(W,'econ');
S = diag(S);
S_orig = S;
S(find(abs(S)<max(S)/50))=0;

save YaleB_NPE.mat *;
clear;





