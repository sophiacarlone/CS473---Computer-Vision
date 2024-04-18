clear
clc; close all

load("dalekosaur/object.mat");
InputImage = imread("dankosaur.jpg");

%figure;
%patch('vertices', Xo', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
%axis vis3d;
%axis equal;
%xlabel('Xo-axis'); ylabel('Yo-axis'); zlabel('Zo-axis');

%% Part 1.1

ObjectDirectory = 'dalekosaur';
% To avoid taking forever we hard coded good data points
%[impoints, objpoints3D] = clickPoints( InputImage, ObjectDirectory );
impoints = [1.9613e+03, 1.1966e+03;
1.8009e+03, 1.9388e+03;
2.1619e+03, 2.0892e+03;
2.4327e+03, 1.9187e+03;
2.2121e+03, 1.3269e+03;
1.9413e+03, 1.6880e+03];
objpoints3D = [-1.5103, 4.0311, 0.7595;
-2.6233, -4.2289, 2.6159;
2.6455, -4.2127, 2.6926;
2.6898, -4.2983, -2.5683;
0.7712, 2.9394, -0.8908;
-1.7499, -0.9340, 0.7141];

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
imageFileNames = {'chec1.jpg',...
    'chec2.jpg',...
    'chec3.jpg',...
    'chec4.jpg',...
    'chec5.jpg',...
    'chec6.jpg',...
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

R1 = [0.3 0 0;0 0.3 0; 0 0 0.3];
t1 = [-1400; -600; 0];
imgpoints2D_estim_checker = inv(K_checker)*[R1 t1]*[objpoints3D'; ones(1, length(objpoints3D))];
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

%% Surface 1
s1 = imread("s1.jpg");

% IMAGE 1
Rp = RotationMatrixMaker(0, 60, -20);
tp = TranslationMatrixMaker(8, 2, -13);
% K
figure(111);
imshow(s1); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(112);
imshow(s1); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% IMAGE 2
Rp = RotationMatrixMaker(0, 5, 0);
tp = TranslationMatrixMaker(5, 0, -13);
% K
figure(121);
imshow(s1); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(122);
imshow(s1); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% IMAGE 3
Rp = RotationMatrixMaker(0, -140, -10);
tp = TranslationMatrixMaker(-2, 0, -13);
% K
figure(131);
imshow(s1); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(132);
imshow(s1); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

%% Surface 2
s2 = imread("s2.jpg");

% IMAGE 1
Rp = RotationMatrixMaker(0, -90, 10);
tp = TranslationMatrixMaker(5, 0, -13);
% K
figure(211);
imshow(s2); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(212);
imshow(s2); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% IMAGE 2
Rp = RotationMatrixMaker(0, -180, -3 );
tp = TranslationMatrixMaker(5, 0, -18);
% K
figure(221);
imshow(s2); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(222);
imshow(s2); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;

% IMAGE 3
Rp = RotationMatrixMaker(15, -30, 10);
tp = TranslationMatrixMaker(10, 0, -20);
% K
figure(231);
imshow(s2); hold on;
X_transformed1 = [Rp tp]*[Xo; ones(1, length(Xo))];
x_projected1_estim = K*X_transformed1;
x_projected1_estim = x_projected1_estim(1:2, :)./x_projected1_estim(3, :);
patch( 'vertices', x_projected1_estim', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;
% K_checker
figure(232);
imshow(s2); hold on;
x_projected1_checker = K_checker*X_transformed1;
x_projected1_checker = x_projected1_checker(1:2, :)./x_projected1_checker(3, :);
patch( 'vertices', x_projected1_checker', 'faces', Faces, 'facecolor', 'n', 'edgecolor', 'k' );
hold off;