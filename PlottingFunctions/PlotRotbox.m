function PlotRotbox(Flags,NumSamples,AllRots,VideoFlag, Vid)
% Plot rotbox
% AllRots is a cell array with all the rotation matrices
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

if(nargin<5)
    VideoFlag = 0;
end
% Number of Subplots Needed
NSubPlots = sum(Flags);
Legend = {'Gyro', 'Acc', 'CF', 'KF', 'UKF', 'Vicon'};
LegendIdxs = find(Flags);

figure('units','normalized','outerposition',[0 0 1 1]);
for samples = 1:NumSamples
    for i=1:NSubPlots
        subplot(1,NSubPlots,i)
        rotplot(AllRots{LegendIdxs(i)}(:,:,samples));
        title(Legend{LegendIdxs(i)});
        drawnow;
    end
    axes('Position',[0 0 1 1],'Visible','off');
    text(0.45,0.95,num2str(samples));
    drawnow;
    if(VideoFlag)
      writeVideo(Vid, getframe(gca)); 
    end
end

if(VideoFlag)
   close(Vid); 
end
end