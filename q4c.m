n=0;
tic;
fid = fopen('livejournal-undirected.txt');

% read chunks of the file, iterate and calculate #nodes n
bufferSize = 1e4;
buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
while ~isempty(buffer)
    for ix = 1:size(buffer,1)
        vals = buffer(ix,:);
        source = vals(1)+1;
        target = vals(2)+1;
        if source > n
            n = source;
        end;
        if target > n
            n = target;
        end;
    end
    buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
end
t = toc;
[n toc]

% Initialize S and St to arrays of logical trues
S  = true(n,1);
St = true(n,1);
rhoSt = 1;
rhoS = 1;
eps = 2;


iter = 0;
while any(S) % S is not empty
    iter = iter + 1
    [S,rhoS] = calcAS(fid,S,eps,n,rhoS); % indices of nodes to be removed
    if any(S)
        if rhoS > rhoSt
            St = S;
            rhoSt = rhoS;
        end
        sum(S)
        rhoS
        rhoSt
    end
end
fclose(fid);
