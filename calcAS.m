function [S,rhoS,cardES,cardS,oldCardES,oldCardS] = calcAS(fid,S,eps,n,rhoS)
%CALCAS

    threshold = 2*(1+eps)*rhoS;
 
    oldCardS = sum(S);
    [oldCardES, AS] = cardinalities( fid,S, n, threshold );

    % Update cardinalities and rhoS
    S(AS) = false; % new S
    cardS=sum(S);

    [cardES, AS] = cardinalities( fid,S, n, threshold );
    rhoS = cardES/cardS; % new rhoS 
end

