function [S,rhoS] = calcAS(fid,S,eps,n,rhoS)
%CALCAS
    
    cardES = 0;
    % Calculate degS(i)
    degS = zeros(n,1);
    AS = true(n,1);
    threshold = 2*(1+eps)*rhoS;
 
    frewind(fid);
    bufferSize = 1e4; % scan through the file once
    buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
    while ~isempty(buffer)
        for ix = 1:size(buffer,1)
            vals = buffer(ix,:);
            source = vals(1)+1;
            target = vals(2)+1;            
            % Update degS and AS in this pass
            if S(source) & S(target)
                cardES = cardES + 1;
                degS(source) = degS(source) + 1;
                if degS(source) > threshold
                    AS(source) = false;
                end;
            end            
        end
        buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
    end
    
    % Update cardinalities and rhoS
    S(AS) = false; % new S

    cardS = sum(S);
    cardES = cardES - sum(degS(AS))/2;
    rhoS = cardES/cardS; % new rhoS 
end

