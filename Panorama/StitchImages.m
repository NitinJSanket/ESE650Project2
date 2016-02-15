function Canvas = StitchImages(cam, rotsIMU, tsCam, tsIMU, CanvasSize, f, FrameSkip, FrameInterval, Wt)
% Code for stitching images given the attitude from UKF
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

if(nargin<9)
    f = 240; % Focal Length
    CanvasSize = [1000,1000,3];
    FrameSkip(1:2) = 150;
    FrameInterval = 10;
    Wt = 0.5;
end

%% Synchronize Camera and IMU Times
[IdxsCamStitch, IdxsIMUStitch] = SyncTimes(tsCam,tsIMU);

%% Define camera parameters
% Image size
[m,n,~] = size(cam(:,:,1));
% Get all the co-ordinates
[u,v] = meshgrid(1:n,1:m);
% Decide how big your canvas should be
Canvas = zeros(CanvasSize);

[mCanvas, nCanvas, ~] = size(Canvas);
% Translate points to origin
WorldPts = [u(:)';v(:)';f*ones(1,m*n)];
WorldPts = bsxfun(@plus,WorldPts,[-m/2,-n/2,0]');


for i = FrameSkip(1):FrameInterval:length(IdxsIMUStitch)-FrameSkip(2)
    I = im2double(cam(:,:,:,IdxsCamStitch(i)));
    R = rotsIMU(:,:,IdxsIMUStitch(i));
    
    % Translate to origin first and then rotate
    WorldPtsTransformed = R*[0,0,1;-1,0,0;0,-1,0]*WorldPts;
    
    Thetas = atan2(WorldPtsTransformed(2,:),WorldPtsTransformed(1,:));
    h = WorldPtsTransformed(3,:)./sqrt(WorldPtsTransformed(1,:).^2+WorldPtsTransformed(2,:).^2);
    
    xyhat = bsxfun(@plus,[-f*Thetas;f*h],[round(nCanvas/2);round(mCanvas/2)]);
    for j = 1:length(xyhat)
        try
            if(any(xyhat(:,j)<0) || xyhat(1,j)>nCanvas || xyhat(2,j)>mCanvas)
                continue;
            end
            if(Wt~=0)
            % Average this with the previous value!
            Canvas(round(xyhat(2,j)+1),round(xyhat(1,j)+1),:) = (sum(Canvas(round(xyhat(2,j)+1),round(xyhat(1,j)+1),:))==0)*I(v(j),u(j),:) +...
                (sum(Canvas(round(xyhat(2,j)+1),round(xyhat(1,j)+1),:))~=0)*(Wt.*I(v(j),u(j),:) + (1-Wt).*Canvas(round(xyhat(2,j)+1),round(xyhat(1,j)+1),:));
            else
                Canvas(round(xyhat(2,j)+1),round(xyhat(1,j)+1),:) = I(v(j),u(j),:);
            end
        catch
            continue;
        end
    end
    imshow(flipud(Canvas));
    drawnow;
end

Canvas = flipud(Canvas);
end