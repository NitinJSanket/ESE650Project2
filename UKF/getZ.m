function Z = getZ(Y)
% Applies the measurement update onto Y to generate Z
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

% g vector quaternion
ginWorld = [0,0,0,1]';

Z = zeros(6,size(Y,2));
for i = 1:size(Y,2)
    q = qfromx(Y(:,i));
    omega = omegafromx(Y(:,i));
    Z(:,i) = [q2rv(qmult(qmult(qinv(q),ginWorld),q))';omega];
end
% Remove the first element of the quaternion to get back the rotation
% vector!
% Z = Z(2:end,:);

end


