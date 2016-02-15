function Wdash = getWdash(Y)
% Computes Wdash from mean centered Y
Wdash = zeros(6,size(Y,2));

for i = 1:size(Y,2)
    Wdash(:,i) = [q2rv(Y(1:4,i))';Y(5:7,i)];
end
end