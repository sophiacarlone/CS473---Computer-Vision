function A=estimateTransform( im1_points, im2_points )
%double(im1_points)
%double(im2_points)
% Set up design matrix P: size = 2*size(pts1i,1) x 9

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
P = zeros(n, 9); 
%double(P);
r = zeros(1, n);

    for i = 1:n
        x = double(im1_points(i, 1));
        xp = double(im2_points(i, 1));
        y = double(im1_points(i, 1));
        yp = double(im2_points(i, 1));
        P(n, :) = {times(-1.0, x), times(-1.0, y), -1.0, 0.0, 0.0, 0.0, times(x,xp), times(y,xp), xp};
        P(n+1, :) = {0, 0, 0, times(-1,x), times(-1,y), -1, times(x,yp), times(y,yp), yp};
        r(n) = times(-1, xp);
        r(n+1) = times(-1, yp);
        n = n +1;
    end


    if size(P,1) == 8
        [U,S,V] = svd(P);
    else
        [U,S,V] = svd(P,'econ');
    end

q = V(:,end);

end