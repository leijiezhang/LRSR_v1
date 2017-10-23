% get the rank analysis of each W ( from diffrent value of k and c)

class_num=26;
ii=2;
jj=5;
k=2;
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
 [fea_Train,fea_Test,gnd_Train,gnd_Test,class_Num]=getData(DataOptions);
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
[U,V]=objFun(options,Y,fea_Train,k);



W_info=[];
W=U*V;
[U_tmp,S,V_tmp]=svd(W);
S_count=diag(S);

S_count(K+1:end)=0;
S_num= find(S_count>0, 1, 'last' );
W=U_tmp(:,S_num)*V_tmp(S_num,:);
W_info.W=W;
W_info.S=S_count;

save ISOlet_Winfo_lda.mat Winfo_arr S_num_arr;

