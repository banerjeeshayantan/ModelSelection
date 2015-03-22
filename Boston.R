> library(MASS)
> data(Boston)#the famous Boston housing data set from UCI ML repository
> names(Boston)#colnames in the dataset
 [1] "crim"    "zn"      "indus"   "chas"    "nox"     "rm"      "age"     "dis"    
 [9] "rad"     "tax"     "ptratio" "black"   "lstat"   "medv"   
> sample_index = sample(nrow(Boston),nrow(Boston)*0.90)#partitioning the dataset
> Boston_train = Boston[sample_index,]#the training dataset(with 90% of the datapoints)
> Boston_test = Boston[-sample_index,]#the testing dataset(with the remaining datapoints)
> model= lm(medv~., data=Boston_train)#just training a model based on linear regression
> summary(model)#here is the summary of the linear regression coefficients

Call:
lm(formula = medv ~ ., data = Boston_train)

Residuals:
    Min      1Q  Median      3Q     Max 
-10.823  -2.885  -0.544   1.931  25.572 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  36.337297   5.619885   6.466 2.68e-10 ***
crim         -0.115759   0.034214  -3.383 0.000780 ***
zn            0.052220   0.014624   3.571 0.000395 ***
indus         0.005617   0.064889   0.087 0.931060    
chas          3.100430   0.950802   3.261 0.001197 ** 
nox         -18.776669   4.138447  -4.537 7.36e-06 ***
rm            3.850967   0.455721   8.450 4.27e-16 ***
age           0.003956   0.013978   0.283 0.777317    
dis          -1.580629   0.214046  -7.385 7.70e-13 ***
rad           0.348931   0.073665   4.737 2.93e-06 ***
tax          -0.013507   0.004137  -3.265 0.001180 ** 
ptratio      -0.899807   0.139857  -6.434 3.25e-10 ***
black         0.009437   0.002839   3.325 0.000959 ***
lstat        -0.543199   0.053697 -10.116  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.791 on 441 degrees of freedom
Multiple R-squared:  0.7428,	Adjusted R-squared:  0.7352 
F-statistic: 97.96 on 13 and 441 DF,  p-value: < 2.2e-16

#Multiple R squared is 0.7428 meaning about 74.28% variance in the data is explained using the given model.Is a measure of how good the model fits the data

> install.packages("leaps")
Installing package into ‘/home/bongcon/R/i686-pc-linux-gnu-library/3.0’
(as ‘lib’ is unspecified)
trying URL 'http://cran.rstudio.com/src/contrib/leaps_2.9.tar.gz'
Content type 'application/x-gzip' length 26847 bytes (26 Kb)
opened URL
==================================================
downloaded 26 Kb

* installing *source* package ‘leaps’ ...
** libs
gfortran   -fpic  -O3 -pipe  -g  -c leaps.f -o leaps.o
gfortran   -fpic  -O3 -pipe  -g  -c leapshdr.f -o leapshdr.o
gcc -std=gnu99 -shared -o leaps.so leaps.o leapshdr.o -lgfortran -lm -lquadmath -L/usr/lib/R/lib -lR
installing to /home/bongcon/R/i686-pc-linux-gnu-library/3.0/leaps/libs
** R
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded
* DONE (leaps)

The downloaded source packages are in
	‘/tmp/RtmpTYWKH4/downloaded_packages’
#THIS IS a Line.................................................................................................

> library("leaps")
> nullmodel=lm(medv~1, data=Boston_train)#is the model with no variable in it
> fullmodel=lm(medv~., data=Boston_train)#is the variable with all the variables in it
> model.step = step(fullmodel,direction='backward')#Running backward elimination using step()
Start:  AIC=1439.57
medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + 
    tax + ptratio + black + lstat

          Df Sum of Sq   RSS    AIC
- indus    1      0.17 10124 1437.6
- age      1      1.84 10126 1437.7
<none>                 10124 1439.6
- chas     1    244.10 10368 1448.4
- tax      1    244.73 10369 1448.4
- black    1    253.74 10378 1448.8
- crim     1    262.79 10387 1449.2
- zn       1    292.70 10417 1450.5
- nox      1    472.58 10596 1458.3
- rad      1    515.07 10639 1460.2
- ptratio  1    950.25 11074 1478.4
- dis      1   1251.87 11376 1490.6
- rm       1   1639.28 11763 1505.9
- lstat    1   2349.23 12473 1532.5

