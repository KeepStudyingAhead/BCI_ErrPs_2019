function [ metrics ] = p_metrics( mean_cm,labels,scores  )
%Calculates the Matthews correlation coeficiant 
%   Input : mean of confusion matrix
%           size : 2x2
% Output : Matthews correlation coeficiant 
%           size : scalar

TN = mean_cm(1,1);
FP = mean_cm(1,2); 
FN = mean_cm(2,1);
TP = mean_cm(2,2);

upper = TP*TN-FP*FN;
lower = sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
if (lower == 0 ) 
    lower = 0.0000001;
end 
metrics.mcc = upper/lower;
metrics.tpr = TP/(TP+FN);
metrics.fpr = FP/(TN+FP);
[~,~,~,metrics.auc] = perfcurve(labels,scores,1);
metrics.precision = TN/(TN + FP);
metrics.recall = TN/(TN + FN);
metrics.fmeasure = 2*metrics.precision*metrics.recall / (metrics.precision + metrics.recall);
end

