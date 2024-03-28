function M=estimateCameraProjectionMatrix( impoints2D,objpoints3D )

[n, ~] = size(impoints2D);
P = zeros(2*n, 11); 
r = zeros(1, 2*n);

    for i = 1:n
        x = impoints2D(i, 1);
        xp = objpoints3D(i, 1);
        y = impoints2D(i, 2);
        yp = objpoints3D(i, 2);
        zp = objpoints3D(i, 3);
        P(2*i-1, :) = [-1*xp, -1*yp, -1*zp, -1, 0, 0, 0, 0, x*xp, x*yp, x*zp];
        P(2*i, :) = [0, 0, 0, 0, -1*xp, -1*yp, -1*zp, -1, y*xp, y*yp, y*zp];
        r(2*i-1) = -1*x;
        r(2*i) = -1*y;
    end

q = inv(P'*P)*P'*r';
q(12, 1) = 1;

A = (reshape(q, 4, 3))';

M = A;

end