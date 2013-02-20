function [St,rhoSt,cardES,cardS, oldCardES,oldCardS,data] = findcommunity( fid,S,eps,n)
%FINDCOMMUNITY: finds the largest dense community in S

    St = S;
    rhoSt = 0;
    rhoS  = 0;
    data = [];
    cardESt = 0;
    cardSt = 0;
    
    iter = 0;
    while any(S) % S is not empty
        iter = iter + 1;
        [S,rhoS,cardES,cardS,oldCardES,oldCardS] = calcAS(fid,S,eps,n,rhoS); % indices of nodes to be removed
        if any(S)
            cardESt = oldCardES;
            cardSt = oldCardS;
            if rhoS > rhoSt
                St = S;
                rhoSt = rhoS;
                cardESt = cardES;
                cardSt = cardS;
            end
        end
        data = [data;iter rhoS rhoSt cardES cardS oldCardES oldCardS cardESt cardSt];
    end
end

