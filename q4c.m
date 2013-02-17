n=0;
tic;
fid = fopen('livejournal-undirected-small.txt');

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
eps = 0.1;

iter = 0;
while any(S) % S is not empty
    [AS,rhoS,cardES,cardS] = calcAS(fid,S,eps,n); % indices of nodes to be removed
    S(AS) = false;
    if rhoS > rhoSt
        St = S;
        rhoSt = rhoS;
    end
    iter = iter + 1
end
fclose(fid);
