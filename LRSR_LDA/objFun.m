function [U,V]=objFun(options,Responses,data,interMdDim,V)
% objFunc: ��Ŀ�꺯�� calculate the goal function
%��������⣺min(U,V)||data'UV'-Y||^2+lambda1||U||^2+lambda2||V||^2
% data(d*n) Y(n*c) U(d*k) V(c*k) kΪUV'���ȣ���ʼ����kΪreductDim�����������
% inputs: 
%          options.lambda1: the first regular parameter of objFunc
%          options.lambda2: the second regular parameter of objFunc
%          options.tol: the tolerance of calculating cycles
%          options.training_epochs: setthe trainning epoch
%          Responses: the resonse Matrix of data
%          interMdDim: the intermedia dimension of dimension reduction
%          data: the data that you want to have an dimension reduction
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
    [u_fea,s_fea,~]=svd(fea_mut);
    V_mul=V*V';
    V_mul=max(V_mul,V_mul');
    [u_V,s_V,~]=svd(V_mul);
    u_trans_fea=u_fea';u_trans_V=u_V';
%     (1)ʽ�ȼ���u_fea*s_fea*u_trans_fea*U*u_V*s_V*u_trans_V+lambda1*U=data'YV'
%     �����ȼ���s_fea*u_trans_fea*U*u_V*s_V + lambda1*u_trans_fea*U*u_V = u_trans_fea*data'YV'*u_V(2)
%    (2)ʽ�ȼ��� s_fea*U_delta1*s_V + lambda1*U_delta = T_delta(2)   
    T=data'*Responses*V';
%     U_delta=u_trans_fea*U*u_V;
%     sub_temp=zeros(nFea,interMdDim);
    T_delta=u_trans_fea*T*u_V;
    s_fea_diag=diag(s_fea);
    s_V_diag=diag(s_V)';
    s_fea_mat=zeros(nFea,interMdDim);
    s_fea_mat(:,1)=s_fea_diag;
    s_V_mat=repmat(s_V_diag,interMdDim,1);
    sub_temp=s_fea_mat*s_V_mat+options.lambda1*ones(nFea,interMdDim);
    U_delta=T_delta./sub_temp;
    U=u_fea*U_delta*u_trans_V;
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
    parT_delta=options.lambda2*trace(V_mul);
    objFunc=part1+part2+parT_delta;
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