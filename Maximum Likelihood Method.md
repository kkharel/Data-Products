Maximum Likelihood Method
========================================================
author: Kushal Kharel
date: 09/1//2022
autosize: true
output: ioslides_presentation


Maximum Likelihood Estimation
========================================================
author: Kushal Kharel
date: 09/11/2022
autosize: true

Background
========================================================

- How do we infer sample data to population parameters? One way is to use maximum
likelihood estimation method.

- Let us consider a set of observations y1, y2, ..., yn, the likelihood function L
is the join probability density of obtaining the data that are actually observed.

- It is considered as a function of unknown parameters with the observed data held fixed.

- The maximum likelihood estimators are those values of the parameters for which the data
actually observed are most likely. In other words, the values that maximizes the likelihood function.

Background
========================================================

- We have i.i.d sample of data, assuming that the data is generated from some parametric
density function or the probability mass function which is indexed by parameter theta.

- Then we construct a likelihood function using the assumption that the data are iid which
is simply the product of density or pmf evaluated at each sample data points. We take the
log of that function simply because it is computationally easier among other reasons.

- We may have infinite number of possible parameter values, and we want to choose the one
that best fits the data. In order to do this, we need to maximize the log likelihood
function.

Generating Data
========================================================


```r
library(dplyr)
library(plotly)
N = 1000
beta = 5
sigma_2 = 5
X = rnorm(N, 0, 5)
Z = rnorm(N, 0, sqrt(sigma_2))
Y = beta*X + Z

DT = data.table::data.table(X, Y, Z)
```

Kernel density Estimation
========================================================
































```
Error in path.expand(path) : invalid 'path' argument
```
