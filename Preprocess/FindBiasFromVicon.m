clc
clear all
close all

SetIdxs = [1,2,3,4,5,8,9];
ginW = [0,0,1]';
gs = [];
AccVals = [];

for Sets = 1:length(SetIdxs)
    Set = num2str(SetIdxs(Sets));
    disp(Set);
    IMUDataPath = ['../imu/imuRaw',Set,'.mat'];
    ViconDataPath = ['../vicon/viconRot',Set,'.mat'];
    
    load(IMUDataPath);
    tsIMU = ts;
    load(ViconDataPath);
    tsVicon = ts;
    clear ts
    
    Acc = vals(1:3,:);
    [IdxsIMU, IdxsVicon] = SyncTimes(tsIMU,tsVicon);
    disp('Syncing Done....');
    
    A = [];
    for i = 1:length(IdxsVicon)
        A(:,i) = rots(:,:,IdxsVicon(i))'*ginW;
    end
    
    gs = [gs,A];
    AccVals = [AccVals,Acc(:,IdxsIMU)];
    
end

%%
for  i = 1:3
    Coeff(:,i) = [AccVals(i,:)', ones(size(AccVals,2),1)]\gs(i,:)';
end

disp(Coeff);