function qdelta = compqdelta(X,dt)
% Calculates qdelta which is the incremenal change in q assuming a constant
% angular velocity model
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

for i = 1:size(X,2)
    omega = omegafromx(X(:,i));
    alphadelta = norm(omega)*dt;
    if(norm(omega)~=0)
        edelta = omega/norm(omega);
    else
        edelta = [0,0,0]';
    end
    qdelta(:,i) = qaxisang2q(edelta,alphadelta);
    qdelta(:,i) = qnorm(qdelta(:,i));
end
end