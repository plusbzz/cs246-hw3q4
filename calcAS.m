function [AS,rhoS,cardES,cardS] = calcAS(fid,S,eps,n)
%CALCAS

    frewind(fid);

    % Calculate degS(i)
    degS = zeros(n,1);
    cardS = 0;
    cardES = 0;
    while true
        txt = fgetl(fid);
        if txt == -1
            break
        end
        cardS = cardS+1;
        [vals,cnt] = sscanf(txt,'%d\t%d');
        source = vals(1)+1;
        target = vals(2)+1;
        
        if S(source) == 1 && S(target) == 1
            cardES = cardES + 1;
            degS(source) = degS(source) + 1;
        end
    end
    % calculate AS
    idx = find(S == 1);
    AS = [];
    rhoS = cardES/cardS;
    degS = degS(idx);
    AS = degS <= 2*(1+eps)*rhoS;
end

