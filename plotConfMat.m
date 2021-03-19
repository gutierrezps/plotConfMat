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
%   confmat:            a square confusion matrix
%   labels (optional):  vector of class labels
%   fontsize (optional): to be used on plot texts (default is 14)

% default arguments
fontsize = 14;

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
    otherwise
        confmat = varargin{1};
        labels = varargin{2};
        fontsize = varargin{3};
end

confmat(isnan(confmat))=0; % in case there are NaN elements
numlabels = size(confmat, 1); % number of labels

% calculate the percentage accuracies
confpercent = 100*confmat./repmat(sum(confmat, 1),numlabels,1);

% plotting the colors
imagesc(confpercent);
title(sprintf('Accuracy: %.2f%%', 100*trace(confmat)/sum(confmat(:))));
ylabel('Output Class'); xlabel('Target Class');
set(gca, 'FontSize', fontsize);

% set the colormap
colormap(flipud(gray));

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

% Setting the axis labels
set(gca,'XTick',1:numlabels,...
    'XTickLabel',labels,...
    'YTick',1:numlabels,...
    'YTickLabel',labels,...
    'TickLength',[0 0]);
end