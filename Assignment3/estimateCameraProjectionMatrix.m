function M=estimateCameraProjectionMatrix( impoints2D,objpoints3D )

[n, ~] = size(impoints2D);
P = zeros(2*n, 11); 
r = zeros(1, 2*n);

    for i = 1:n
        x = impoints2D(i, 1);
        Xo = objpoints3D(i, 1);
        y = impoints2D(i, 2);
        Yo = objpoints3D(i, 2);
        Zo = objpoints3D(i, 3);
        P(2*i-1, :) = [-1*Xo, -1*Yo, -1*Zo, -1, 0, 0, 0, 0, x*Xo, x*Yo, x*Zo];
        P(2*i, :) = [0, 0, 0, 0, -1*Xo, -1*Yo, -1*Zo, -1, y*Xo, y*Yo, y*Zo];
        r(2*i-1) = -1*x;
        r(2*i) = -1*y;
    end

q = inv(P'*P)*P'*r';
q(12, 1) = 1;

A = (reshape(q, 4, 3))';

M = A;

end