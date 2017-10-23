% car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
% car_num=size(car_idx,2);
 % we set c from the cardinality set car_idx to calculate the error rate of each
% inter medium rank k ,under each c, and we evaluate the low-rank situation
% USSR_error=ones(car_num,1);

LRSR_result1=LRSR_result;

for i=2:2
    for j=5:5
       LRSR_result1{i,j}=LRSR_result{i,j};
     end
end
LRSR_result=LRSR_result1;
save PIE_LDA_67.mat LRSR_result USSR_error;
LRSR_error=ones(2,67);
for k = 1:67
    least_error=1;
    for i= 1:7
        for j= 1:7
            real_error_arr=LRSR_result{i,j};
            real_error=real_error_arr(k,1);
            real_k=real_error_arr(k,2);
            if(real_error<least_error)
                LRSR_error(1,k)=real_error;
                LRSR_error(2,k)=real_k;
                least_error=real_error;
            end
        end
    end
end
car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
LRSR_error=LRSR_error';
best_k=LRSR_error(:,2);
LRSR_error(:,2)=[];
save PIE_LPP_final.mat LRSR_result USSR_error LRSR_error car_idx car_idx
clear;clc;
