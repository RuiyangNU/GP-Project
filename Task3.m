% create new array for data
% dataArray = zeros([20 3]);

%{ 
%import data
freqArray = [43.116 295.289 325.661 49.768 14772.0 30.225 229.354 22.245 64.269 3134.7 450.61 154.879 73.773 71.05 1506.2 35.027 4247.8 406.075 165.989 681.31];
amplitudeArray = [0.78 0.241  0.097 0.942 0.575 0.235 0.821 0.043 0.649 0.648 0.547 0.745 0.687 0.369 0.780 0.929 0.487 0.447 0.509 0.818];
audibArray = [-1 1 1 -1 1 -1 1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 1 1];

for i = 1:1:length(dataArray)
    dataArray(i,1) = freqArray(i);
    dataArray(i,2) = amplitudeArray(i);
    dataArray(i,3) = audibArray(i);
end
%}

% create modified data array
modifiedDataArray = dataArray;

% convert amplitude to dB scale
for i = 1:1:length(dataArray)
    modifiedDataArray(i,2) = 20 * log10((20 * dataArray(i,2)) / (20 * 10^-6));
end

% create scatter plot
scatter(modifiedDataArray(1:length(modifiedDataArray),1),modifiedDataArray(1:length(modifiedDataArray),2),[],audibToColor(modifiedDataArray(1:length(modifiedDataArray),3)))
ax = gca;
set(gca,'xtick',[20,200,2000,20000])
set(gca,'ylim',[20 100])
set(gca,'xscale','log')
set(gca,'xlim',[20 20000])
ax.YLabel.String = 'Sound Pressure Level (db)';
ax.XLabel.String = 'Frequency (hz)';
