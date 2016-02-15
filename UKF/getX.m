function X = getX(x,W)
% Generates sigma points from previous state and W's
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

q = qfromx(x);
omega = omegafromx(x);
for i = 1:size(W,2)
    X(:,i) = [qmult(q,rv2q(W(1:3,i)));omegaadd(omega, W(4:6,i))];
end

X(1:4,:) = qnorm(X(1:4,:));
end