% #nodes and # edges
fid = fopen('livejournal-undirected-small.txt');
m = 0;
n = 0;
tic;
while true
    txt = fgetl(fid);
    if txt == -1
        break
    end
    m = m+1;
    [vals,cnt] = sscanf(txt,'%d\t%d');
    source = vals(1)+1;
    target = vals(2)+1;
    if source > n
        n = source;
    end;
    if target > n
        n = target;
    end;
end
[m n toc]

% Initialize S and St
S  = ones(n,1);
St = ones(n,1);
rhoSt = 1;
eps = 0.1;

iter = 0;
while sum(S) > 0 % S is not empty
    [AS,rhoS,cardES,cardS] = calcAS(fid,S,eps,n); % indices of nodes to be removed
    S(AS) = 0;
    if rhoS > rhoSt
        St = S;
        rhoSt = rhoS;
    end
    iter = iter + 1
end
fclose(fid);
