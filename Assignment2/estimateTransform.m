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
designmatrix = zeros(n); 

    for i = 1:2:n
        designmatrix(n, :) = {-x, -y, -1, 0, 0, 0, xxp, yxp, xp};
        designmatrix(n+1, :) = {0, 0, 0, -x, -y, -1, xyp, yyp, yp};
    end
end