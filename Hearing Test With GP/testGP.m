inputX = 0:1:10;
inputY = 0:0.25:1;
[G1,G2] = meshgrid(inputX, inputY);
observedInputs = [reshape(G1, [numel(G1), 1]), reshape(G2, [numel(G2), 1])];

observedOutputs = zeros(1, size(observedInputs, 1));
for ii = 1:size(observedInputs, 1)
    inX = observedInputs(ii, 1);
    inY = observedInputs(ii, 2);
    observedOutputs(ii, 1) = sin(inX) > inY;
end

gprMdl = fitrgp(observedInputs, observedOutputs);

testX = linspace(0,10,100);
%4testY = linspace();