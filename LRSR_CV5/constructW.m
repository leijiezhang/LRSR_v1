function W = constructW(fea,options)
%	Usage:
%	W = constructW(fea,options)
%
%	fea: ���ݵ�ļ��ϣ�ÿһ������һ�����ݵ㣬ÿһ����x_i
%   options: Matlab��������ݽṹ���������options����ĸ�������:
%           NeighborMode -  �����ڽ�ͼ�ķ�ʽ. �ɹ�ѡ�����: [Ĭ�� 'KNN']
%                'KNN'            -  k = 0��ȫͼ
%                                    k > 0
%                                      ���ҽ���������֮�����k���ڹ�ϵ��ʱ����������
%                                      ��֮��滮һ���ߣ���options����Ҫ�ṩ����k��
%                                      Ĭ��Ϊk=5��                                   

%               'Supervised'      -  k = 0
%                                       ���ҽ��������ڵ�����ͬһ��ʱ��Ϊ����֮������һ����
%                                    k > 0
%                                       �������ڵ�����ͬһ�������k���ڹ�ϵʱ
%                                       ������֮������һ���� 
%                                    Ĭ��: k=0
%                                   ����Ҫ��options���ṩ��ǩ��Ϣgnd 
%                                              
%           WeightMode   -  Ϊͼ��ÿ��������Ȩ�صķ������ɹ�ѡ���У�
%               'Binary'       - 0-1 Ȩ��. ÿ���ߵ�Ȩ��Ϊ1. 
%               'HeatKernel'   - ����ڵ� i�ͽڵ� j�໥����,��������֮���Ȩ��
%                                W_ij = exp(-norm(x_i - x_j)/2t^2).  
%                                ����Ҫ�ṩ����t. [Ĭ�� 1]
%               'Cosine'       - ����ڵ� i�ͽڵ� j�໥����,��������֮���Ȩ��
%                                cosine(x_i,x_j). 
%               
%            k         -   ��'KNN'Ȩ��ģʽ����Ҫ�Ĳ�����Ĭ��Ϊ5.                          Default will be 5.
%            gnd       -   ��'Supervised'Ȩ��ģʽ����Ҫ�Ĳ�����
%                          ÿ�����ݵ��Ӧ�ı�ǩ��Ϣ��������
%            bLDA      -   0 or 1. ֻ��'Supervised'Ȩ��ģʽ����Ч
%                          �����1��ͼ�ᱻ�����ʹ��LPP��LDAһģһ����
%                          Ĭ��Ϊ0. 
%            t         -   ��'HeatKernel'Ȩ��ģʽ����Ҫ�Ĳ���
%                          Ĭ��Ϊ1.
%         bNormalized  -   0 or 1. ֻ��'Cosine'Ȩ��ģʽ����Ч
%                          ָʾfea�ǲ����Ѿ����򻯣�1��ʾ���򻯣�0��ʾû��

%      bSelfConnected  -   0 or 1. ָʾ�Ƿ� W(i,i) == 1. Ĭ��Ϊ 0
%                          ��� 'Supervised' �ڽ�ģʽ & bLDA == 1,
%                          bSelfConnected ����Զ�� 1. Ĭ��Ϊ 0.
%            bTrueKNN  -   0 or 1. If 1, will construct a truly kNN graph
%                          (Not symmetric�Գ�!). Default will be 0. Only valid
%                          for 'KNN' NeighborMode
%            bTrueKNN  -   0 or 1. ����� 1, ���ṹ��һ�������� kNN ͼ
%                          (���ǶԳƵ�!). Ĭ���� 0. ֻ��'KNN'Ȩ��ģʽ����Ч

% �Ƿ���ü��ٷ���
bSpeed  = 1;
% ���������options�������b = exist( 'name', 'kind')
% kind ��ʾ name �����ͣ�����ȡ��ֵΪ��builtin���ڽ����ͣ���class���ࣩ��dir���ļ��У���file���ļ����ļ��У���var����������
% =========Ԥ������һЩ��ʼֵ========
if (~exist('options','var'))
   options = [];
