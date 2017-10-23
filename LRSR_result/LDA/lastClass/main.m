LRSR_error=1;
best_k=200;
for i = 1:7
    for j = 1:7
        real_error_arr=LRSR_result{i,j};
        real_error=real_error_arr(1,1);
        real_k=real_error_arr(1,2);
        if(real_error<=LRSR_error&&real_error>0)
            LRSR_error=real_error;
            if(real_k<best_k&&LRSR_error==real_error)
                best_k=real_k;
            end
        end
    end
end
save YaleB__LDA_final.mat LRSR_result USSR_error LRSR_error best_k;
clear;
imagesc(W);
colorbar;

