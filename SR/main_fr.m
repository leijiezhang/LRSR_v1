%Face recognition on PIE
clear;
load('PIE_pose27_v2.mat'); 
 
%Normalize each data vector to have L2-norm equal to 1  
fea = NormalizeFea(fea);

%Generate Train/Test split
nSmp = size(fea,1); 
rand('twister',5489);
randIdx = randperm(nSmp);
fea = fea(randIdx,:);
gnd = gnd(randIdx);

%Training SRDA with L2-regularization
nTrainList = [floor(nSmp/3) floor(nSmp/2) floor(2*nSmp/3)];
options = [];
options.ReguType = 'Ridge';
options.ReguAlpha = 0.01;
for nTrain = nTrainList
  model = SRDAtrain(fea(1:nTrain,:), gnd(1:nTrain), options);
  accuracy = SRDApredict(fea(nTrain+1:end,:), gnd(nTrain+1:end), model);
  disp(['SRDA,',num2str(nTrain),' Train, NC Errorrate: ',num2str(1-accuracy)]);

  feaTrain = SRDAtest(fea(1:nTrain,:), model);
  feaTest = SRDAtest(fea(nTrain+1:end,:), model);
  gndTrain = gnd(1:nTrain);
  gndTest = gnd(nTrain+1:end);
  D = EuDist2(feaTest,feaTrain,0);
  [dump,idx] = min(D,[],2);
  predictlabel = gndTrain(idx);
  errorrate = length(find(predictlabel-gndTest))/length(gndTest);
  disp(['SRDA,',num2str(nTrain),' Train, NN Errorrate: ',num2str(errorrate)]);
end
%SRDA,1109 Train, NC Errorrate: 0.030631
%SRDA,1109 Train, NN Errorrate: 0.029279
%SRDA,1664 Train, NC Errorrate: 0.024024
%SRDA,1664 Train, NN Errorrate: 0.022222
%SRDA,2219 Train, NC Errorrate: 0.01982 
%SRDA,2219 Train, NN Errorrate: 0.01982 

%Training SRDA with L1-regularization (use LARs), (Sparse LDA)  
options = [];
options.ReguType = 'Lasso';
options.LASSOway = 'LARs';
options.ReguAlpha = 0.001;
options.LassoCardi = 50:10:200;

nTrain = floor(nSmp/3);
model = SRDAtrain(fea(1:nTrain,:), gnd(1:nTrain), options);
%Use nearest center classifer
accuracy = SRDApredict(fea(nTrain+1:end,:), gnd(nTrain+1:end), model);
for i = 1:length(model.LassoCardi)
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NC Errorrate: ',num2str(1-accuracy(i))]);
end
%Sparse SRDA,1109 Train, Cardi=50 NC Errorrate: 0.059009
%Sparse SRDA,1109 Train, Cardi=60 NC Errorrate: 0.05045
%Sparse SRDA,1109 Train, Cardi=70 NC Errorrate: 0.045946
%Sparse SRDA,1109 Train, Cardi=80 NC Errorrate: 0.040991
%Sparse SRDA,1109 Train, Cardi=90 NC Errorrate: 0.040541
%Sparse SRDA,1109 Train, Cardi=100 NC Errorrate: 0.037838
%Sparse SRDA,1109 Train, Cardi=110 NC Errorrate: 0.034234
%Sparse SRDA,1109 Train, Cardi=120 NC Errorrate: 0.033784
%Sparse SRDA,1109 Train, Cardi=130 NC Errorrate: 0.033784
%Sparse SRDA,1109 Train, Cardi=140 NC Errorrate: 0.033333
%Sparse SRDA,1109 Train, Cardi=150 NC Errorrate: 0.031081
%Sparse SRDA,1109 Train, Cardi=160 NC Errorrate: 0.030631
%Sparse SRDA,1109 Train, Cardi=170 NC Errorrate: 0.030631
%Sparse SRDA,1109 Train, Cardi=180 NC Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=190 NC Errorrate: 0.028378
%Sparse SRDA,1109 Train, Cardi=200 NC Errorrate: 0.027928

