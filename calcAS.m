function [AS,rhoS,cardES,cardS] = calcAS(fid,S,eps,n)
%CALCAS

    frewind(fid);

    % Calculate degS(i)
    degS = zeros(n,1);
    cardS = 0;
    cardES = 0;
    
    while true % scan through the file once
        txt = fgetl(fid);
        if txt == -1
            break
        end
        cardS = cardS+1;
        [vals,cnt] = sscanf(txt,'%d\t%d');
        source = vals(1)+1;
        target = vals(2)+1;
        
        if S(source) & S(target)
            cardES = cardES + 1;
            degS(source) = degS(source) + 1;
        end
    end
    
    % calculate AS
    AS = [];
    rhoS = cardES/cardS;  
    lowdeg = degS <= 2*(1+eps)*rhoS;
    AS = S & lowdeg;
end

