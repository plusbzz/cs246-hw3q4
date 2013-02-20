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
n
t

% Q4c part i
tic;
iters = [];
for eps = [0.1 0.5 1 2]
    S = true(n,1);
    [St,rhoSt,cardES,cardS, oldCardES,oldCardS,data] = findcommunity(fid,S,eps,n);    
    iters = [iters;eps, size(data,1), (log(n)/log(1+eps))];
end
toc



% Q4c part ii
tic;
eps = 0.05;
S = true(n,1);
[St,rhoSt,cardES,cardS, oldCardES,oldCardS,data] = findcommunity(fid,S,eps,n);
toc

% Q4c part iii

eps = 0.05;
% upto 20 iterations
S = true(n,1);
communities = [];
for j = 1:20
    if any(S) % S is empty
        [St,rhoSt,cardES,cardS, oldCardES,oldCardS,d] = findcommunity(fid,S,eps,n);    
        S = S - St;
        iters = size(d,1);
        communities = [communities; j rhoSt d(iters,8) d(iters,9)];        
    else
        break;
    end
end

fclose(fid);
save('results_q4c.mat','iters','data','communities');

plot(iters(:,1),iters(:,2),'Linewidth',2);
title('Q4c.i: Plot of actual number of iterations vs epsilon');
grid();
xlabel('Epsilon');
ylabel('#Iterations');
saveas(gcf,'q4c_i_1','png');


plot(iters(:,1),iters(:,3),'Linewidth',2);
title('Q4c.i: Plot of theoretical number of iterations vs epsilon');
grid();
xlabel('Epsilon');
ylabel('#Iterations');
saveas(gcf,'q4c_i_2','png');

plot(data(:,1),data(:,2),'Linewidth',2);
title('Q4c.ii: Plot of rho(S) vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('rho(S)');
saveas(gcf,'q4c_ii_rho','png');

plot(data(:,1),data(:,4),'Linewidth',2);
title('Q4c.ii: Plot of |E[Si]| vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('|E[Si]|');
saveas(gcf,'q4c_ii_ESi','png');

plot(data(:,1),data(:,5),'Linewidth',2);
title('Q4c.ii: Plot of |Si| vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('|Si|');
saveas(gcf,'q4c_ii_Si','png');

plot(communities(:,1),communities(:,2),'Linewidth',2);
title('Q4c.iii: Plot of rho(Stj) vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('rho(S)');
saveas(gcf,'q4c_iii_rho','png');

plot(communities(:,1),communities(:,3),'Linewidth',2);
title('Q4c.iii: Plot of |E[Stj]| vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('|E[Stj]|');
saveas(gcf,'q4c_iii_ESj','png');

plot(communities(:,1),communities(:,4),'Linewidth',2);
title('Q4c.iii: Plot of |Stj| vs number of iterations');
grid();
xlabel('#Iterations');
ylabel('|Stj|');
saveas(gcf,'q4c_iii_Sj','png');