end

if isfield(options,'Metric')
    warning('This function has been changed and the Metric is no longer be supported');
end


if ~isfield(options,'bNormalized')
    options.bNormalized = 0;
end

%=================================================
if ~isfield(options,'NeighborMode')
    options.NeighborMode = 'KNN';
end


% ============�ж�����һ���ڽ�����,Ȼ��Ԥ����һЩ����===================
switch lower(options.NeighborMode)
    case {lower('KNN')}  %For simplicity, we include the data point itself in the kNN
        if ~isfield(options,'k')
            options.k = 5;
        end
    case {lower('Supervised')}
        if ~isfield(options,'bLDA')
            options.bLDA = 0;
        end
        if options.bLDA
            options.bSelfConnected = 1;
        end
        if ~isfield(options,'k')
            options.k = 0;
        end
        if ~isfield(options,'gnd')
            error('Label(gnd) should be provided under ''Supervised'' NeighborMode!');
        end
        if ~isempty(fea) && length(options.gnd) ~= size(fea,1)
            error('gnd doesn''t match with fea!');
        end
    otherwise
        error('NeighborMode does not exist!');
end

%=================================================

if ~isfield(options,'WeightMode')
    options.WeightMode = 'HeatKernel';
end

% �ж��ǲ���bBinary��bCosine�ı�־��bBinary��ָ��Ϊ1��bCosine��ΪbCosineȨ��
bBinary = 0;
bCosine = 0;
bNPE = 0;%if 1, NPE mode wil be switch on.
switch lower(options.WeightMode)
    case {lower('Binary')}
        bBinary = 1; 
    case {lower('HeatKernel')}
        if ~isfield(options,'t')
            nSmp = size(fea,1);
            if nSmp > 3000
                D = EuDist2(fea(randsample(nSmp,3000),:));
            else
                D = EuDist2(fea);
            end
            options.t = mean(mean(D));
        end
    case {lower('Cosine')}
        bCosine = 1;
    case {lower('NPE')}
        bBinary = 1;
    otherwise
        error('WeightMode does not exist!');
end

%=================================================

if ~isfield(options,'bSelfConnected')
    options.bSelfConnected = 0;
end

%=================================================

if isfield(options,'gnd') 
    nSmp = length(options.gnd);
else
    nSmp = size(fea,1);
end
maxM = 62500000; %500M
BlockSize = floor(maxM/(nSmp*3));


