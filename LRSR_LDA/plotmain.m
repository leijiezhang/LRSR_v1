% % output the error rate plot
% plot(errorArr(:,1),'-r');
% hold on;
% plot(errorArr(:,2),'-b');
% legend('自己的','SR');
% xlabel('维度')
% ylabel('错误率')
% % output the k variation plot
% a=1:1:150;
% plot(a ,'-r');
% hold on;
% plot(k_best,'-b');
% legend('k==c','维度k','location','northwest');
% xlabel('维度c')
% ylabel('维度k')
% % output the rank of U*V variation plot
% a=1:1:150;
% plot(a ,'-r');
% hold on;
% plot(S_num_arr,'-b');
% legend('rank=c','实际的秩','location','northwest');
% xlabel('降维度c')
% ylabel('实际的秩')
% % plot the W img
% imshow(W, [min(min(W)), max(max(W))]);

errorArr=para_best(:,3);
nArr=size(errorArr,1)-1;
correctArr=zeros(nArr,1);
referArr=zeros(nArr,1);
for i=1:nArr
    correctArr(i,1)=1-errorArr(i,1);
    referArr(i,1)=1-errorArr(nArr+1,1);
end
plot(referArr(:,1),'-r');
hold on;
plot(correctArr(:,1),'-b');
legend('full rank','low rank','location','southeast');
xlabel('the number of rank k')
ylabel('the classification acc')
title('Yale');
