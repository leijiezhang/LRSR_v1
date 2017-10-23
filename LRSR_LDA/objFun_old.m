function [U,V]=objFun(options,Responses,data,interMdDim,U,V)
% objFunc: ��Ŀ�꺯�� calculate the goal function
%��������⣺min(U,V)||data'UV'-Y||^2+lambda1||U||^2+lambda2||V||^2
% data(d*n) Y(n*c) U(d*k) V(c*k) kΪUV'���ȣ���ʼ����kΪreductDim�����������
% inputs: 
%          options.lambda1: the first regular parameter of objFunc
%          options.lambda2: the second regular parameter of objFunc
%          options.tol: the tolerance of calculating cycles
%          options.training_epochs: set the trainning epoch
%          Responses: the resonse Matrix of data
%          interMdDim: the intermedia dimension of dimension reduction
%          data: the data that you want to have an dimension reduction
%          U: the initialized U
%          V: the initialized V
% outputs: 
%          U: one of the most important output
%          V: one of the most important output
% write by leijie @ 2017/6/5
ite_epochs=1;
% ��ʼ��UV
reductDim=size(Responses,2);
[~,nFea]=size(data);
% load('temp.mat');
if ~exist('U','var')
   U=rand(nFea,interMdDim);
end
if ~exist('V','var')
    V=rand(interMdDim,reductDim);
end


% ��ʼ�������
preResult=50;
nowResult=100;
tolNow=abs(preResult-nowResult);
while tolNow>options.tol&&ite_epochs<options.training_epochs
    
%   �̶�V���U,���ʽΪ��data'*data*U*V*V'+lambda1*U=data'YV' (1)
    fea_mul=data'*data;
    fea_mut=max(fea_mul,fea_mul');
    [U11,S1,~]=svd(fea_mut);
    V_mul=V*V';
    V_mul=max(V_mul,V_mul');
    [U21,S2,~]=svd(V_mul);
    U12=U11';U22=U21';
%     (1)ʽ�ȼ���U11*S1*U12*U*U21*S2*U22+lambda1*U=data'YV'
%     �����ȼ���S1*U12*U*U21*S2 + lambda1*U12*U*U21 = U12*data'YV'*U21(2)
%    (2)ʽ�ȼ��� S1*U31*S2 + lambda1*U3 = T3(2)   
    T=data'*Responses*V';
%     U3=U12*U*U21;
%     sub_temp=zeros(nFea,interMdDim);
    T3=U12*T*U21;
%     for i=1:nFea
%         for j=1:interMdDim
%             sub_temp(i,j)=S1(i,i)*S2(j,j)+options.lambda1;
%         end
%     end
    S1_diag=diag(S1);
    S2_diag=diag(S2)';
    S1_mat=zeros(nFea,interMdDim);
    S1_mat(:,1)=S1_diag;
    S2_mat=repmat(S2_diag,interMdDim,1);
    sub_temp=S1_mat*S2_mat+options.lambda1*ones(nFea,interMdDim);
    U3=T3./sub_temp;
    U=U11*U3*U22;
%     �̶�U����V: V' = Y'dataU(U'datadata'U + lambda2*I)^1

    I=eye(interMdDim);
    U_part=U'*fea_mul*U+ options.lambda2*I;
    V=(Responses'*data*U/U_part)';
    
%     ����Ŀ�꺯����ֵ
    part1=data*U*V-Responses;
    part1=part1'*part1;
    part1=max(part1,part1');
    part1=trace(part1);
    U_mul=U*U';
    U_mul=max(U_mul,U_mul');
    part2=options.lambda1*trace(U_mul);
    part3=options.lambda2*trace(V_mul);
    objFunc=part1+part2+part3;
    preResult=nowResult;
    nowResult=objFunc;
    tolNow=abs(preResult-nowResult);
%     disp('======================');
%     showStr=strcat('��һ��ֵ:',num2str(preResult));
%     disp(showStr);
%     showStr=strcat('��һ��ֵ:',num2str(nowResult));
%     disp(showStr);
%     showStr=strcat('���ֵ:',num2str(tolNow),'������:',num2str(ite_epochs));
%     disp(showStr);
    ite_epochs=ite_epochs+1;
end 