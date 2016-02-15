function omega = omegafromx(x)
% Extracts the omega from the state vector x
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu
omega = x(5:7,:);
end