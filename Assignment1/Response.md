# Response
## Question 1
We think that inverting translation means that we are going in the negative direction intended. <br>
The matrix would be:

```math
M_T^{-1} = 
\begin{bmatrix}
1 & 0 & -t_x \\
0 & 1 & -t_y \\
0 & 0 & 1
\end{bmatrix}
```

## Question 2
We think that inverting rotation means that we are flipping the sign for Theta. Because of the properties of cosine and sine, only sine will show a switch in the sign. <br>
The matrix would be:

```math
M_R^{-1} = 
\begin{bmatrix}
\cos{\theta} & -\sin{\theta} & 0 \\
\sin{\theta} & \cos{\theta} & 0 \\
0 & 0 & 1
\end{bmatrix}
```

## Question 3
The inverse of a reflection is the original state of the matrix. To get back to the original state of the matrix, all that is needed is to apply the reflection matrix again. Since the reflection matrix applies -1 on the coordinates, applying -1 again will cancel it out. 

## Question 4
The inverse of a shear is a shear to place it back to the original image.
 <br>
The matrix would be:

```math
M_{S_x}^{-1} = 
\begin{bmatrix}
1 & r_x\\
0 & 1\\
\end{bmatrix} ^{-1}
= 
\frac{1}{(1)(1)-(r_x)(0)}
*
\begin{bmatrix}
1 & -(r_x)\\
0 & 1\\
\end{bmatrix}
=
\begin{bmatrix}
1 & -(r_x)\\
0 & 1\\
\end{bmatrix}
```
<br>
For the y direction, everything would be the same, except that the $-{r_x}$ on the top right and the ${0}$ on the bottom left would be switched:
```math
\begin{bmatrix}
1 & -(r_x)\\
0 & 1\\
\end{bmatrix}
```