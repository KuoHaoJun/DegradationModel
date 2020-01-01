function alphaBoundProbablity = helperAlphaLambdaPlot(alpha, trueRULHist, estRULHist, ...
    CIRULHist, pdfRULHist, degradationTime, breakpoint, timeUnit)
%HELPERALPHALAMBDAPLOT create alpha-lambda plot and the probability metric

%  Copyright 2018 The MathWorks, Inc.

N = length(trueRULHist);
t = 1:N;
t2 = t((degradationTime+1):end);

% Compute the alpha bounds
alphaPlus = trueRULHist + alpha*trueRULHist;
alphaMinus = trueRULHist - alpha*trueRULHist;

% ---------------- Alpha-Lambda Plot --------------------
figure
hold on
grid on

% Plot true RUL and its alpha bounds
plot(t, trueRULHist)
fill([t fliplr(t)], [alphaPlus(t)' fliplr(alphaMinus(t)')], ...
    'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')

% Plot the estimated RUL and its confidence intervals
plot(t2, estRULHist(t2), '--')
fill([t2 fliplr(t2)], ...
    [CIRULHist(t2, 1)' fliplr(CIRULHist(t2, 2)')], ...
    'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none')

% Plot the train-test breakpoint
ylow = 0;
yup = 80;
plot([breakpoint breakpoint], [ylow yup], 'k-.')

% Add labels and legends
ylim([ylow yup])
hold off
xlabel(['Time (' timeUnit ')'])
ylabel(['RUL (' timeUnit ')'])
legend('True RUL', ['\alpha = +\\-' num2str(alpha*100) '%'], ...
    'Predicted RUL After Degradation Detected', ...
    'Confidence Interval After Degradation Detected', 'Train-Test Breakpoint')

% ---------------- Probability Metric --------------------
% Compute the probability of predicted RUL within alpha bounds
alphaBoundProbablity = zeros(N, 1);
for i = 1:N
    pdfRUL = pdfRULHist{i};
    idx = (pdfRUL{:, 1} > alphaMinus(i)) & (pdfRUL{:, 1} < alphaPlus(i));
    prob = sum(pdfRUL{idx, 2});
    alphaBoundProbablity(i) = prob;
end
end
