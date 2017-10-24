% get the rank analysis of each W ( from diffrent value of k and c)

class_num=26;
ii=5;
jj=5;
k_num=24;
coe_idx=-3:3;
%set the trainning epoch
 options.training_epochs = 200;
 options.tol = 1e-2;%the tolerance of calculating cycles
 options.lambda1=10^coe_idx(ii);
 options.lambda2=10^coe_idx(jj);
 %  get all kinds of data of this trainning
 DataOptions=[];
 DataOptions.set_name='ISOlet';
 DataOptions.cross_validate=true;
 DataOptions.cv_fold=3;
 DataOptions.cv_num=1;
 [fea_Train,fea_Test,gnd_Train,gnd_Test,~]=getData(DataOptions);
 % get the responses of X
 options_w=[];
options_w.NeighborMode = 'Supervised';
options_w.k = 5;
options_w.bLDA=1;
options_w.gnd = gnd_Train;
W = constructW(fea_Train,options_w);
% W = constructW(fea_Train);
 
  % get the responses of X
Y = Eigenmap(W,class_num-1);
[U,V]=objFun(options,Y,fea_Train,k_num);



W_info=[];
W=U*V;
[U_tmp,S,V_tmp]=svd(W);
S_count=diag(S);

S_count(k_num+1:end)=0;

W=U_tmp(:,k_num)*V_tmp(k_num,:);
W_info.W=W;
W_info.S=S_count;
figure;
plot(1:(class_num-1),S_count,'b-o','LineWidth',1.5);
xlabel('Index of Singular Value','fontsize',12);
ylabel('Singular Value','fontsize',12);
set (gcf,'Position',[0,0,800,500], 'color','w');
save ISOlet_Winfo_lda.mat W_info;

title('');