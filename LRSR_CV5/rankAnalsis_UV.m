% get the rank analysis of each W ( from diffrent value of k and c)

Winfo_arr=cell(150,1);
S_num_arr=ones(150,1);
for i=1:150
    k=k_best(i,1);
    U_cell=U_rec_cell{i,1};
    U=U_cell{k,1};
    V_cell=V_rec_cell{i,1};
    V=V_cell{k,1};
    W_info=[];
    W=U*V;
    [U_tmp,S,V_tmp]=svd(W);
    S_count=diag(S);
    zero_loc=find(S_count<1e-8);
    S_count(zero_loc)=0;
    S_num= find(S_count>0, 1, 'last' );
    S_num_arr(i,1)=S_num;
    W=U_tmp(:,S_num)*V_tmp(S_num,:);
    W_info.W=W;
    W_info.S=S_count;
    Winfo_arr{i,1}=W_info;
end

save Winfo_arr.mat Winfo_arr S_num_arr;

