clear; clf(gcf); clc;

% sample data
confmat = [10 2 0; 0 8 4; 0 0 6];

% plotting
plotConfMat(confmat, {'Dog', 'Cat', 'Horse'}, 16, 1);