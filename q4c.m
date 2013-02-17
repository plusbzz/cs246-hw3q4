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

% Q4c part i
iters = [];
for eps = [0.1 0.5 1 2]
    S = true(n,1);
    [St,rhoSt,cardES,cardS,data] = findcommunity(fid,S,eps,n);    
    iters = [iters;eps, size(data,1), (log(n)/log(1+eps))];
end

% Q4c part ii
eps = 0.05;
S = true(n,1);
[St,rhoSt,cardES,cardS,data] = findcommunity(fid,S,eps,n);

% Q4c part iii

fclose(fid);
