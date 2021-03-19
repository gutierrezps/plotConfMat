clear; clf(gcf); clc;

confmat = magic(3); % sample data
% plotting
plotConfMat(confmat, {'Dog', 'Cat', 'Horse'}, 16);