Step:  AIC=1437.58
medv ~ crim + zn + chas + nox + rm + age + dis + rad + tax + 
    ptratio + black + lstat

          Df Sum of Sq   RSS    AIC
- age      1      1.84 10126 1435.7
<none>                 10124 1437.6
- chas     1    247.52 10372 1446.6
- black    1    253.63 10378 1446.8
- crim     1    263.74 10388 1447.3
- tax      1    282.80 10407 1448.1
- zn       1    293.59 10418 1448.6
- nox      1    501.58 10626 1457.6
- rad      1    542.42 10666 1459.3
- ptratio  1    965.15 11089 1477.0
- dis      1   1321.24 11445 1491.4
- rm       1   1655.75 11780 1504.5
- lstat    1   2361.65 12486 1531.0

Step:  AIC=1435.66
medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + 
    black + lstat

          Df Sum of Sq   RSS    AIC
<none>                 10126 1435.7
- chas     1    250.13 10376 1444.8
- black    1    258.84 10385 1445.2
- crim     1    263.30 10389 1445.3
- tax      1    281.52 10408 1446.1
- zn       1    292.65 10419 1446.6
- nox      1    526.11 10652 1456.7
- rad      1    540.73 10667 1457.3
- ptratio  1    963.91 11090 1475.0
- dis      1   1453.36 11579 1494.7
- rm       1   1755.19 11881 1506.4
- lstat    1   2653.36 12779 1539.6

#........................................................................................................................#
#This tells R to start with the null model and search through models lying in the range between the null and full model using the forward selection algorithm.
> model.step = step(nullmodel, scope=list(lower=nullmodel, upper=fullmodel), direction='forward')
Start:  AIC=2031.39
medv ~ 1

          Df Sum of Sq   RSS    AIC
+ lstat    1   21207.5 18152 1681.2
+ rm       1   19209.5 20150 1728.8
+ ptratio  1   10654.0 28705 1889.8
+ indus    1    9286.4 30073 1910.9
+ tax      1    8264.5 31095 1926.2
+ nox      1    6948.5 32411 1945.0
+ crim     1    5831.2 33528 1960.4
+ rad      1    5719.5 33640 1961.9
+ age      1    5439.1 33920 1965.7
+ zn       1    5009.5 34350 1971.5
+ black    1    4500.4 34859 1978.1
+ dis      1    2145.2 37214 2007.9
+ chas     1     894.2 38465 2022.9
<none>                 39359 2031.4

Step:  AIC=1681.24
medv ~ lstat

          Df Sum of Sq   RSS    AIC
+ rm       1    3957.2 14195 1571.3
+ ptratio  1    2470.5 15682 1616.7
+ dis      1     767.6 17384 1663.6
+ chas     1     624.7 17527 1667.3
+ age      1     302.8 17849 1675.6
+ tax      1     225.3 17927 1677.5
+ black    1     186.7 17965 1678.5
+ zn       1     146.6 18005 1679.5
+ crim     1     141.1 18011 1679.7
+ indus    1     117.6 18034 1680.3
<none>                 18152 1681.2
+ rad      1      13.9 18138 1682.9
+ nox      1       1.3 18151 1683.2

Step:  AIC=1571.35
medv ~ lstat + rm

          Df Sum of Sq   RSS    AIC
+ ptratio  1   1337.79 12857 1528.3
+ chas     1    600.34 13594 1553.7
+ black    1    488.78 13706 1557.4
+ dis      1    351.72 13843 1561.9
+ tax      1    290.45 13904 1563.9
+ crim     1    276.27 13918 1564.4
+ rad      1     96.91 14098 1570.2
<none>                 14195 1571.3
+ indus    1     44.43 14150 1571.9
+ zn       1     42.51 14152 1572.0
+ age      1     27.03 14168 1572.5
+ nox      1     13.90 14181 1572.9

Step:  AIC=1528.31
medv ~ lstat + rm + ptratio

        Df Sum of Sq   RSS    AIC
+ dis    1    512.09 12345 1511.8
+ chas   1    401.93 12455 1515.9
+ black  1    383.29 12474 1516.5
+ crim   1    118.45 12738 1526.1
+ age    1     74.56 12782 1527.7
<none>               12857 1528.3
+ tax    1     25.71 12831 1529.4
+ nox    1     18.99 12838 1529.6
+ rad    1     15.21 12842 1529.8
+ zn     1     14.78 12842 1529.8
+ indus  1      1.61 12855 1530.2

