clear;clc;tic;
%  get all kinds of data of this trainning
DataOptions=[];
DataOptions.set_name='UMIST';
[fea_Train,fea_Test,gnd_Train,gnd_Test,class_Num]=getData(DataOptions);
errorArr=ones(class_Num,1);
V_rec_cell=cell(class_Num,1);
U_rec_cell=cell(class_Num,1);
para_best=ones(class_Num,3);
% find the error rate among all the k condition under all dimonsion reduction
for k=1:class_Num
    printStr=strcat('===========k:',num2str(k),'===========');
	disp(printStr);
    W = constructW(fea_Train);
    Y = Eigenmap(W,class_Num-1);
    for i=-3:-1
        for j=-3:-1
            % set the trainning options of leiSR
            options=[];
            options.lambda1=10^i;
            options.lambda2=10^j;
            % %set the trainning epoch
            options.training_epochs = 200;
            options.tol = 1e-5;%the tolerance of calculating cycles
            [U,V]=objFun(options,Y,fea_Train,k);
            fea_Test_new = fea_Test*U*V;
            fea_Train_new = fea_Train*U*V;
            
            label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1);
            clear fea_Test_new fea_Train_new;
            [~, Error1] = Misclassification_error(gnd_Test,label);
            clear label;
            printStr=strcat('i:',num2str(i),'j:',num2str(j),'´íÎóÂÊ:',num2str(Error1));
            disp(printStr);
            if Error1<para_best(k,3)
                para_best(k,1)=i;
                para_best(k,2)=j;
                para_best(k,3)=Error1;
                V_rec_cell{k,1}=V;
                U_rec_cell{k,1}=U;
            end
            clear U V;
            clear Error1;
        end
    end  
end
save MNIST_result.mat V_rec_cell U_rec_cell para_best;
