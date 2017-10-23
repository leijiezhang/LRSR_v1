clear;clc;tic;
% ============================================================================

%  set the options of SR algorithm
 options_sr=[];
 options_sr.ReguType = 'Ridge';
%  get all kinds of data of this trainning
 DataOptions=[];
 DataOptions.set_name='COIL';
 DataOptions.cross_validate=true;
 DataOptions.cv_fold=3;
 DataOptions.cv_num=1;
 [fea_Train,fea_Test,gnd_Train,gnd_Test,class_Num]=getData(DataOptions);
 %========================LDA======================
  % get the responses of X
options_w=[];
options_w.NeighborMode = 'Supervised';
options_w.k = 5;
options_w.bLDA=1;
options_w.gnd = gnd_Train;
 W = constructW(fea_Train,options_w);
  %set cardinality set
% car_idx=floor(linspace(1,200,20));
% car_idx=1:(10-1);
car_idx=[2:2:10,15:5:30,40:10:70,100:50:200];
car_num=size(car_idx,2);
coe_idx=-5:8;
LDA=zeros(car_num,size(coe_idx,2));
% load('COIL_error.mat');
for i=1:car_num
 % get the responses of X
    Y = Eigenmap(W,car_idx(i));
    printStr=strcat('===========cardinality:',num2str(car_idx(i)),'===========');
    disp(printStr);
    options_sr.W = W;
    for j=1:1:size(coe_idx,2)
        options_sr.ReguAlpha = 10^coe_idx(j);
        [eigvector] = SR(options_sr,Y,fea_Train);
        fea_Test_new = fea_Test*eigvector;
        fea_Train_new = fea_Train*eigvector;
        %kmeans clustering in the original space
        label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1); 
        [~, Error2] = Misclassification_error(gnd_Test,label);
        LDA(i,j)=Error2;
        printStr=strcat('SRerror rate',num2str(Error2));
        disp(printStr);
    end
end

 %========================LPP======================
  % get the responses of X
 W = constructW(fea_Train);

LPP=zeros(car_num,size(coe_idx,2));
for i=1:car_num
 % get the responses of X
    Y = Eigenmap(W,car_idx(i));
    printStr=strcat('===========cardinality:',num2str(car_idx(i)),'===========');
    disp(printStr);
    options_sr.W = W;
    for j=1:1:size(coe_idx,2)
        options_sr.ReguAlpha = 10^coe_idx(j);
        [eigvector] = SR(options_sr,Y,fea_Train);
        fea_Test_new = fea_Test*eigvector;
        fea_Train_new = fea_Train*eigvector;
        %kmeans clustering in the original space
        label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1); 
        [~, Error2] = Misclassification_error(gnd_Test,label);
        LPP(i,j)=Error2;
        printStr=strcat('SRerror rate',num2str(Error2));
        disp(printStr);
    end
end

save COIL_error_apt LDA LPP;
