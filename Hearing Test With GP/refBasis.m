function H = refBasis(x)
    % Load reference function
    [refFreq, refAmp] = getRef(500);
    H = zeros(size(x,1), 1);
    
    for ii = 1:1:length(H)
        % Find nearest entry in refFreq
        freq = x(ii,1);
        [~,index] = min(abs(refFreq - freq));
        
        % Determine if given point is above threshold
        if x(ii,2) >= refAmp(index)
            H(ii) = 1;
        end
    end
end