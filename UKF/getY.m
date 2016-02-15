function Y = getY(X,dt)
% Applies the process update onto X to generate Y
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

Y = zeros(size(X));
for i = 1:size(X,2)
    q = qfromx(X(:,i));
    omega = omegafromx(X(:,i));
    qdelta = rv2q(omega,dt);
    Y(:,i) = [qmult(q,qdelta);omega];
end

Y(1:4,:) = qnorm(Y(1:4,:));
end
