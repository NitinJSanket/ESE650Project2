function xkbarhat = UpdateState(xkbarhat, Kk, vk)
% Computes xkhat as xkbarhat + Kkvk
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

Kkvk = Kk*vk;
qpart = qmult(xkbarhat(1:4),rv2q(Kkvk(1:3)));
qpart = qpart./norm(qpart);
xkbarhat = [qpart;xkbarhat(5:7) + Kkvk(4:6)];
end

    