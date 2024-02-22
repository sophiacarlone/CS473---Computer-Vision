open transformImage.m

%% Part 3

function A=estimateTransform( im1_points, im2_points )
%only doing the homography on one of the images
%use homography least squares

% xph = ax+by+c
% yph = dx+ey+f
% wph = gx+hy+1(i)

% xp = xph/wph
% yp = yph/wph

%[-x, -y, -1, 0, 0, 0, xxp, yxp, xp] [a] = [-xp] x1
%[0, 0, 0, -x, -y, -1, xyp, yyp, yp] [b] = [-yp] y1
%repeat for x2 and y2 and so on
%x is from im1 and xp is from im2, same for ys

[n, throwaway] = size(im2_points);
n = 2*n; %check
designmatrix = zeros(n); 
r = zeros(1, n);

    for i = 1:n
        x = im1_points(n, 1);
        xp = im2_points(n, 1);
        y = im1_points(n, 1);
        yp = im2_points(n, 1);
        designmatrix(n, :) = {-1*x, -1*y, -1, 0, 0, 0, x*xp, y*xp, xp};
        designmatrix(n+1, :) = {0, 0, 0, -1*x, -1*y, -1, x*yp, y*yp, yp};
        r(n) = (-1* xp);
        r(n+1) = (-1* yp);
        n = n +1;
    end
end