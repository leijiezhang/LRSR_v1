clear;clc;tic;
% ============================================================================

%  set the options of SR algorithm
 options_sr=[];
 
 options_sr.ReguAlpha = 0.01;
 options_sr.ReguType = 'Ridge';
 coe_idx=-3:3;
 %set cardinality set
% car_idx=floor(linspace(1,200,20));
car_idx=1:(10-1);
car_num=size(car_idx,2);
 % we set c from the cardinality set car_idx to calculate the error rate of each
% inter medium rank k ,under each c, and we evaluate the low-rank situation
USSR_error=ones(car_num,1);

LRSR_result=cell(7,7);

 % set the trainning options of leiSR
 options=[];
 
	% %set the trainning epoch
 options.training_epochs = 200;
 options.tol = 1e-2;%the tolerance of calculating cycles
 %  get all kinds of data of this trainning
 DataOptions=[];
 DataOptions.set_name='USPS';
 DataOptions.cross_validate=true;
 DataOptions.cv_fold=3;
 DataOptions.cv_num=1;
 [fea_Train,fea_Test,gnd_Train,gnd_Test,class_Num]=getData(DataOptions);

 %tricker if SR code running 
 is_SR_run=1;
 % get the responses of X
 options_w=[];
options_w.NeighborMode = 'Supervised';
options_w.k = 5;
options_w.bLDA=1;
options_w.gnd = gnd_Train;
 W = constructW(fea_Train,options_w);
 % find the error rate among all the dimonsion reduction

for ii=1:size(coe_idx,2)
    for jj=1:size(coe_idx,2)
        LRSR_error=ones(car_num,2);
        for i=1:car_num
            tic;
            % get the responses of X
            Y = Eigenmap(W,car_idx(i));
            printStr=strcat('===========cardinality:',num2str(car_idx(i)),'===========');
            if(is_SR_run==1)
                disp(printStr); 
                % ===================SR way to reduct the dimension==========
                options_sr.W = W;
                [eigvector] = SR(options_sr,Y,fea_Train);
                fea_Test_new = fea_Test*eigvector;
                fea_Train_new = fea_Train*eigvector;
                %kmeans clustering in the original space
                label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1);
                clear fea_Test_new fea_Train_new;
                [~, Error2] = Misclassification_error(gnd_Test,label);
                USSR_error(i,1)=Error2;
                printStr=strcat('SRerror rate',num2str(Error2));
                clear Error2;
                disp(printStr); 
            end
             
            % ===================leiSR way to reduct the dimension==========

            options.lambda1=10^coe_idx(ii);
            options.lambda2=10^coe_idx(jj);
            printStr=strcat('lambda1:',num2str(options.lambda1),'---lambda2:',num2str(options.lambda2));
            disp(printStr);
            error_k_least=1;
            k_least=1;
            for k=1:car_idx(i)
                [U,V]=objFun(options,Y,fea_Train,k);
%               clear eigvector;
                fea_Test_new = fea_Test*U*V;
                fea_Train_new = fea_Train*U*V;
                clear U V;
                label =knnclassify(fea_Test_new,fea_Train_new,gnd_Train,1);
                clear fea_Test_new fea_Train_new;
                [~, Error1] = Misclassification_error(gnd_Test,label);
                clear label;
                printStr=strcat('dimension:',num2str(i),'---inter medium rank:',num2str...
                        (k),'==>error rate:',num2str(Error1));
                disp(printStr);
                if Error1<error_k_least
                    error_k_least=Error1;
                    k_least=k;     
                end 
                clear Error1;
            end 
                
            LRSR_error(i,2)=k_least;
            printStr=strcat('optimized k:',num2str(k_least));
            disp(printStr);
            LRSR_error(i,1)=error_k_least;
            printStr=strcat('leiSRerror rate',num2str(error_k_least));
            disp(printStr);
            clear error_k_least k_least ;
            LRSR_result{ii,jj}=LRSR_error;
            
            clear Y eigvector;
            toc;
        end
        is_SR_run=0;
        clear LRSR_error;
    end
end
    
save -v7.3 USPS_LDA_67.mat LRSR_result USSR_error;
toc;