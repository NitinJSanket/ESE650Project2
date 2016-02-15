%% Wrapper for Attitude estimation from IMU Data using Unscented Kalman Filter, Kalman Filter and a Complementary Filter
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)
% NOTE: CODE CLEARS ALL VARIABLES IN THE WORKSPACE!
% Activate the required flags

clc
clear all
close all
warning off;

%% Setup the Flags Needed
CamFlag = 1; % Do you want to stitch a pano?
ViconFlag = 1; % Do you have Vicon Data?
UKFFlag = 1; % Run Unscented Kalman Filter?
CFFlag = 0; % Run Complementary Filter?
KFFlag = 0; % Run Kalman Filter?
PlotFlag = 1; % Plot Outputs?
RotboxFlag = 0; % Display Rotbox
GyroFlag = 1; % Run Gyro Integration? Usage only when CFFlag is active
AccFlag = 1; % Run Accelerometer based estimation? Usage only when CFFlag is active
SaveFlag = 1; % Save Plots and Output Pano?
Wt = 0; % Blending fraction for panorama, make this 0 for no blending (Range 0 to 1)
FrameInterval = 5; % Blend 1 frame for every FrameInterval Number of Frames, lower the number, slower the code
FrameSkip = [200,200]; % Amount of frame to exclude from panorama, Format: [StartSkip, EndSkip]
f = 240; % Camera Focal length in pixels
CanvasSize = [800,1600,3]; % Size of the canvas for output panorama
VideoFlag = 1; % Capture the video of RotPlotBox, Usage only when RotboxFlag is active, saves as Video.avi

%% Initialize Everything
InitAll;

%% Run Complementary Filter
if(CFFlag)
    RunCF;
end

%% Run Kalman Filter
if(KFFlag)
    KFIter = min(3000,length(Gyro));
    [KFEULS, rotsKF] = RunKF(Acc, Gyro, tsIMU, KFIter);
    % Stitch Images
    if(CamFlag)
        CanvasKF = StitchImages(Imgs, rotsKF, tsCam, tsIMU(1:KFIter), CanvasSize, f, FrameSkip, FrameInterval,Wt);
        if(SaveFlag)
            imwrite(CanvasKF,['KFPanof',num2str(f),'.jpg']);
        end
    end
end

%% Run Unscented Kalman Filter
if(UKFFlag)
    RunUKF;
end

%% Plot the graphs
if(PlotFlag)
    if(ViconFlag)
        PlotGraphs(0,tsVicon,tsVicon,VICONEULS,VICONEULS,{'Vicon'},'r',0);
    end
    if(UKFFlag)
        PlotGraphs(0,tsIMU,tsVicon,UKFEULS,VICONEULS,{'UKF'},'b',ViconFlag);
    end
    if(KFFlag)
        PlotGraphs(0,tsIMU,tsVicon,KFEULS,VICONEULS,{'KF','Vicon'},'c',ViconFlag);
    end
    if(CFFlag)
        PlotGraphs(0,tsIMU,tsVicon,CFEULS,VICONEULS,{'CF'},'g',ViconFlag);
    end
    if(GyroFlag && CFFlag)
        PlotGraphs(0,tsIMU,tsVicon,GYROEULS,VICONEULS,{'Gyro'},'k',ViconFlag);
    end
    if(AccFlag && CFFlag)
        PlotGraphs(0,tsIMU,tsVicon,ACCEULS,VICONEULS,{'Acc'},'m',ViconFlag);
    end
    if(SaveFlag)
        saveas(gcf,'ComparisonPlot.jpg');
    end
end

%% Plot Rotbox
if(ViconFlag)
    NumSamples = min([length(tsVicon),length(tsIMU)]);
else
    NumSamples = length(tsIMU);
end
if(RotboxFlag)
    if(VideoFlag)
        Vid = VideoWriter('Video.avi');
        open(Vid);
    else
        Vid = [];
    end
    % FlagsOrder = [Gyro*CF, Acc*CF, CF, KF, UKF, Vicon];
    Flags = [GyroFlag*CFFlag, AccFlag*CFFlag, CFFlag, KFFlag, UKFFlag, ViconFlag];  
    % Setup rotation matrices into a cell array as needed by PlotRotBox
    % into AllRots cell array
    SetupRots;
    PlotRotbox(Flags, NumSamples, AllRots, VideoFlag, Vid);
end

