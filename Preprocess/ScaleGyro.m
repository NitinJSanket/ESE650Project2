function ScaledGyro = ScaleGyro(RawGyro, GyroBias)
% Scale the gyroscope values to change units to rad/s
% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu)
% Inputs: Raw Gyroscope values
% Outputs: Scaled Gyroscope values

if(nargin<2)
    GyroBias = zeros(size(RawGyro,1),1);
end
    ScaledGyro = bsxfun(@minus, RawGyro, GyroBias);
    ScaledGyro = 3300/1023*pi/180*(1/3.33)*ScaledGyro;
end