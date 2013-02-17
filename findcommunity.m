function [St,rhoSt,cardES,cardS,data] = findcommunity( fid,S,eps,n)
%FINDCOMMUNITY: finds the largest dense community in S

    St = true(n,1);
    rhoSt = 1;
    rhoS  = 1;
    data = [];

    iter = 0;
    while any(S) % S is not empty
        iter = iter + 1
        [S,rhoS,cardES,cardS] = calcAS(fid,S,eps,n,rhoS); % indices of nodes to be removed
        if any(S)
            if rhoS > rhoSt
                St = S;
                rhoSt = rhoS;
            end
        end
        data = [data;iter rhoS cardES cardS];
    end
end