Step:  AIC=1511.82
medv ~ lstat + rm + ptratio + dis

        Df Sum of Sq   RSS    AIC
+ nox    1    747.19 11598 1485.4
+ black  1    500.35 11844 1495.0
+ chas   1    287.89 12057 1503.1
+ indus  1    239.42 12105 1504.9
+ crim   1    235.91 12109 1505.0
+ tax    1    193.42 12152 1506.6
+ zn     1    166.15 12179 1507.7
<none>               12345 1511.8
+ age    1     51.18 12294 1511.9
+ rad    1     12.17 12333 1513.4

Step:  AIC=1485.41
medv ~ lstat + rm + ptratio + dis + nox

        Df Sum of Sq   RSS    AIC
+ chas   1    346.95 11251 1473.6
+ black  1    282.17 11316 1476.2
+ zn     1    182.03 11416 1480.2
+ crim   1    140.56 11457 1481.9
+ rad    1     75.08 11523 1484.5
<none>               11598 1485.4
+ indus  1     16.84 11581 1486.8
+ tax    1      2.02 11596 1487.3
+ age    1      0.08 11598 1487.4

Step:  AIC=1473.59
medv ~ lstat + rm + ptratio + dis + nox + chas

        Df Sum of Sq   RSS    AIC
+ black  1   248.965 11002 1465.4
+ zn     1   196.170 11055 1467.6
+ crim   1   115.710 11135 1470.9
+ rad    1    83.824 11167 1472.2
<none>               11251 1473.6
+ indus  1    24.935 11226 1474.6
+ age    1     0.526 11250 1475.6
+ tax    1     0.004 11251 1475.6

Step:  AIC=1465.41
medv ~ lstat + rm + ptratio + dis + nox + chas + black

        Df Sum of Sq   RSS    AIC
+ zn     1   225.290 10776 1458.0
+ rad    1   185.335 10816 1459.7
+ crim   1    55.780 10946 1465.1
<none>               11002 1465.4
+ tax    1    13.952 10988 1466.8
+ indus  1    13.496 10988 1466.8
+ age    1     6.052 10996 1467.2

Step:  AIC=1457.99
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn

        Df Sum of Sq   RSS    AIC
+ rad    1   116.826 10660 1455.0
+ crim   1   101.397 10675 1455.7
<none>               10776 1458.0
+ indus  1    16.527 10760 1459.3
+ tax    1     0.282 10776 1460.0
+ age    1     0.067 10776 1460.0

Step:  AIC=1455.03
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad

        Df Sum of Sq   RSS    AIC
+ tax    1   270.385 10389 1445.3
+ crim   1   252.162 10408 1446.1
<none>               10660 1455.0
+ indus  1    29.786 10630 1455.8
+ age    1     0.348 10659 1457.0

Step:  AIC=1445.34
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad + tax

        Df Sum of Sq   RSS    AIC
+ crim   1   263.301 10126 1435.7
<none>               10389 1445.3
+ age    1     1.398 10388 1447.3
+ indus  1     1.119 10388 1447.3

Step:  AIC=1435.66
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad + tax + crim

        Df Sum of Sq   RSS    AIC
<none>               10126 1435.7
+ age    1   1.83812 10124 1437.6
+ indus  1   0.17166 10126 1437.7
#According to the forward selection the age and indus are the best variables to choose for the model
#...........................................................................................................................

#............................................................................................................................
#the stepwise regression(both forward and backward)
> model.step=step(nullmodel, scope=list(lower=nullmodel, upper=fullmodel), direction='both')
Start:  AIC=2031.39
medv ~ 1

          Df Sum of Sq   RSS    AIC
+ lstat    1   21207.5 18152 1681.2
+ rm       1   19209.5 20150 1728.8
+ ptratio  1   10654.0 28705 1889.8
+ indus    1    9286.4 30073 1910.9
+ tax      1    8264.5 31095 1926.2
+ nox      1    6948.5 32411 1945.0
+ crim     1    5831.2 33528 1960.4
+ rad      1    5719.5 33640 1961.9
+ age      1    5439.1 33920 1965.7
+ zn       1    5009.5 34350 1971.5
+ black    1    4500.4 34859 1978.1
+ dis      1    2145.2 37214 2007.9
+ chas     1     894.2 38465 2022.9
<none>                 39359 2031.4

