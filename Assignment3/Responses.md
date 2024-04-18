# 1.4

Comment on sum_squared

# 2

Using the images of the checkerboard, we found

\[
    K_checker=\begin{bmatrix}
        2.8345\text{e}+03 & 0 & 1.5047\text{e}+03 \\
        0 & 2.8358\text{e}+03 & 1.9654\text{e}+03 \\
        0 & 0 & 1 \\
    \end{bmatrix}.
\]

Additionally, we estimated that

\[
    K=\begin{bmatrix}
        2.6495\text{e}+03 & -1.0324\text{e}+03 & -3.8967\text{e}+03 \\  
        0 & 1.1764\text{e}+03 & 3.2343\text{e}+03 \\
        0 & 0 & 1
    \end{bmatrix}.
\]

We figured the error in our estimated K came from both the fact that K is an estimate from only 6 points. Additionally, since we choose the points on both images, there may be some human error in the exact locations of points we chose on both the image and the object.

# 3
K:
![picture](./images/cv1.png);
The operations used include: 
None. First mesh for k

KChecker:
![picture](./images/cv2.png);
The operations used include: 
None. First mesh for k_checker

K:
![dank3](./images/dank3.png);
The operations used include: 
Rotated in the y axis 60 degrees, and in the z axis -20 degrees. Then translated a bit to fit better in the scene.

KChecker:
![picture](./images/dank4.png);
The operations used include: 
Rotated in the y axis 60 degrees, and in the z axis -20 degrees. Then translated a bit to fit better in the scene.

K:
![picture](./images/dank5.png);
The operations used include:
Rotated down a bit in the y axis, and then translating it a bit in the z direction.

KChecker:
![picture](./images/dank6.png);
The operations used include:
Rotated down a bit in the y axis, and then translating it a bit in the z direction.

K:
![picture](./images/dank7.png);
The operations used include:
Rotated in the y axis by 140 degrees and a bit in the z axis to look more realistic. Translated back a bit.

KChecker:
![picture](./images/dank8.png);
The operations used include:
Rotated in the y axis by 140 degrees and a bit in the z axis to look more realistic. Translated back a bit.

K:
![picture](./images/dank9.png);
The operations used include:

KChecker:
![picture](./images/dank10.png);
The operations used include:

K:
![picture](./images/dank11.png);
The operations used include:

KChecker:
![picture](./images/dank12.png);
The operations used include:

K:
![picture](./images/dank13.png);
The operations used include:

KChecker:
![picture](./images/dank14.png);
The operations used include:

K has worse quality than Kchecker. This may be due the estimates for K are less accurate as they are more likely to face human error.