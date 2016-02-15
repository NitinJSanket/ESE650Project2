function [Acc, Gyro] = PreprocessIMU(vals,IMUParams)
% Pre-processes the IMU data
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)
% Scale(Value)+Bias = Actual Value

Gyro = vals([5,6,4],:);
Acc = vals(1:3,:);

ScaleAcc = IMUParams(1,:)';
GyroBias = EstimateBias(Gyro);


Acc = bsxfun(@times, Acc, ScaleAcc);
Gyro = ScaleGyro(Gyro, GyroBias);

Acc = bsxfun(@plus, Acc, IMUParams(2,:)');
end