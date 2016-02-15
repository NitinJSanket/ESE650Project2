function q = qfromx(x)
% Extracts the quaternion from the state vector x
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu
q = x(1:4,:);
end