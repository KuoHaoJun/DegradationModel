function helperPlotTrend(ax, currentDay, healthIndicator, mdl, threshold, timeUnit)
%HELPERPLOTTREND helper function to refresh the trending plot

%  Copyright 2018 The MathWorks, Inc.
t = 1:size(healthIndicator, 1);
HIpred = mdl.Phi + mdl.Theta*exp(mdl.Beta*(t - mdl.InitialLifeTimeValue));
HIpredCI1 = mdl.Phi + ...
    (mdl.Theta - sqrt(mdl.ThetaVariance)) * ...
    exp((mdl.Beta - sqrt(mdl.BetaVariance))*(t - mdl.InitialLifeTimeValue));
HIpredCI2 = mdl.Phi + ...
    (mdl.Theta + sqrt(mdl.ThetaVariance)) * ...
    exp((mdl.Beta + sqrt(mdl.BetaVariance))*(t - mdl.InitialLifeTimeValue));

cla(ax)
hold(ax, 'on')
plot(ax, t, HIpred)
plot(ax, [t NaN t], [HIpredCI1 NaN, HIpredCI2], '--')
plot(ax, t(1:currentDay), healthIndicator(1:currentDay, :))
plot(ax, t, threshold*ones(1, length(t)), 'r')
hold(ax, 'off')
if ~isempty(mdl.SlopeDetectionInstant)
    title(ax, sprintf('Day %d: Degradation detected!\n', currentDay))
else
    title(ax, sprintf('Day %d: Degradation NOT detected.\n', currentDay))
end
ylabel(ax, 'Health Indicator')
xlabel(ax, ['Time (' timeUnit ')'])
legend(ax, 'Degradation Model', 'Confidence Interval', ...
    'Health Indicator', 'Threshold', 'Location', 'Northwest')
end