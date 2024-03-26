clear
clc

load("dalekosaur/object.mat");
InputImage = imread("dankosaur.jpg");

patch('vertices', Xo', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
%axis vis3d;
axis equal;
xlabel('Xo-axis'); ylabel('Yo-axis'); zlabel('Zo-axis');

ObjectDirectory = 'dalekosaur';
[impoints, objpoints3D] = clickPoints( InputImage, ObjectDirectory );

M = estimateCameraProjectionMatrix(impoints, objpoints3D);

% Part 1.3
A = M(:, 1:3);
C = A * A';
lambda = 1/sqrt(C(3,3));
x_c = power(lambda,2)*C(1,3);
y_c = power(lambda,2)*C(2,3);
f_y = abs(sqrt(power(lambda,2)*C(2,2)-power(y_c,2)));
alpha = (1/f_y)*(power(lambda, 2)*C(1,2)-(x_c*y_c));
f_x = abs(sqrt(power(lambda, 2)*C(1,1)-power(alpha,2)-power(x_c, 2)));

K = [f_x, alpha, x_c; 0, f_y, y_c; 0, 0, 1]; 
R = inv(K).*lambda*A;
if det(R) ~= 1
    R = -1 .* R;
    lambda = -1 .* lambda;
end
b = M(:, 4);
t = inv(K).*lambda*b;

% Part 1.4
imgpoints2D_estim = K*[R t]*objpoints3D;
plot(impoints,"b.", imgpoints2D_estim, "ro" );
sum_squared_distance = sum(power(imgpoints2D_estim-impoints,2));