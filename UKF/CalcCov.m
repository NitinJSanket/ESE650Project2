function C = CalcCov(A,B)
% Calculates covarience between A and B
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

if(nargin<2)
    B = A';
else
    B = B';
end
    C = A*B;
    C = C./12;
    
    % Check if PSD else approximate to nearest PSD!
%     if(~all(eig(C)>=0))
%         C = nearestSPD(C);
%     end
    
end