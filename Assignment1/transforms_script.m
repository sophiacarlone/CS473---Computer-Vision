open transformImage.m
clear; clc;

%% original image
figure(10)
I = imread("Image1.png");
imshow(I)

%% change size to 1080x1920
%A = [];
%I_t = transformImage( I, A, "scaling" );
%figure(1)
%imshow(I_t)

%% reflect in y direction
A = [ 1,0,0; 0,-1,0; 0,0,1 ];
I_t = transformImage( I, A, "reflection" );
figure(2)
imshow(I_t)

%% rotate clockwise by 30 deg
t = deg2rad(30);
A = [ cos(t),-sin(t),0; sin(t),cos(t),0; 0,0,1 ];
I_t = transformImage( I, A, "rotation" );
figure(3)
imshow(I_t)

%% shear so amount added to each x is 0.5 times each y
A = [ 1,.5,0; 0,1,0; 0,0,1 ];
I_t = transformImage( I, A, "shear" );
figure(4)
imshow(I_t)

%% translate 300 in X, 500 in Y, rotate CC 20 deg, scale down to 0.5x size
% supposed to be in one call of transformImage
t = deg2rad(-20);
A = [(.5 *cos(t)),(.5 * -sin(t)),300; (.5 * sin(t)),(.5 * cos(t)),500; 0,0,1];
I_t = transformImage( I, A, "transform" );
figure(5)
imshow(I_t)

%% two affine transformations
A = [ 1,.4,.4; .1,1,.3; 0,0,1 ];
I_t = transformImage( I, A, "affine" );
figure(61)
imshow(I_t)

A = [ 2.1,-.35,-.1; -.3,.7,.3; 0,0,1 ];
I_t = transformImage( I, A, "affine" );
figure(62)
imshow(I_t)

%% two homographies
A = [ .8,.2,.3; -.1,.9,-.1; .0005,-.0005,1 ];
I_t = transformImage( I, A, "homography" );
figure(71)
imshow(I_t)
imwrite(I_t, "Image2.png");

% This part not working for some reason
%A = [ 29.25,13.95,20.25; 4.95,35.55,9.45; .045,.09,45 ];
%I_t = transformImage( I, A, "homography" );
%figure(72)
%imshow(I_t)
