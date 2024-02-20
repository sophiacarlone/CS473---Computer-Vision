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

m1_points = matchedPoints1.Location;
m2_points = matchedPoints2.Location ;