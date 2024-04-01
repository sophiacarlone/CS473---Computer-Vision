clear
clc

load("dalekosaur/object.mat");
InputImage = imread("images/dankosaur.jpg");

%figure;
%patch('vertices', Xo', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
%axis vis3d;
%axis equal;
%xlabel('Xo-axis'); ylabel('Yo-axis'); zlabel('Zo-axis');

%% Part 1.1

ObjectDirectory = 'dalekosaur';
[impoints, objpoints3D] = clickPoints( InputImage, ObjectDirectory );

%% Part 1.2

M = estimateCameraProjectionMatrix(impoints, objpoints3D);

%% Part 1.3

A = M(:, 1:3);
C = A * A';
lambda = 1/sqrt(C(3,3));
x_c = power(lambda,2)*C(1,3);
y_c = power(lambda,2)*C(2,3);
f_y = abs(sqrt(power(lambda,2)*C(2,2)-power(y_c,2)));
alpha = (1/f_y)*(power(lambda, 2)*C(1,2)-(x_c*y_c));
f_x = abs(sqrt(power(lambda, 2)*C(1,1)-power(alpha,2)-power(x_c, 2)));

K = [f_x, alpha, x_c; 0, f_y, y_c; 0, 0, 1]; 
R = (lambda.*inv(K))*A;
if det(R) ~= 1
    R = -1 .* R;
    lambda = -1 * lambda;
end
b = M(:, 4);
t = (lambda.*inv(K))*b;

%% Part 1.4
imgpoints2D_estim = K*[R t]*[objpoints3D'; ones(1, length(objpoints3D))];
imgpoints2D_estim = imgpoints2D_estim(1:2, :)./imgpoints2D_estim(3, :);

figure;
imshow(InputImage); hold on;
x = K*[R t]*[Xo; ones(1, length(Xo))];
x = x(1:2, :)./x(3, :);
patch( 'vertices', x', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
plot( impoints(:,1)', impoints(:,2)', 'b.') ;
plot( imgpoints2D_estim(1,:), imgpoints2D_estim(2,:), 'ro' );
hold off;

sum_squared = sum((impoints-imgpoints2D_estim').^2);

%% Part 2
%%%%% Auto generated MATLAB code from Camera Calibrator app

% Define images to process
imageFileNames = {'images/checker3.jpg',...
    'images/checker2.jpg',...
    'images/checker1.jpg',...
    };
% Detect calibration pattern in images
detector = vision.calibration.monocular.CheckerboardDetector();
[imagePoints, imagesUsed] = detectPatternPoints(detector, imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates for the planar pattern keypoints
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateWorldPoints(detector, 'SquareSize', squareSize);

% Calibrate the camera
[cameraParamters, ~, ~] = estimateCameraParameters(imagePoints, worldPoints, ...
    'ImageSize', [mrows, ncols]);

%%%%%%

K_checker = cameraParamters.K
K

imgpoints2D_estim_checker = K_checker*[R t]*[objpoints3D'; ones(1, length(objpoints3D))];
imgpoints2D_estim_checker = imgpoints2D_estim_checker(1:2, :)./imgpoints2D_estim_checker(3, :);
figure;
imshow(InputImage); hold on;
x_checker = K_checker*[R t]*[Xo; ones(1, length(Xo))];
x_checker = x_checker(1:2, :)./x_checker(3, :);
patch( 'vertices', x_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
plot( impoints(:,1)', impoints(:,2)', 'b.') ;
plot( imgpoints2D_estim(1,:), imgpoints2D_estim(2,:), 'ro' );
hold off;


%% Part 3

% Surface 1
s1 = imread("images/surface1.jpg");

% rotation and translation matrices
Rp = [];
tp = [];

% K
figure;
imshow(s1); hold on;
X_transformed1 = [R t]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure;
imshow(s1); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% Surface 2
s2 = imread("images/surface2.jpg");

% rotation and translation matrices
Rp = [];
tp = [];

% K
figure;
imshow(s2); hold on;
X_transformed2 = [R t]*[Xo; ones(1, length(Xo))];
x_projected2_estim = K*X_transformed2;
x_projected2_estim = x_projected2_estim(1:2, :)./x_projected2_estim(3, :);
patch( 'vertices', x_projected2_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure;
imshow(s2); hold on;
x_projected2_checker = K_checker*X_transformed2;
x_projected2_checker = x_projected2_checker(1:2, :)./x_projected2_checker(3, :);
patch( 'vertices', x_projected2_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% Surface 3
s3 = imread("images/surface3.jpg");

% rotation and translation matrices
Rp = [];
tp = [];

% K
figure;
imshow(s3); hold on;
X_transformed3 = [R t]*[Xo; ones(1, length(Xo))];
x_projected3_estim = K*X_transformed3;
x_projected3_estim = x_projected3_estim(1:2, :)./x_projected3_estim(3, :);
patch( 'vertices', x_projected3_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure;
imshow(s3); hold on;
x_projected3_checker = K_checker*X_transformed3;
x_projected3_checker = x_projected3_checker(1:2, :)./x_projected3_checker(3, :);
patch( 'vertices', x_projected3_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;