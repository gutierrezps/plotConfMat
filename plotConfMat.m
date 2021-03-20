function plotConfMat(varargin)
%PLOTCONFMAT plots the confusion matrix with colorscale, absolute numbers
%   and precision normalized percentages
%
%   Usage:
%   PLOTCONFMAT(confmat) plots the confmat with integers 1 to n as class labels
%   PLOTCONFMAT(confmat, labels) plots the confmat with the specified labels
%
%   Vahe Tshitoyan, Gutierrez PS
%   19-march-2021
%
%   Arguments
%   confmat (required): a square confusion matrix
%   labels:     vector of class labels
%   fontsize:   to be used on plot texts (default is 14)
%   grayscale:  if true, use grayscale colors (default is false, blue colors)
%
%   Source: https://github.com/gutierrezps/plotConfMat

% default arguments
fontsize = 14;
grayscale = false;

% number of arguments
switch (nargin)
    case 0
        confmat = 1;
        labels = {'1'};
    case 1
        confmat = varargin{1};
        labels = 1:size(confmat, 1);
    case 2
        confmat = varargin{1};
        labels = varargin{2};
    case 3
        confmat = varargin{1};
        labels = varargin{2};
        fontsize = varargin{3};
    otherwise
        confmat = varargin{1};
        labels = varargin{2};
        fontsize = varargin{3};
        grayscale = varargin{4} == true;
end

confmat(isnan(confmat))=0; % in case there are NaN elements
numlabels = size(confmat, 1); % number of labels

% calculate the percentage accuracies
confpercent = 100*confmat./repmat(sum(confmat, 1),numlabels,1);

% plotting the colors
imagesc(confpercent);
title(sprintf('Accuracy: %.2f%%', 100*trace(confmat)/sum(confmat(:))));
ylabel('Output Class'); xlabel('Target Class');

% set the colormap
if grayscale
    colormap(flipud(gray));
else
    % scikit-learn confusion matrix colors (dark-blue, blue, white)
    confColors = [
        0.03 0.19 0.42;     % 100%
        0.29 0.60 0.79;     % 60%
        1.00 1.00 1.00      % 0%
    ];

    confColorMap = zeros(64, 3);
    colorPts = int8([0.4 0.6] .* 64);

    for i = 1:2
        colors = zeros(colorPts(i), 3);
        for j = 1:3
            colors(:, j) = linspace(confColors(i, j), confColors(i+1, j), colorPts(i))';
        end
        if i == 1
            confColorMap(1:colorPts(1), :) = colors;
        else
            confColorMap(colorPts(1)+1:64, :) = colors;
        end
    end

    colormap(flipud(confColorMap));
end

% Create strings from the matrix values and remove spaces
textStrings = num2str([confpercent(:), confmat(:)], '%.1f%% (%d)\n');
textStrings = strtrim(cellstr(textStrings));

% Create x and y coordinates for the strings and plot them
[x,y] = meshgrid(1:numlabels);
hStrings = text(x(:),y(:),textStrings(:), ...
    'HorizontalAlignment','center', 'FontSize', fontsize);

% Get the middle value of the color range
midValue = mean(get(gca,'CLim'));

% Choose white or black for the text color of the strings so
% they can be easily seen over the background color
textColors = double(repmat(confpercent(:) > midValue,1,3));
for i = 1:length(hStrings)
    set(hStrings(i),'Color', textColors(i,:));
end

% Setting the axis labels and font size
set(gca,'XTick',1:numlabels,...
    'XTickLabel',labels,...
    'YTick',1:numlabels,...
    'YTickLabel',labels,...
    'TickLength',[0 0],...
    'FontSize', 18);

% add colorbar
h = colorbar;
set(h, 'FontSize', fontsize);

end