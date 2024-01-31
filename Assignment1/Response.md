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