function YMeanCentered = MeanCenterY(xkbar,Y)
% Mean Centers Y data
for i = 1:size(Y,2)
    YMeanCentered(1:4,i) = qmult(qinv(xkbar(1:4)),Y(1:4,i));
end
YMeanCentered(5:7,:) = bsxfun(@minus,Y(5:7,:),xkbar(5:7));

end