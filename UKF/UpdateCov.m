function Pk = UpdateCov(Pkbar, Kk, Pvv)
% Computes Pk = Pkbar - KkPvvKk'
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

Pk = Pkbar - Kk*Pvv*Kk';
end