%Use nearest neighbor classifer
feaTrainAll = SRDAtest(fea(1:nTrain,:), model);
feaTestAll = SRDAtest(fea(nTrain+1:end,:), model);
gndTrain = gnd(1:nTrain);
gndTest = gnd(nTrain+1:end);
for i = 1:length(model.LassoCardi)
  feaTrain = feaTrainAll{i};
  feaTest = feaTestAll{i};
  D = EuDist2(feaTest,feaTrain,0);
  [dump,idx] = min(D,[],2);
  predictlabel = gndTrain(idx);
  errorrate = length(find(predictlabel-gndTest))/length(gndTest);
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NN Errorrate: ',num2str(errorrate)]);
end
%Sparse SRDA,1109 Train, Cardi=50 NN Errorrate: 0.031532
%Sparse SRDA,1109 Train, Cardi=60 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=70 NN Errorrate: 0.029279
%Sparse SRDA,1109 Train, Cardi=80 NN Errorrate: 0.03018
%Sparse SRDA,1109 Train, Cardi=90 NN Errorrate: 0.029279
%Sparse SRDA,1109 Train, Cardi=100 NN Errorrate: 0.027928
%Sparse SRDA,1109 Train, Cardi=110 NN Errorrate: 0.028378
%Sparse SRDA,1109 Train, Cardi=120 NN Errorrate: 0.03018
%Sparse SRDA,1109 Train, Cardi=130 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=140 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=150 NN Errorrate: 0.029279
%Sparse SRDA,1109 Train, Cardi=160 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=170 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=180 NN Errorrate: 0.028829
%Sparse SRDA,1109 Train, Cardi=190 NN Errorrate: 0.028378
%Sparse SRDA,1109 Train, Cardi=200 NN Errorrate: 0.028378

nTrain = floor(nSmp/2);
model = SRDAtrain(fea(1:nTrain,:), gnd(1:nTrain), options);
%Use nearest center classifer
accuracy = SRDApredict(fea(nTrain+1:end,:), gnd(nTrain+1:end), model);
for i = 1:length(model.LassoCardi)
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NC Errorrate: ',num2str(1-accuracy(i))]);
end
%Sparse SRDA,1664 Train, Cardi=50 NC Errorrate: 0.048649
%Sparse SRDA,1664 Train, Cardi=60 NC Errorrate: 0.042643
%Sparse SRDA,1664 Train, Cardi=70 NC Errorrate: 0.039039
%Sparse SRDA,1664 Train, Cardi=80 NC Errorrate: 0.034234
%Sparse SRDA,1664 Train, Cardi=90 NC Errorrate: 0.030631
%Sparse SRDA,1664 Train, Cardi=100 NC Errorrate: 0.028829
%Sparse SRDA,1664 Train, Cardi=110 NC Errorrate: 0.027027
%Sparse SRDA,1664 Train, Cardi=120 NC Errorrate: 0.025225
%Sparse SRDA,1664 Train, Cardi=130 NC Errorrate: 0.023423
%Sparse SRDA,1664 Train, Cardi=140 NC Errorrate: 0.023423
%Sparse SRDA,1664 Train, Cardi=150 NC Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=160 NC Errorrate: 0.022222
%Sparse SRDA,1664 Train, Cardi=170 NC Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=180 NC Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=190 NC Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=200 NC Errorrate: 0.021622

%Use nearest neighbor classifer
feaTrainAll = SRDAtest(fea(1:nTrain,:), model);
feaTestAll = SRDAtest(fea(nTrain+1:end,:), model);
gndTrain = gnd(1:nTrain);
gndTest = gnd(nTrain+1:end);
for i = 1:length(model.LassoCardi)
  feaTrain = feaTrainAll{i};
  feaTest = feaTestAll{i};
  D = EuDist2(feaTest,feaTrain,0);
  [dump,idx] = min(D,[],2);
  predictlabel = gndTrain(idx);
  errorrate = length(find(predictlabel-gndTest))/length(gndTest);
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NN Errorrate: ',num2str(errorrate)]);
end
%Sparse SRDA,1664 Train, Cardi=50 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=60 NN Errorrate: 0.02042
%Sparse SRDA,1664 Train, Cardi=70 NN Errorrate: 0.02042
%Sparse SRDA,1664 Train, Cardi=80 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=90 NN Errorrate: 0.01982
%Sparse SRDA,1664 Train, Cardi=100 NN Errorrate: 0.019219
%Sparse SRDA,1664 Train, Cardi=110 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=120 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=130 NN Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=140 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=150 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=160 NN Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=170 NN Errorrate: 0.021622
%Sparse SRDA,1664 Train, Cardi=180 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=190 NN Errorrate: 0.021021
%Sparse SRDA,1664 Train, Cardi=200 NN Errorrate: 0.021021

