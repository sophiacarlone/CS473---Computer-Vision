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

We choose the error threashold at 2 because .<b>
We chose the RANSAC iterations at 10,000 because that is what we were told. <b>

## Part 7
