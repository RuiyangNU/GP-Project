% converts a frequency scale f to the bark scale
function barkf = bark(f) 
    barkf = zeros([1 length(f)]);
    for i = 1:1:length(f)
        barkf(1,i) = ((26.81*f(1,i))/(1960+f(1,i)))-0.53;
    end
end