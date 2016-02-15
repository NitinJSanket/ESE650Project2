function [qbar,eivec] = IntrinsicGradientDescent(Y, qbar, Thld, MaxIter)
% Use Intrinsic Gradient Descent to compute mean quaternion
% Code by: Nitin J. Sanket, nitinsan@seas.upenn.edu

eivecmean = [1,0,0]';
iter = 1;
while(norm(eivecmean)>=Thld && iter <=MaxIter)
    % Do for all transformed sigma points
    for i = 1:size(Y,2)
        qi = qfromx(Y(:,i));
        % Error Quaternion
        ei = qmult(qi, qinv(qbar));
        % Error Rotation vector
        eivec(:,i) = q2rv(ei);
    end
    % Compute mean of eivec
    eivecmean = mean(eivec,2);
    % Get back quaternion of this mean eivec
    eimean = rv2q(eivecmean);
    qbar = qmult(eimean, qbar);   
    iter = iter+1;
end
% disp(['Converged in ',num2str(iter-1),' iterations....']);
end