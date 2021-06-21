% converts a value on the bark scale to a regular frequency
function freq = invBark(b) 
    freq = zeros([1 length(b)]);
    for i = 1:1:length(b)
        freq(1,i) = ((-1960*b(1,i)-1038.8)/(b(1,i)-26.28));
    end
end