if strcmpi(options.NeighborMode,'Supervised')
    Label = unique(options.gnd);
    nLabel = length(Label);
    if options.bLDA
        G = zeros(nSmp,nSmp);
        for idx=1:nLabel
            classIdx = options.gnd==Label(idx);
            G(classIdx,classIdx) = 1/sum(classIdx);
        end
        W = sparse(G);
        return;
    end
    
    switch lower(options.WeightMode)
        case {lower('Binary')}
            if options.k > 0
                G = zeros(nSmp*(options.k+1),3);
                idNow = 0;
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    D = EuDist2(fea(classIdx,:),[],0);
                    [dump idx] = sort(D,2); % sort each row
                    clear D dump;
                    idx = idx(:,1:options.k+1);
                    
                    nSmpClass = length(classIdx)*(options.k+1);
                    G(idNow+1:nSmpClass+idNow,1) = repmat(classIdx,[options.k+1,1]);
                    G(idNow+1:nSmpClass+idNow,2) = classIdx(idx(:));
                    G(idNow+1:nSmpClass+idNow,3) = 1;
                    idNow = idNow+nSmpClass;
                    clear idx
                end
                G = sparse(G(:,1),G(:,2),G(:,3),nSmp,nSmp);
                G = max(G,G');
            else
                G = zeros(nSmp,nSmp);
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    G(classIdx,classIdx) = 1;
                end
            end
            
            if ~options.bSelfConnected
                for i=1:size(G,1)
                    G(i,i) = 0;
                end
            end
            
            W = sparse(G);
        case {lower('HeatKernel')}
            if options.k > 0
                G = zeros(nSmp*(options.k+1),3);
                idNow = 0;
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    D = EuDist2(fea(classIdx,:),[],0);
                    [dump idx] = sort(D,2); % sort each row
                    clear D;
                    idx = idx(:,1:options.k+1);
                    dump = dump(:,1:options.k+1);
                    dump = exp(-dump/(2*options.t^2));
                    
                    nSmpClass = length(classIdx)*(options.k+1);
                    G(idNow+1:nSmpClass+idNow,1) = repmat(classIdx,[options.k+1,1]);
                    G(idNow+1:nSmpClass+idNow,2) = classIdx(idx(:));
                    G(idNow+1:nSmpClass+idNow,3) = dump(:);
                    idNow = idNow+nSmpClass;
                    clear dump idx
                end
                G = sparse(G(:,1),G(:,2),G(:,3),nSmp,nSmp);
            else
                G = zeros(nSmp,nSmp);
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    D = EuDist2(fea(classIdx,:),[],0);
                    D = exp(-D/(2*options.t^2));
                    G(classIdx,classIdx) = D;
                end
            end
            
            if ~options.bSelfConnected
                for i=1:size(G,1)
                    G(i,i) = 0;
                end
            end

            W = sparse(max(G,G'));
        case {lower('Cosine')}
            if ~options.bNormalized
                fea = NormalizeFea(fea);
            end

            if options.k > 0
                G = zeros(nSmp*(options.k+1),3);
                idNow = 0;
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    D = fea(classIdx,:)*fea(classIdx,:)';
                    [dump idx] = sort(-D,2); % sort each row
                    clear D;
                    idx = idx(:,1:options.k+1);
                    dump = -dump(:,1:options.k+1);
                    
                    nSmpClass = length(classIdx)*(options.k+1);
                    G(idNow+1:nSmpClass+idNow,1) = repmat(classIdx,[options.k+1,1]);
                    G(idNow+1:nSmpClass+idNow,2) = classIdx(idx(:));
                    G(idNow+1:nSmpClass+idNow,3) = dump(:);
                    idNow = idNow+nSmpClass;
                    clear dump idx
                end
                G = sparse(G(:,1),G(:,2),G(:,3),nSmp,nSmp);
            else
                G = zeros(nSmp,nSmp);
                for i=1:nLabel
                    classIdx = find(options.gnd==Label(i));
                    G(classIdx,classIdx) = fea(classIdx,:)*fea(classIdx,:)';
                end
            end

            if ~options.bSelfConnected
                for i=1:size(G,1)
                    G(i,i) = 0;
                end
            end

            W = sparse(max(G,G'));
        case {lower('NPE')}
            
        otherwise
            error('WeightMode does not exist!');
    end
    return;
end


if bCosine && ~options.bNormalized
    Normfea = NormalizeFea(fea);
end

if strcmpi(options.NeighborMode,'KNN') && (options.k > 0)
    if (bNPE==1)
       Distance = EuDist2(fea,fea,0); 
       [sorted,index] = sort(Distance,2);
       neighborhood = index(:,2:(1+options.k));
       W = zeros(options.k,nSmp);
        for ii=1:nSmp
            z = data(neighborhood(ii,:),:)-repmat(data(ii,:),options.k,1); % shift ith pt to origin
            C = z*z';                                        % local covariance
            C = C + eye(size(C))*tol*trace(C);                   % regularlization
            W(:,ii) = C\ones(options.k,1);                           % solve Cw=1
            W(:,ii) = W(:,ii)/sum(W(:,ii));                  % enforce sum(w)=1
        end

        M = sparse(1:nSmp,1:nSmp,ones(1,nSmp),nSmp,nSmp,4*options.k*nSmp);
        for ii=1:nSmp
            w = W(:,ii);
            jj = neighborhood(ii,:)';
            M(ii,jj) = M(ii,jj) - w';
            M(jj,ii) = M(jj,ii) - w;
            M(jj,jj) = M(jj,jj) + w*w';
        end
        M = max(M,M');
        M = sparse(M);
        M = -M;
        for i=1:size(M,1)
            M(i,i) = M(i,i) + 1;
        end
        W=M;
    elseif ~(bCosine && options.bNormalized)
        G = zeros(nSmp*(options.k+1),3);
        for i = 1:ceil(nSmp/BlockSize)
            if i == ceil(nSmp/BlockSize)
                smpIdx = (i-1)*BlockSize+1:nSmp;
                dist = EuDist2(fea(smpIdx,:),fea,0);

                if bSpeed
                    nSmpNow = length(smpIdx);
                    dump = zeros(nSmpNow,options.k+1);
                    idx = dump;
%                     ֮������k+1����Ϊ��С��һ�����Լ����Լ��ľ���0
                    for j = 1:options.k+1
                        [dump(:,j),idx(:,j)] = min(dist,[],2);
                        temp = (idx(:,j)-1)*nSmpNow+[1:nSmpNow]';
%                         �Ѹո���С��ֵ��Ϊһ�����ֵ��Ȼ����������Сֵ
                        dist(temp) = 1e100;
                    end
                else
                    [dump idx] = sort(dist,2); % sort each row
                    idx = idx(:,1:options.k+1);
                    dump = dump(:,1:options.k+1);
                end
%                 bBinary����˼���ǰ������ڹ�ϵ�����н��ڹ�ϵ�ĵ�����������СͳͳΪ1
                if ~bBinary
                    if bCosine
                        dist = Normfea(smpIdx,:)*Normfea';
                        dist = full(dist);
                        linidx = [1:size(idx,1)]';
                        dump = dist(sub2ind(size(dist),linidx(:,ones(1,size(idx,2))),idx));
                    else
                        dump = exp(-dump/(2*options.t^2));
                    end
                end
%                 G�Ǳ��������k�����Լ�����֮�������Ϣ�ľ���
                G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),1) = repmat(smpIdx',[options.k+1,1]);
                G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),2) = idx(:);
                if ~bBinary
                    G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),3) = dump(:);
                else
                    G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),3) = 1;
                end
            else
                smpIdx = (i-1)*BlockSize+1:i*BlockSize;
            
                dist = EuDist2(fea(smpIdx,:),fea,0);
                
                if bSpeed
                    nSmpNow = length(smpIdx);
                    dump = zeros(nSmpNow,options.k+1);
                    idx = dump;
                    for j = 1:options.k+1
                        [dump(:,j),idx(:,j)] = min(dist,[],2);
                        temp = (idx(:,j)-1)*nSmpNow+[1:nSmpNow]';
                        dist(temp) = 1e100;
                    end
                else
                    [dump idx] = sort(dist,2); % sort each row
                    idx = idx(:,1:options.k+1);
                    dump = dump(:,1:options.k+1);
                end
                
                if ~bBinary
                    if bCosine
                        dist = Normfea(smpIdx,:)*Normfea';
                        dist = full(dist);
                        linidx = [1:size(idx,1)]';
                        dump = dist(sub2ind(size(dist),linidx(:,ones(1,size(idx,2))),idx));
                    else
                        dump = exp(-dump/(2*options.t^2));
                    end
                end
                
                G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),1) = repmat(smpIdx',[options.k+1,1]);
                G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),2) = idx(:);
                if ~bBinary
                    G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),3) = dump(:);
                else
                    G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),3) = 1;
                end
            end
        end
