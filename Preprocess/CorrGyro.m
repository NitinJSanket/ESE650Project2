function CorrGyro = CorrGyro(ScaledGyro)
% Correct the order of gyro values
% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu)
% Inputs: Gyroscope values
% Outputs: Order corrected gyroscope values

CorrGyro = zeros(size(ScaledGyro));
CorrGyro(3,:) = ScaledGyro(1,:);
CorrGyro(2,:) = ScaledGyro(3,:);
CorrGyro(1,:) = ScaledGyro(2,:);
end