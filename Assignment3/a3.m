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

sum_squared = sum((imgpoints2D_estim'-impoints).^2);

%% Part 2
% Auto generated MATLAB code from Camera Calibrator app

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
[K_checker, ~, ~] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

K_checker

%% Part 3

% TBD