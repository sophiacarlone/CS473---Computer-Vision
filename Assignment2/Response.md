## Part 3
Self reporting A matrices <b>

From given impoints:
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

We choose the error threashold at 2 .<b>
We chose the RANSAC iterations at 10,000 because that is what we were told. <b>

## Part 7

```math
A = \begin{bmatrix}
a & b & t_x \\
-b & a & t_y \\
0 & 0 & 1
\end{bmatrix}

P = \begin{bmatrix}
-x & -y & -1 & 0 \\
-y & x & 0 & -1 \\
-x & -y & -1 & 0 \\
-y & x & 0 & -1 \\
... & ... & ... & ... 
\end{bmatrix}

```
q has 4 elements. <b>
P has 4 columns. <b>
We need at least 2 correspondences.
