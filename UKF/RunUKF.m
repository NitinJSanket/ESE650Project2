% Runs Unscented Kalman Filter Code for attitude estimation
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

%% Allocate space for variables
% Store Euler Angles estimated by UKF
UKFEULS = zeros(3,size(Acc,2));
XSaved = zeros(7,size(Acc,2));
rotsUKF = zeros(3,3,size(Acc,2));

%%  Unscented Kalman Filter
%% Initialize Filter Parameters
[x, Pk, R, Q, n] = InitUKFParams();

disp('UKF Execution Started....');
NIter = size(vals,2);
h = waitbar(0,'UKF Running....');
for i = 1:NIter
%     disp(['Iteration ',num2str(i)]);
    %% Generate Sigma Points
    S = chol(Pk+Q); % Square root matrix
    Wdash = [sqrt(n)*S, -sqrt(n).*S];
    % Sigma Points
    X = getX(x,Wdash);
    
    %% Process Model Update
    if (i == 1)
        dt = 0.01; % First sample assume this dt
    else
        dt = tsIMU(i)-tsIMU(i-1); % ts(k)-ts(k-1)
    end
    
    % Transform the sigma points X to get Y
    % Apply the process model update
    Y = getY(X,dt);
    
    % Compute mean of the quaternion using Intrinsic Gradient Descent
    % Initialize the mean to previous state
    qbar = X(1:4,1);
    
    % Run Intrinsic Gradient Descent
    [qbar,eivec] = IntrinsicGradientDescent(Y, qbar, 1e-5, 1000);
    
    xkbar = [qnorm(qbar);mean(Y(5:7,:),2)];
    
    % Get Wdash
    % Mean Center Y
    YMeanCentered = MeanCenterY(xkbar,Y);
    Wdash = getWdash(YMeanCentered);
    
    % Get Covariance
    Pkbar = CalcCov(Wdash);
    
    
    %% Measurement Model
    % Apply the measurement model!
    Z = getZ(Y);
    
    % Compute mean
    zkbar = mean(Z,2);
    
    % Mean Center Z
    ZMeanCentered = bsxfun(@minus,Z,zkbar);
    
    % Observed Data
    zk = [Acc(:,i);Gyro(:,i)];
    
    % Compute Innovation term vk
    vk = zk - zkbar;
    
    % Compute covariences
    Pzz = CalcCov(ZMeanCentered);
    Pvv = Pzz+R;
    
    % Compute Pxz
    Pxz = CalcCov(Wdash,ZMeanCentered);
    
    % Kalman Gain
    Kk = Pxz/Pvv;
    
    xkbarhat = [xkbar(1:4);mean(Y(5:7,:),2)];
    xkbarhat = UpdateState(xkbarhat, Kk, vk);
    Pk = UpdateCov(Pkbar, Kk, Pvv);
    
    
    %% Update State
    xkbarhat = real(xkbarhat);
    x = xkbarhat;
    
    %% Save the euler angles and state
    XSaved(:,i) = x;
    UKFEULS(:,i) = quat2eul(xkbarhat(1:4)')';
    rotsUKF(:,:,i) = quat2rotm(XSaved(1:4,i)'); 
    waitbar(i/NIter);
end
close(h);

disp('UKF Execution Completed....');
%% Stitch Images
if(CamFlag)
    CanvasUKF = StitchImages(Imgs, rotsUKF, tsCam, tsIMU, CanvasSize, f, FrameSkip, FrameInterval,Wt);
    if(SaveFlag)
       imwrite(CanvasUKF,['UKFPanof',num2str(f),'.jpg']); 
    end
end
