function Bias = EstimateBias(Vals)
% Estimates the bias for Accelometer or Gyroscope values

Bias = mean(Vals(:,1:200),2);
end