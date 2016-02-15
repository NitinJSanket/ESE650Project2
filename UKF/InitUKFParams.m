function [x, P, R, Q, n] = InitUKFParams()
% Initializes all parameters for the UKF
% Initial state is the zero quaternion and zero angular velocities
% x = [q0,q1,q2,q3,omega1,omega2,omega3]';
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

% Initial state vector assuming system starts from rest on the ground
x = [1,0,0,0,0,0,0]';
% n is 6 as unit quaternion is assumed
n = 6;

% Initial Covariance Matrix
P = 1e-2*eye(6);
% Process Model Noise Covariance
Q = diag([100*ones(1,3),0.1*ones(1,3)]);
% Measurement Model Noise Covariance
R = diag([0.5*ones(1,3),1e-2*ones(1,3)]);
end