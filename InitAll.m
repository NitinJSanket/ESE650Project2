% Loads all the paths and sets the required toolboxes for UKF
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

%% Add the required toolbox paths
addpath(genpath('./'));

%% Load all the needed Files
disp('Please select the IMU File when the dialog box opens.');
pause(1);
uiopen('load');
tsIMU = ts;
clear ts
disp('Loading IMU Data Complete....');
if(ViconFlag)
    disp('Please select the Vicon File when the dialog box opens.');
    pause(1);
    uiopen('load');
    tsVicon = ts;
    clear ts
    disp('Loading Vicon Data Complete....');
else
   tsVicon = [];
   rots = [];
end

if(CamFlag)
    disp('Please select the Camera File when the dialog box opens.');
    pause(1);
    uiopen('load');
    Imgs = cam;
    tsCam = ts;
    clear ts
    clear cam
    disp('Loading Camera Data Complete....');
end

load('IMUParams.mat');
disp('Loading IMU Parameters Complete....');
[Acc, Gyro] = PreprocessIMU(vals,IMUParams);
disp('IMU Data Pre-processing Complete....');

%% Get Vicon Data if needed
if(ViconFlag)
    % Store Euler Angles estimated by Vicon
    VICONEULS = zeros(3,size(rots,3));
    % Get Vicon Data
    for i = 1:size(rots,3)
        VICONEULS(:,i) =  rotm2eul(rots(:,:,i))';
    end
    disp('Extraction of Euler Angles from Vicon Data Complete....');
else
    VICONEULS = [];
end