nTrain = floor(2*nSmp/3);
model = SRDAtrain(fea(1:nTrain,:), gnd(1:nTrain), options);
%Use nearest center classifer
accuracy = SRDApredict(fea(nTrain+1:end,:), gnd(nTrain+1:end), model);
for i = 1:length(model.LassoCardi)
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NC Errorrate: ',num2str(1-accuracy(i))]);
end
%Sparse SRDA,2219 Train, Cardi=50 NC Errorrate: 0.041441
%Sparse SRDA,2219 Train, Cardi=60 NC Errorrate: 0.033333
%Sparse SRDA,2219 Train, Cardi=70 NC Errorrate: 0.028829
%Sparse SRDA,2219 Train, Cardi=80 NC Errorrate: 0.028829
%Sparse SRDA,2219 Train, Cardi=90 NC Errorrate: 0.028829
%Sparse SRDA,2219 Train, Cardi=100 NC Errorrate: 0.028829
%Sparse SRDA,2219 Train, Cardi=110 NC Errorrate: 0.021622
%Sparse SRDA,2219 Train, Cardi=120 NC Errorrate: 0.018919
%Sparse SRDA,2219 Train, Cardi=130 NC Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=140 NC Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=150 NC Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=160 NC Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=170 NC Errorrate: 0.018919
%Sparse SRDA,2219 Train, Cardi=180 NC Errorrate: 0.018919
%Sparse SRDA,2219 Train, Cardi=190 NC Errorrate: 0.018919
%Sparse SRDA,2219 Train, Cardi=200 NC Errorrate: 0.018919

%Use nearest neighbor classifer
feaTrainAll = SRDAtest(fea(1:nTrain,:), model);
feaTestAll = SRDAtest(fea(nTrain+1:end,:), model);
gndTrain = gnd(1:nTrain);
gndTest = gnd(nTrain+1:end);
for i = 1:length(model.LassoCardi)
  feaTrain = feaTrainAll{i};
  feaTest = feaTestAll{i};
  D = EuDist2(feaTest,feaTrain,0);
  [dump,idx] = min(D,[],2);
  predictlabel = gndTrain(idx);
  errorrate = length(find(predictlabel-gndTest))/length(gndTest);
  disp(['Sparse SRDA,',num2str(nTrain),' Train, Cardi=',num2str(model.LassoCardi(i)),' NN Errorrate: ',num2str(errorrate)]);
end
%Sparse SRDA,2219 Train, Cardi=50 NN Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=60 NN Errorrate: 0.016216
%Sparse SRDA,2219 Train, Cardi=70 NN Errorrate: 0.016216
%Sparse SRDA,2219 Train, Cardi=80 NN Errorrate: 0.016216
%Sparse SRDA,2219 Train, Cardi=90 NN Errorrate: 0.017117
%Sparse SRDA,2219 Train, Cardi=100 NN Errorrate: 0.017117
%Sparse SRDA,2219 Train, Cardi=110 NN Errorrate: 0.016216
%Sparse SRDA,2219 Train, Cardi=120 NN Errorrate: 0.016216
%Sparse SRDA,2219 Train, Cardi=130 NN Errorrate: 0.017117
%Sparse SRDA,2219 Train, Cardi=140 NN Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=150 NN Errorrate: 0.017117
%Sparse SRDA,2219 Train, Cardi=160 NN Errorrate: 0.017117
%Sparse SRDA,2219 Train, Cardi=170 NN Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=180 NN Errorrate: 0.018018
%Sparse SRDA,2219 Train, Cardi=190 NN Errorrate: 0.018919
%Sparse SRDA,2219 Train, Cardi=200 NN Errorrate: 0.018018