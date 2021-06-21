% converts a boolean audibility value (-1 or 1) to a color (red or green)
function color = audibToColor(audib)
    color = zeros([length(audib) 3]);
    for i = 1:1:length(audib)    
        if audib(i, 1) == -1
        % red
            color(i, 1) = 1;
            color(i, 2) = 0;
            color(i, 3) = 0;
        elseif audib(i, 1) == 1
        % green
            color(i, 1) = 0;
            color(i, 2) = 1;
            color(i, 3) = 0;
        else
            error('unrecognized audibility input')
        end
    end
end