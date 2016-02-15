function [KFEULS, rotsKF] = RunKF(Acc, Gyro, tsIMU, NIter)
% Runs a Complementary Filter Code for attitude estimation
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

% State is defined as [omegax, omegay, omegaz, roll, pitch, yaw]'

%% Allocate space for variables
% Store Euler Angles estimated by UKF
KFEULS = zeros(3,size(Acc,2));
rotsKF = zeros(3,3,size(Acc,2));

P = 1e-2*eye(6);
% Process Model Noise Covariance
Q = diag([0.01*ones(1,3),0.1*ones(1,3)]);
% Measurement Model Noise Covariance
R = diag([0.01*ones(1,3),0.1*ones(1,3)]);
% Initial state is all zeros, starting from rest
x = zeros(6,1);

disp('KF Execution Started....');
h = waitbar(0,'KF Running....');

for i = 1:NIter
    
    % if(any(any(isnan(P))))
    %     pause;
    % end
    if(i==1)
        dt = 0.01;
    else
        dt = tsIMU(i)-tsIMU(i-1);
    end
    
    A = [0, 0,  0,  1,  0,  0;
        0, 0,  0,  0,  1,  0;
        0, 0,  0,  0,  0,  1;
        1, 0,  0,  dt, 0,  0;
        0, 1,  0,  0, dt,  0;
        0, 0,  1,  0,  0, dt;];
    
    C = eye(6);
    
    %% Prediction
    x = A*x;
    P = A*P*A'+Q;
    
    %% Update
    K = P*C'/(C*P*C'+R);
    P = P - K*C;
    z = [Gyro(1,i),Gyro(2,i),Gyro(3,i),atan2(Acc(2,i),sqrt(Acc(1,i).^2+Acc(3,i).^2)),atan2(-Acc(1,i),sqrt(Acc(2,i).^2+Acc(3,i).^2)),atan2(sqrt(Acc(1,i).^2+Acc(2,i).^2),Acc(3,i))]';
    x = x + K*(z-C*x);
    
    %% Save
    KFEULS(:,i) = [x(6),x(5),x(4)]';
    rotsKF(:,:,i) = eul2rotm(KFEULS(:,i)');
    waitbar(i/NIter);
end

close(h);

disp('KF Execution Completed....');

end