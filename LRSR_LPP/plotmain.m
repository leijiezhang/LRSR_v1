% % output the error rate plot
% plot(errorArr(:,1),'-r');
% hold on;
% plot(errorArr(:,2),'-b');
% legend('�Լ���','SR');
% xlabel('ά��')
% ylabel('������')
% % output the k variation plot
% a=1:1:150;
% plot(a ,'-r');
% hold on;
% plot(k_best,'-b');
% legend('k==c','ά��k','location','northwest');
% xlabel('ά��c')
% ylabel('ά��k')
% % output the rank of U*V variation plot
% a=1:1:150;
% plot(a ,'-r');
% hold on;
% plot(S_num_arr,'-b');
% legend('rank=c','ʵ�ʵ���','location','northwest');
% xlabel('��ά��c')
% ylabel('ʵ�ʵ���')
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
