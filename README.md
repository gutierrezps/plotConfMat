# plotConfMat

Plots a confusion matrix with colorscale, absolute numbers and precision
normalized percentages. This is a basic alternative to MATLAB's [plotconfusion]
if you do not have the Neural Network Toolbox. Compatible with GNU Octave.

Usage:

```matlab
plotConfMat(confmat)
```

Or, if you want to specify the class labels:

```matlab
plotConfMat(confmat, labels)
```

[plotconfusion]: https://uk.mathworks.com/help/nnet/ref/plotconfusion.html