Step:  AIC=1681.24
medv ~ lstat

          Df Sum of Sq   RSS    AIC
+ rm       1    3957.2 14195 1571.3
+ ptratio  1    2470.5 15681 1616.7
+ dis      1     767.6 17384 1663.6
+ chas     1     624.7 17527 1667.3
+ age      1     302.8 17849 1675.6
+ tax      1     225.3 17927 1677.5
+ black    1     186.7 17965 1678.5
+ zn       1     146.6 18005 1679.5
+ crim     1     141.1 18011 1679.7
+ indus    1     117.6 18034 1680.3
<none>                 18152 1681.2
+ rad      1      13.9 18138 1682.9
+ nox      1       1.3 18151 1683.2
- lstat    1   21207.5 39359 2031.4

Step:  AIC=1571.35
medv ~ lstat + rm

          Df Sum of Sq   RSS    AIC
+ ptratio  1    1337.8 12857 1528.3
+ chas     1     600.3 13594 1553.7
+ black    1     488.8 13706 1557.4
+ dis      1     351.7 13843 1561.9
+ tax      1     290.5 13904 1563.9
+ crim     1     276.3 13918 1564.4
+ rad      1      96.9 14098 1570.2
<none>                 14195 1571.3
+ indus    1      44.4 14150 1571.9
+ zn       1      42.5 14152 1572.0
+ age      1      27.0 14168 1572.5
+ nox      1      13.9 14181 1572.9
- rm       1    3957.2 18152 1681.2
- lstat    1    5955.2 20150 1728.8

Step:  AIC=1528.31
medv ~ lstat + rm + ptratio

          Df Sum of Sq   RSS    AIC
+ dis      1     512.1 12345 1511.8
+ chas     1     401.9 12455 1515.9
+ black    1     383.3 12474 1516.5
+ crim     1     118.5 12738 1526.1
+ age      1      74.6 12782 1527.7
<none>                 12857 1528.3
+ tax      1      25.7 12831 1529.4
+ nox      1      19.0 12838 1529.6
+ rad      1      15.2 12842 1529.8
+ zn       1      14.8 12842 1529.8
+ indus    1       1.6 12855 1530.2
- ptratio  1    1337.8 14195 1571.3
- rm       1    2824.5 15682 1616.7
- lstat    1    4621.5 17478 1666.0

Step:  AIC=1511.82
medv ~ lstat + rm + ptratio + dis

          Df Sum of Sq   RSS    AIC
+ nox      1     747.2 11598 1485.4
+ black    1     500.3 11844 1495.0
+ chas     1     287.9 12057 1503.1
+ indus    1     239.4 12105 1504.9
+ crim     1     235.9 12109 1505.0
+ tax      1     193.4 12152 1506.6
+ zn       1     166.2 12179 1507.7
<none>                 12345 1511.8
+ age      1      51.2 12294 1511.9
+ rad      1      12.2 12333 1513.4
- dis      1     512.1 12857 1528.3
- ptratio  1    1498.2 13843 1561.9
- rm       1    2370.6 14716 1589.7
- lstat    1    5026.2 17371 1665.2

Step:  AIC=1485.41
medv ~ lstat + rm + ptratio + dis + nox

          Df Sum of Sq   RSS    AIC
+ chas     1     347.0 11251 1473.6
+ black    1     282.2 11316 1476.2
+ zn       1     182.0 11416 1480.2
+ crim     1     140.6 11457 1481.9
+ rad      1      75.1 11523 1484.5
<none>                 11598 1485.4
+ indus    1      16.8 11581 1486.8
+ tax      1       2.0 11596 1487.3
+ age      1       0.1 11598 1487.4
- nox      1     747.2 12345 1511.8
- dis      1    1240.3 12838 1529.6
- ptratio  1    1738.5 13336 1547.0
- rm       1    2211.3 13809 1562.8
- lstat    1    3526.5 15124 1604.2

Step:  AIC=1473.59
medv ~ lstat + rm + ptratio + dis + nox + chas

          Df Sum of Sq   RSS    AIC