%         ת��Ϊϡ���ֵ
        W = sparse(G(:,1),G(:,2),G(:,3),nSmp,nSmp);
    
    else
        G = zeros(nSmp*(options.k+1),3);
        for i = 1:ceil(nSmp/BlockSize)
            if i == ceil(nSmp/BlockSize)
                smpIdx = (i-1)*BlockSize+1:nSmp;
                dist = fea(smpIdx,:)*fea';
                dist = full(dist);

                if bSpeed
                    nSmpNow = length(smpIdx);
                    dump = zeros(nSmpNow,options.k+1);
                    idx = dump;
                    for j = 1:options.k+1
                        [dump(:,j),idx(:,j)] = max(dist,[],2);
                        temp = (idx(:,j)-1)*nSmpNow+[1:nSmpNow]';
                        dist(temp) = 0;
                    end
                else
                    [dump idx] = sort(-dist,2); % sort each row
                    idx = idx(:,1:options.k+1);
                    dump = -dump(:,1:options.k+1);
                end

                G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),1) = repmat(smpIdx',[options.k+1,1]);
                G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),2) = idx(:);
                G((i-1)*BlockSize*(options.k+1)+1:nSmp*(options.k+1),3) = dump(:);
            else
                smpIdx = (i-1)*BlockSize+1:i*BlockSize;
                dist = fea(smpIdx,:)*fea';
                dist = full(dist);
                
                if bSpeed
                    nSmpNow = length(smpIdx);
                    dump = zeros(nSmpNow,options.k+1);
                    idx = dump;
                    for j = 1:options.k+1
                        [dump(:,j),idx(:,j)] = max(dist,[],2);
                        temp = (idx(:,j)-1)*nSmpNow+[1:nSmpNow]';
                        dist(temp) = 0;
                    end
                else
                    [dump idx] = sort(-dist,2); % sort each row
                    idx = idx(:,1:options.k+1);
                    dump = -dump(:,1:options.k+1);
                end

                G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),1) = repmat(smpIdx',[options.k+1,1]);
                G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),2) = idx(:);
                G((i-1)*BlockSize*(options.k+1)+1:i*BlockSize*(options.k+1),3) = dump(:);
            end
        end

        W = sparse(G(:,1),G(:,2),G(:,3),nSmp,nSmp);
    end
