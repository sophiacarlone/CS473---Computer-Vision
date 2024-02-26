## Part 3

From given im_points, we found the example <b>A</b>:

```
>> bm = [1373, 1204; 1841, 1102; 1733, 1213; 2099, 1297]

bm =

        1373        1204
        1841        1102
        1733        1213
        2099        1297

>> am = [128, 1160; 728, 1055; 617, 1172; 1001, 1247]

am =

         128        1160
         728        1055
         617        1172
        1001        1247

>> estimateTransform(bm, am)

A =

   -0.0005   -0.0002    0.8416
   -0.0001   -0.0006    0.5401
   -0.0000   -0.0000    0.0001

```

We choose the error threshold to be 2 since we want the error for both our X and Y coordinates to be less than one. That is, we want

```math
(x'_{\text{actual}}-x'_{\text{estim}})^2\leq 1,\text{ }
(y'_{\text{actual}}-y'_{\text{estim}})^2\leq 1.
```

We chose the RANSAC iterations at 10,000 since it is a large number and what we were told to use in class. <br>

## Part 7

We rearranged <b>A</b> to find the design matrix as follows:

```math
A = \begin{bmatrix}
a & b & t_x \\
-b & a & t_y \\
0 & 0 & 1
\end{bmatrix}
```

```math
\hat{x}'=ax+by+t_x
```

```math
\hat{y}'=-bx+ay+t_y
```

```math
\hat{w}'=0+0+1=1
```

```math
x'=\frac{\hat{x}'}{\hat{w}'}=\frac{ax+by+t_x}{1}
```

```math
-x'=-(ax+by+t_x)=-ax-by-t_x+0\cdot t_y
```

```math
y'=\frac{\hat{y}'}{\hat{w}'}=\frac{-bx+ay+t_y}{1}
```

```math
-y'=-(-bx+ay+t_y)=bx-ay+0\cdot t_x-t_y
```

```math
P = \begin{bmatrix}
-x_1 & -y_1 & -1 & 0 \\
-y_1 & x_1 & 0 & -1 \\
-x_2 & -y_2 & -1 & 0 \\
-y_2 & x_2 & 0 & -1
\end{bmatrix},
q = \begin{bmatrix}
a \\
b \\
t_x \\
t_y
\end{bmatrix},
r = \begin{bmatrix}
-x_1' \\
-y_1' \\
-x_2' \\
-y_2'
\end{bmatrix}
```

q has 4 elements. <br>
P has 4 columns. <br>
We need at least 2 correspondences to solve a similarity transform.
