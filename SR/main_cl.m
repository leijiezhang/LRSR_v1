%Face clustering on PIE
clear;
load('PIE_pose27_v2.mat'); 

%Normalize each data vector to have L2-norm equal to 1  
fea = NormalizeFea(fea);

%kmeans clustering in the original space
rand('twister',5489);
label = litekmeans(fea,nClass,'Replicates',10,'Distance','cosine');
MIhat = MutualInfo(gnd,label)
%MIhat: 0.3941

%kmeans in the Laplacian Eigenmap subspace (Spectral Clustering)
rand('twister',5489);
W = constructW(fea);
Y = Eigenmap(W,nClass);
rand('twister',5489);
labelNew = litekmeans(Y,68,'Replicates',10,'Distance','cosine');
MIhatNew = MutualInfo(gnd,labelNew)
%MIhat: 0.6899

%Sparse Spectral Regression subspace learning (Sparse LPP)
USRoptions = [];
USRoptions.W = W;
USRoptions.ReguType = 'Lasso';
USRoptions.LASSOway = 'LARs';
USRoptions.ReguAlpha = 0.01;
USRoptions.ReducedDim = nClass;
USRoptions.LassoCardi = 50:10:250;
USRoptions.bCenter = 0;
model = USRtrain(fea, USRoptions);
feaNew = USRtest(fea, nClass, model);

%kmeans in the Sparse Spectral Regression subspace (Sparse LPP)
for i = 1:length(model.LassoCardi)
  rand('twister',5489);
  labelNew = litekmeans(feaNew{i},nClass,'Replicates',10,'Distance','cosine');
  MIhatNew = MutualInfo(gnd,labelNew);
  disp(['Sparse SR subspace, Cardi=',num2str(model.LassoCardi(i)),', MIhat: ',num2str(MIhatNew)]);
end

%Sparse SR subspace, Cardi=50, MIhat: 0.73313
%Sparse SR subspace, Cardi=60, MIhat: 0.76012
%Sparse SR subspace, Cardi=70, MIhat: 0.76716
%Sparse SR subspace, Cardi=80, MIhat: 0.76632
%Sparse SR subspace, Cardi=90, MIhat: 0.77407
%Sparse SR subspace, Cardi=100, MIhat: 0.77838
%Sparse SR subspace, Cardi=110, MIhat: 0.7972
%Sparse SR subspace, Cardi=120, MIhat: 0.78407
%Sparse SR subspace, Cardi=130, MIhat: 0.78408
%Sparse SR subspace, Cardi=140, MIhat: 0.78848
%Sparse SR subspace, Cardi=150, MIhat: 0.78051
%Sparse SR subspace, Cardi=160, MIhat: 0.77967
%Sparse SR subspace, Cardi=170, MIhat: 0.78357
%Sparse SR subspace, Cardi=180, MIhat: 0.77697
%Sparse SR subspace, Cardi=190, MIhat: 0.79725
%Sparse SR subspace, Cardi=200, MIhat: 0.78014
%Sparse SR subspace, Cardi=210, MIhat: 0.79001
%Sparse SR subspace, Cardi=220, MIhat: 0.76642
%Sparse SR subspace, Cardi=230, MIhat: 0.77602
%Sparse SR subspace, Cardi=240, MIhat: 0.77618
%Sparse SR subspace, Cardi=250, MIhat: 0.77628   