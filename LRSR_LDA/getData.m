function [fea_Train,fea_Test,gnd_Train,gnd_Test,n_class]=getData(DataOptions)
% getData:get mornal method to get data for the latter opration
% inputs:
%          DataOptions: the option that decided which dataset is chosen
%                   set_name: the name  of dataset
%                   train_size: the trainning size of each class of chosen dataset
%                   train_rate: the rate of data who is uesed for trainning
%          train_Size: the trainning size of each class subject
% outputs: 
%          fea_Train: the trainning data
%          fea_Test: the lable of trainning data
%          gnd_Train: the test data
%          gnd_Test: the lable of test data
%          class_Num: the number of class of the data
% write by leijie @ 2017/6/29

% pre-opration: deal with the DataOptions.
if ~exist('DataOptions','var')
    DataOptions=[];
end
% initiate the trainning size of each class

if isfield(DataOptions,'train_size')
    train_size=DataOptions.train_size;
end
% initiate the trainning rate of each class
train_rate=0.5;
if isfield(DataOptions,'train_rate')
    train_rate=DataOptions.train_rate;
end

%if we use x-fold cross validate
cross_validate=false;
if isfield(DataOptions,'cross_validate')
    cross_validate=DataOptions.cross_validate;
    cv_fold=DataOptions.cv_fold;
    cv_num=DataOptions.cv_num;
end

set_name=lower('PIE');
if isfield(DataOptions,'set_name')
    set_name=lower(DataOptions.set_name);
end
% load dataset corresponse to custom experiment 
switch lower(set_name)
    case {lower('PIE')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\PIE_all.mat');
    case {lower('UMIST')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\UMIST.mat');
    case {lower('YaleB')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\YaleB_32x32.mat');
    case {lower('MNIST')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\MNISTOrig.mat');
    case {lower('Yale')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\Yale_32x32.mat');
     case {lower('COIL')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\coil20.mat');
     case {lower('ISOlet')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\ISOlet.mat');
     case {lower('USPS')}
        load('F:\WrokSpace\Matlab\LRSR_paper\LRSR_LDA\datasets\usps.mat');
     otherwise
        error('Dataset does not exist!');
end

%get the class number of each class
label=unique(gnd);
n_smpl=size(fea,1);
n_fea=size(fea,2);
n_class=size(label,1);%the number of class
%disorder the dataset 
fea_Temp=[];
gnd_Temp=[];
for i=1:n_class
    labelIdx=find(gnd==label(i));
    n_smpl_perC=size(labelIdx,1);
    %disorder each part of data
    rand('twister',5483);
    rand_idx=randperm(n_smpl_perC);
    labelIdx=labelIdx(rand_idx);
    fea_Temp_tmp=fea(labelIdx,:);
    fea_Temp=[fea_Temp;fea_Temp_tmp];
    gnd_Temp_tmp=gnd(labelIdx,:);
    gnd_Temp=[gnd_Temp;gnd_Temp_tmp];
end
fea=fea_Temp;
gnd=gnd_Temp;
n_smpl_perC=ones(n_class,1);
for i=1:n_class
    n_smpl_perC(i,1)=size(find(gnd==label(i)),1);
end

if cross_validate
    fea_Train=[];
    gnd_Train=[];
    fea_Test=[];
    gnd_Test=[];
    test_rate=1/cv_fold;
    for i=1:n_class
        labelIdx=find(gnd==label(i));
        n_smpl_perC=size(labelIdx,1);
        test_size=floor(n_smpl_perC*test_rate);
        
        fea_Test_tmp=fea(labelIdx((cv_num-1)+1:(cv_num-1)+test_size),:);
        fea_Test=[fea_Test;fea_Test_tmp];
        fea_Train_tmp=fea(labelIdx,:);
        fea_Train_tmp((cv_num-1)+1:(cv_num-1)+test_size,:)=[];
        fea_Train=[fea_Train;fea_Train_tmp];
        
        gnd_Test_tmp=gnd(labelIdx((cv_num-1)+1:(cv_num-1)+test_size),:);
        gnd_Test=[gnd_Test;gnd_Test_tmp];
        gnd_Train_tmp=gnd(labelIdx,:);
        gnd_Train_tmp((cv_num-1)+1:(cv_num-1)+test_size,:)=[];
        gnd_Train=[gnd_Train;gnd_Train_tmp];
    end
else
    if exist('train_size','var')
        if train_size>=min(n_smpl_perC)
            error('trainning size overflows the sample number!');
        else
            fea_Train=zeros(train_size*n_class,n_fea);
            gnd_Train=zeros(train_size*n_class,1);
            fea_Test=zeros(n_smpl-train_size*n_class,n_fea);
            gnd_Test=zeros(n_smpl-train_size*n_class,1);
        
            n_train_tmp=0;
            for i=1:n_class
                gnd_Train((i-1)*train_size+1:i*train_size)=label(i);
                n_test_perC=n_smpl_perC(i,1)-train_size;
                gnd_Test(n_train_tmp+1:n_train_tmp+n_test_perC)=label(i);
                labelIdx=find(gnd==label(i));
                fea_Train((i-1)*train_size+1:i*train_size,:)=fea(labelIdx(1:train_size),:);
                fea_Test(n_train_tmp+1:n_train_tmp+n_test_perC,:)=fea(labelIdx(train_size+1:train_size+n_test_perC),:);
                n_train_tmp =n_train_tmp+ n_test_perC;
            end
        end
    else
        fea_Train=[];
        gnd_Train=[];
        fea_Test=[];
        gnd_Test=[];
        for i=1:n_class
            labelIdx=find(gnd==label(i));
            n_smpl_perC=size(labelIdx,1);
            %disorder each part of data
            rand('twister',5484);
            rand_idx=randperm(n_smpl_perC);
            labelIdx=labelIdx(rand_idx);
            train_size=floor(n_smpl_perC*train_rate);
            fea_Train_tmp=fea(labelIdx(1:train_size),:);
            fea_Train=[fea_Train;fea_Train_tmp];
            fea_Test_tmp=fea(labelIdx(train_size+1:n_smpl_perC),:);
            fea_Test=[fea_Test;fea_Test_tmp];
        
            gnd_Train_tmp=gnd(labelIdx(1:train_size),:);
            gnd_Train=[gnd_Train;gnd_Train_tmp];
            gnd_Test_tmp=gnd(labelIdx(train_size+1:n_smpl_perC),:);
            gnd_Test=[gnd_Test;gnd_Test_tmp];
        end
    end
end
 %disorder the examples
    rand('twister',5485);
    dis_idx=randperm(size(fea_Train,1));
    fea_Train=fea_Train(dis_idx,:);
    gnd_Train=gnd_Train(dis_idx,:);
    rand('twister',5486);
    dis_idx=randperm(size(fea_Test,1));
    fea_Test=fea_Test(dis_idx,:);
    gnd_Test=gnd_Test(dis_idx,:);






