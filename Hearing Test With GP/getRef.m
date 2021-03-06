% Version 1.0
% Ray Tan, Jeffrey Tang
%
% function [refX, refY] = getRef(numPoints)
% [double[], double[]] = int
%
% Generates an interpolated reference curve for the normal minimum audible
% SPL vs frequency for ages 10-21. The number of points in the curve is
% optional and has a default of 100.
% Data collected from ___________.
function [refX, refY] = getRef(numPoints)
    % set default values for numPoints
    if ~exist('numPoints', 'var') || isempty(numPoints)
        numPoints = 100;
    end

    % load in the normal hearing threshold in Hz and dB SPL
    xnorm = [125, 250, 500, 750, 1000, 1500, 2000, 3000, 4000, 6000, ... 
        8000, 10000, 11200, 12500, 14000, 15000, 16000, 17000, 18000, ... 
        19000, 20000];
    ynorm = [34.83, 25.40, 15.17, 11.67, 10.52, 14.96, 17.22, 15.24, ...
        12.67, 14.25, 16.35, 20.44, 22.99, 27.16, 33.43, 40.69, ...
        48.00, 64.70, 83.45, 93.81, 93.07];
    
    % convert Hz scale to bark scale
    xnorm = hz2bark(xnorm);
    
    % define query points for interpolation
    refX = linspace(min(xnorm), max(xnorm), numPoints);
    
    % get interpolated output
    refY = interp1(xnorm, ynorm, refX);
end