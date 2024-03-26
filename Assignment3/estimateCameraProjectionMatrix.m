function M=estimateCameraProjectionMatrix( impoints2D,objpoints3D )

[n, ~] = size(impoints2D);
P = zeros(2*n, 9); 
r = zeros(1, 2*n);

    for i = 1:n
        x = impoints2D(i, 1);
        xp = objpoints3D(i, 1);
        y = impoints2D(i, 2);
        yp = objpoints3D(i, 2);
        P(2*i-1, :) = [-1*x, -1*y, -1, 0, 0, 0, x*xp, y*xp, xp];
        P(2*i, :) = [0, 0, 0, -1*x, -1*y, -1, x*yp, y*yp, yp];
        r(2*i-1) = -1*xp;
        r(2*i) = -1*yp;

    end

    if size(P,1) == 8
        [U,S,V] = svd(P);
    else
        [U,S,V] = svd(P,'econ');
    end

q = V(:,end);
q(12, 1) = 1;

A = (reshape(q, 3, 4))';

A

M = A;

end