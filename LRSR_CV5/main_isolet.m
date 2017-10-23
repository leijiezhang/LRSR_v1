clear;clc;tic;
% ============================================================================

%  set the options of SR algorithm
 options_sr=[];
 
 options_sr.ReguAlpha = 0.01;
 options_sr.ReguType = 'Ridge';
  % set the trainning options of leiSR
 options=[];
 options.lambda1=10^-2;
 options.lambda2=10^-1;
	% %set the trainning epoch
 options.training_epochs = 200;
 options.tol = 1e-2;%the tolerance of calculating cycles
 %  get all kinds of data of this trainning
 DataOptions=[];
 DataOptions.set_name='ISOlet';
 DataOptions.cross_validate=true;
 DataOptions.cv_fold=5;
%set intermediate rank set
class_num=26;
irank_idx=floor(class_num/2):class_num;
% car_idx=[car_idx,150:50:1024,1024];
irank_num=size(irank_idx,2);
% we set c from the cardinality set car_idx to calculate the error rate of each
% inter medium rank k ,under each c, and we evaluate the low-rank situation
 errorArr_LRSR=ones(irank_num,DataOptions.cv_fold);
 errorArr_USSR=ones(1,DataOptions.cv_fold);
 U_arr=cell(irank_num,DataOptions.cv_fold);
 V_arr=cell(irank_num,DataOptions.cv_fold);
% find the error rate among all the dimonsion reduction
printStr=strcat('===========class number:',num2str(class_num),'===========');
for j=1:DataOptions.cv_fold
    
    tic;
    DataOptions.cv_num=j;
    [fea_Train,fea_Test,gnd_Train,gnd_Test,class_Num]=getData(DataOptions);

    printStr=strcat('===========Cross validation number:',num2str(j),'===========');    disp(printStr);
    % get the responses of X
    options_w=[];
    options_w.NeighborMode = 'KNN';
    options_w.k = 5;
    %if we use LPP mode
    %     options_w.WeightMode = 'HeatKernel';
    %if we use NPE mode
    options_w.WeightMode = 'NPE';
    W = constructW(fea_Train,options_w);
    Y = Eigenmap(W,class_num-1);
    for i=1:irank_num
    
        % ===================leiSR way to reduct the dimension==========
        [U,V]=objFun(options,Y,fea_Train,irank_idx(i));
        fea_Test_new = fea_Test*U*V;
        fea_Train_new = fea_Train*U*V;
        label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1);
        clear fea_Test_new fea_Train_new;
        [~, Error1] = Misclassification_error(gnd_Test,label);
        clear label;
        printStr=strcat('inter medium rank:',num2str...
            (irank_idx(i)),'==>error rate:',num2str(Error1));
        disp(printStr); 
        errorArr_LRSR(i,j)=Error1;
        U_arr{i,j}=U;
        V_arr{i,j}=V;
        clear U V;
        clear Error1;
    end

    % ===================SR way to reduct the dimension==========
    options_sr.W = W;
    [eigvector] = SR(options_sr,Y,fea_Train);
	fea_Test_new = fea_Test*eigvector;
	fea_Train_new = fea_Train*eigvector;
    clear eigvector;
	%kmeans clustering in the original space
	rand('twister',5489);
    label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1);
    clear fea_Test_new fea_Train_new;
	[~, Error2] = Misclassification_error(gnd_Test,label);
    errorArr_USSR(1,j)=Error2;
	printStr=strcat('SRerror rate',num2str(Error2));
    clear Error2;
	disp(printStr);
    clear W Y;
    toc;
end
save -v7.3 ISOlet_NPE.mat errorArr_LRSR errorArr_USSR U_arr V_arr;
toc;