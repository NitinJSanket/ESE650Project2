% Setup rotation matrices into a cell array as needed by PlotRotBox
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

% AllrotsOrder = [Gyro*CF, Acc*CF, CF, KF, UKF, Vicon];

AllRots = {};

if(GyroFlag*CFFlag)
    AllRots{1} = rotsGyro;
end
if(AccFlag*CFFlag)
    AllRots{2} = rotsAcc;
end
if(CFFlag)
    AllRots{3} = rotsCF;
end
if(KFFlag)
    AllRots{4} = rotsKF;
end
if(UKFFlag)
    AllRots{5} = rotsUKF;
end
if(ViconFlag)
    AllRots{6} = rots;
end
