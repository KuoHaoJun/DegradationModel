function helperPlotRUL(ax, trueRUL, estRUL, CIRUL, pdfRUL, timeUnit)
%HELPERPLOTRULDISTRIBUTION helper function to refresh the distribution plot

%  Copyright 2018 The MathWorks, Inc.
cla(ax)
hold(ax, 'on')
plot(ax, pdfRUL{:,1}, pdfRUL{:,2})
plot(ax, [estRUL estRUL], [0 pdfRUL{find(pdfRUL{:,1} >= estRUL, 1), 2}])
plot(ax, [trueRUL trueRUL], [0 pdfRUL{find(pdfRUL{:,1} >= trueRUL, 1), 2}], '--')
idx = pdfRUL{:,1} >= CIRUL(1) & pdfRUL{:,1}<=CIRUL(2);
area(ax, pdfRUL{idx, 1}, pdfRUL{idx, 2}, ...
    'FaceAlpha', 0.2, 'FaceColor', 'g', 'EdgeColor', 'none');
hold(ax, 'off')
ylabel(ax, 'PDF')
xlabel(ax, ['Time (' timeUnit ')'])
legend(ax, 'pdf of RUL', 'Estimated RUL', 'True RUL', 'Confidence Interval')