+ black    1     249.0 11002 1465.4
+ zn       1     196.2 11055 1467.6
+ crim     1     115.7 11135 1470.9
+ rad      1      83.8 11167 1472.2
<none>                 11251 1473.6
+ indus    1      24.9 11226 1474.6
+ age      1       0.5 11250 1475.6
+ tax      1       0.0 11251 1475.6
- chas     1     347.0 11598 1485.4
- nox      1     806.3 12057 1503.1
- dis      1    1151.5 12402 1515.9
- ptratio  1    1507.9 12759 1528.8
- rm       1    2280.1 13531 1555.6
- lstat    1    3339.4 14590 1589.8

Step:  AIC=1465.41
medv ~ lstat + rm + ptratio + dis + nox + chas + black

          Df Sum of Sq   RSS    AIC
+ zn       1    225.29 10776 1458.0
+ rad      1    185.33 10816 1459.7
+ crim     1     55.78 10946 1465.1
<none>                 11002 1465.4
+ tax      1     13.95 10988 1466.8
+ indus    1     13.50 10988 1466.8
+ age      1      6.05 10996 1467.2
- black    1    248.96 11251 1473.6
- chas     1    313.75 11316 1476.2
- nox      1    585.13 11587 1487.0
- dis      1   1081.20 12083 1506.1
- ptratio  1   1404.70 12406 1518.1
- rm       1   2446.57 13448 1554.8
- lstat    1   2839.59 13841 1567.9

Step:  AIC=1457.99
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn

          Df Sum of Sq   RSS    AIC
+ rad      1    116.83 10660 1455.0
+ crim     1    101.40 10675 1455.7
<none>                 10776 1458.0
+ indus    1     16.53 10760 1459.3
+ tax      1      0.28 10776 1460.0
+ age      1      0.07 10776 1460.0
- zn       1    225.29 11002 1465.4
- black    1    278.08 11055 1467.6
- chas     1    326.39 11103 1469.6
- nox      1    591.80 11368 1480.3
- ptratio  1   1014.77 11791 1496.9
- dis      1   1294.14 12071 1507.6
- rm       1   2175.22 12952 1539.7
- lstat    1   2904.91 13681 1564.6

Step:  AIC=1455.03
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad

          Df Sum of Sq   RSS    AIC
+ tax      1    270.39 10389 1445.3
+ crim     1    252.16 10408 1446.1
<none>                 10660 1455.0
+ indus    1     29.79 10630 1455.8
+ age      1      0.35 10659 1457.0
- rad      1    116.83 10776 1458.0
- zn       1    156.78 10816 1459.7
- chas     1    329.35 10989 1466.9
- black    1    354.58 11014 1467.9
- nox      1    708.04 11368 1482.3
- ptratio  1   1109.32 11769 1498.1
- dis      1   1226.36 11886 1502.6
- rm       1   2025.98 12686 1532.2
- lstat    1   2991.30 13651 1565.6

Step:  AIC=1445.34
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad + tax

          Df Sum of Sq   RSS    AIC
+ crim     1    263.30 10126 1435.7
<none>                 10389 1445.3
+ age      1      1.40 10388 1447.3
+ indus    1      1.12 10388 1447.3
- zn       1    246.67 10636 1454.0
- tax      1    270.39 10660 1455.0
- chas     1    276.10 10665 1455.3
- black    1    330.34 10720 1457.6
- rad      1    386.93 10776 1460.0
- nox      1    474.54 10864 1463.7
- ptratio  1    942.01 11331 1482.8
- dis      1   1327.21 11716 1498.0
- rm       1   1787.20 12176 1515.6
- lstat    1   2984.55 13374 1558.2

Step:  AIC=1435.66
medv ~ lstat + rm + ptratio + dis + nox + chas + black + zn + 
    rad + tax + crim

          Df Sum of Sq   RSS    AIC
<none>                 10126 1435.7
+ age      1      1.84 10124 1437.6
+ indus    1      0.17 10126 1437.7
- chas     1    250.13 10376 1444.8
- black    1    258.84 10385 1445.2
- crim     1    263.30 10389 1445.3
- tax      1    281.52 10408 1446.1
- zn       1    292.65 10419 1446.6
- nox      1    526.11 10652 1456.7
- rad      1    540.73 10667 1457.3
- ptratio  1    963.91 11090 1475.0
- dis      1   1453.36 11579 1494.7
- rm       1   1755.19 11881 1506.4
- lstat    1   2653.36 12779 1539.6
