% Version 1.0
% Ray Tan, Jeffrey Tang
% 
% function hlY = spl2hl(splX, splY, refX, refY)
% double = double, double, double[], double[]
% 
% Converts a vector of points from dB SPL to HL using a set of reference
% points. Reference points are defaulted to the points given by the
% getRef() function.
function hl = spl2hl(freq, spl, refX, refY)
    % locate the index of the frequency value present on the reference
    % curve that is closest to the x value of the given point
    [~, index] = min(abs(freq - refX));
    
    % calculate the hearing loss based on the SPL of the reference point
    % and the SPL of the given point
    hl = spl - refY(index);
end