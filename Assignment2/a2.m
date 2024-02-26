open transformImage.m
clear
clc

open estimateTransform.m
open estimateTransformRansac.m

%% Part 2
% match pairs of points between images

im1 = imread("Image1.jpg");
im2 = imread("Image2.jpg");

im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

im1 = im2double(im1);
im2 = im2double(im2);

points1 = detectSURFFeatures( im1 );
points2 = detectSURFFeatures( im2 );

features1 = extractFeatures( im1,points1 );
features2 = extractFeatures( im2,points2 );

indexPairs = matchFeatures( features1, features2, "Unique", true );

matchedPoints1 = points1( indexPairs( :,1 ) );
matchedPoints2 = points2( indexPairs( :,2 ) );

im1_points = matchedPoints1.Location;
im2_points = matchedPoints2.Location;

%% Part 3
% use RANSAC to estimate transform matrix

A = estimateTransformRansac(im1_points, im2_points);

%% Part 4
% transform im2 to im1

im2_transformed = transformImage( im2, inv(A), "homography" );
nanlocations = isnan( im2_transformed );
im2_transformed( nanlocations )=0;
imshow(im2_transformed)

%% Part 5
% expand the canvas of im1

[h1, w1] = size(im1);
[h, w] = size(im2_transformed);
im1_expanded = zeros(h,w);
im1_expanded(1:h1,1:w1) = im1;

%% Part 6
% get user input to create a blend between im1 and im2

imshow(im1_expanded)
[x_overlap, y_overlap] = ginput(2);
overlapleft = round( x_overlap(1) );
overlapright = round( x_overlap(2) );

zeros_till_overlapleft = zeros(1,overlapleft-1);
ones_till_overlapright = ones(1,w-overlapright);
stepvalue = 1/(overlapright-overlapleft);
steps = 0:stepvalue:1;

ramp=[zeros_till_overlapleft, steps, ones_till_overlapright]; % 0->stepsize->2
plot(ramp)

im1_blend = im1_expanded .* abs(1-ramp); % inverse the ramp signal
im2_blend = im2_transformed .* ramp;

% blended panorama!
impanorama=im1_blend+im2_blend;
imshow(impanorama)

imwrite(im2_transformed, "Image2_Transformed.png");
imwrite(im1_expanded, "Image1_Expanded.png");
imwrite(im1_blend, "Image1_Blended.png");
imwrite(im2_blend, "Image2_Blended.png");
imwrite(impanorama, "Image_Panorama.png");