%     ��������ģʽ����Ȩ����Ϊ0����1
    if bBinary
        W(logical(W)) = 1;
    end
    
    if isfield(options,'bSemiSupervised') && options.bSemiSupervised
        tmpgnd = options.gnd(options.semiSplit);
        
        Label = unique(tmpgnd);
        nLabel = length(Label);
        G = zeros(sum(options.semiSplit),sum(options.semiSplit));
        for idx=1:nLabel
            classIdx = tmpgnd==Label(idx);
            G(classIdx,classIdx) = 1;
        end
        Wsup = sparse(G);
        if ~isfield(options,'SameCategoryWeight')
            options.SameCategoryWeight = 1;
        end
        W(options.semiSplit,options.semiSplit) = (Wsup>0)*options.SameCategoryWeight;
    end
    
    if ~options.bSelfConnected
        W = W - diag(diag(W));
    end

    if isfield(options,'bTrueKNN') && options.bTrueKNN
        
    else
        W = max(W,W');
    end
    
    return;
end


% strcmpi(options.NeighborMode,'KNN') & (options.k == 0)
% Complete Graph

switch lower(options.WeightMode)
    case {lower('Binary')}
        error('Binary weight can not be used for complete graph!');
    case {lower('HeatKernel')}
        W = EuDist2(fea,[],0);
        W = exp(-W/(2*options.t^2));
    case {lower('Cosine')}
        W = full(Normfea*Normfea');
    otherwise
        error('WeightMode does not exist!');
end

if ~options.bSelfConnected
    for i=1:size(W,1)
        W(i,i) = 0;
    end
end

W = max(W,W');



