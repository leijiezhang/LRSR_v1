class_num=26;
ii=2;
jj=5;
coe_idx=-3:3;
%set the trainning epoch
 options.training_epochs = 200;
 options.tol = 1e-6;%the tolerance of calculating cycles
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
 
  % get the responses of X
Y = Eigenmap(W,class_num-1);
[U,V]=objFun(options,Y,fea_Train,class_num-1);