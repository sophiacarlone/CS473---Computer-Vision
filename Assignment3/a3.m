clear;clc;

% Read dalekosaur image and model
load dalekosaur/object.mat
InputImage = imread('images/dankosaur.jpg');

%% Part  1
ObjectDirectory = 'dalekosaur';
% r-15, d-1
[impoints, objpoints3D] = clickPoints( InputImage, ObjectDirectory );

figure;
imshow(InputImage); hold on;
plot( impoints(:,1), impoints(:,2), 'b.');

figure;
patch('vertices', Xo', 'faces', Faces, 'facecolor', 'w', 'edgecolor', 'k');
axis vis3d;
axis equal;
plot3( objpoints3D(:,1), objpoints3D(:,2), objpoints3D(:,3), 'b.' );
