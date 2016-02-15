function PlotGraphs(ViconFlag,tsIMU,tsVicon,UKFEULS,VICONEULS,Legend,Color,ErrorFlag)
% Plots all the graphs
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

% Extract the flags
if(nargin<8)
    % Display Error by default
    ErrorFlag = 1;
end
%% Plot the results
CurrLegend = get(legend(gca),'String');
NewLegend = [CurrLegend,Legend];

subplot 311
plot(tsIMU(1:length(UKFEULS(1,:))), UKFEULS(1,:)*180/pi,Color(1));
hold all;
title('Yaw (Z axis)');
if(ViconFlag)
    plot(tsVicon, VICONEULS(1,:)*180/pi,Color(2));
end
% Set the legends now
legend(NewLegend);

subplot 312
plot(tsIMU(1:length(UKFEULS(2,:))), UKFEULS(2,:)*180/pi,Color(1));
hold all;
title('Pitch (Y axis)');
if(ViconFlag)
    plot(tsVicon, VICONEULS(2,:)*180/pi,Color(2));
end
% Set the legends now
legend(NewLegend);

subplot 313
plot(tsIMU(1:length(UKFEULS(3,:))), UKFEULS(3,:)*180/pi,Color(1));
hold all;
title('Roll (X axis)');
if(ViconFlag)
    plot(tsVicon, VICONEULS(3,:)*180/pi,Color(2));
end
% Set the legends now
legend(NewLegend);

if(ErrorFlag)
    % Sync the times to get the error
    [IdxsIMU, IdxsVicon] = SyncTimes(tsIMU,tsVicon);
    Error = mean(abs((UKFEULS(:,IdxsIMU).^2-VICONEULS(:,IdxsVicon).^2)),2);
    % Mean Absolutte Difference Of Square
    disp(['MADS Error between ', Legend{1}, ' and Vicon:']);
    disp(Error);
end
end