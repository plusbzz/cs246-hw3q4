function [AS,rhoS,cardES,cardS] = calcAS(fid,S,eps,n)
%CALCAS

    frewind(fid);

    % Calculate degS(i)
    degS = zeros(n,1);
    cardS = 0;
    cardES = 0;
 
    bufferSize = 1e4; % scan throught the file once
    buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
    while ~isempty(buffer)
        for ix = 1:size(buffer,1)
            vals = buffer(ix,:);
            source = vals(1)+1;
            target = vals(2)+1;
            
            % update |S| and |E(S)|
            cardS = cardS + 1;
            if S(source) & S(target)
                cardES = cardES + 1;
                degS(source) = degS(source) + 1;
            end            
        end
        buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
    end

    
    % calculate AS
    AS = [];
    rhoS = cardES/cardS;  
    lowdeg = degS <= 2*(1+eps)*rhoS;
    AS = S & lowdeg;
end

