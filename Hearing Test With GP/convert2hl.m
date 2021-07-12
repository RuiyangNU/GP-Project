% converts all points from standard curve to hearing level curve given
% vector?
function out_matrix = convert2hl(input_matrix)

    [refFreq, refAmp] = getRef();
    freq = input_matrix(:,1);
    amp = input_matrix(:,2);
    
    out_matrix = zeros(size(input_matrix));
    out_matrix(:,1) = in_matrix(:,1);
    
    for ii = 1:1:length(freq)
        [~,index] = min(abs(refFreq - input_matrix(ii,1)));
        out_matrix(ii,2) = amp(ii) - refAmp(index);
    end
end