% Version 1.0
% Ray Tan, Jeffrey Tang
% 
% function spl = toSpl(freq, hl, refX, refY)
% double[] = double[], double[], double[], double[]
% 
% Converts a array of points from HL to dB SPL using a set of reference
% points. If the frequency of a given point in the vector does not match a
% point in the reference curve, the nearest point in the reference curve is
% used instead. Reference points are defaulted to the points given by the
% getRef() function.
function spl = toSpl(freq, hl, refX, refY)
    % set default reference curve
    if ~exist('refX', 'var') || ~exist('refY', 'var') || isempty(refX) || isempty(refY)
        [refX, refY] = getRef();
    end

    % locate the index of the frequency value present on the reference
    % curve that is closest to the x value of the given point
    [~, indices] = min(abs(freq - refX'));
    
    % calculate the hearing level based on the SPL of the reference point
    % and the SPL of the given point
    spl = hl + refY(indices);
end