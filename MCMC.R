# combinatorics

library(combinat)

# datasets

library(datasets)

library(remotes)
install_github("cran/mcsm")

library(mcsm)

getAnywhere(pnorm)

View(mean)

demo(Chapter.2)


# Generate random uniform numbers
x = runif(100, min = 0, max = 1) #pseudo-random numbers, outcome has same statistical propoerties as iid samples

Nsim = 10^4 # Number of random variables
U = runif(Nsim)
lambda = 0.25
X  = -log(U)/lambda # transforms of uniforms
fit = density(X)
fit1 = density(U)
fit2 = density(Y)
Y = rexp(Nsim) #exponentials from R
plot(ecdf(X))
library(plotly)

fig = plot_ly(alpha = 0.6)
fig = fig %>% add_histogram(x = X, name = "Transform of Uniform distribution")
fig = fig %>% add_histogram(x = Y, name = "Exponential from R")
fig = fig %>% add_trace(x = fit$x, y = fit$y, type = "scatter", yaxis = "y2", name = "Transformed Exponential Density", type = "scatter", mode = "markers")
fig = fig %>% add_trace(x = fit1$x, y = fit1$y, type = "scatter", yaxis = "y2", name = "Uniform Density", type = "scatter", mode = "markers")
fig = fig %>% add_trace(x = fit2$x, y = fit2$y, type = "scatter", yaxis = "y2", name = "R Exponential Density", type = "scatter", mode = "markers")
fig = fig %>% layout(yaxis2 = list(overlaying = "y", side = "right"), barmode = "stack", title = "Comparision of transform of uniform distribution vs Exponential Distribution from R")

fig
# Cauchy and Logistic distributions
?withMathJax


install.packages("shinythemes")

?sidebarPanel
?add_histogram


f <- function(x){
  ifelse((x<1 & x>-1), 0.5*cos(abs(x)), 0)
}

rf.reject <- function(n) {
  M <- 0.22
  results <- numeric()
  while (length(results) < n) {
    X <- runif(2*(n - length(results)), min = -1, max = 1)
    Y <- M*runif(length(X))*1
    keep <- Y < f(X)
    results <- c(results, X[keep])
  }
  results[1:n]
}

hist(rf.reject(1000000), prob=TRUE, breaks = "Scott" )
curve(f(x), add=TRUE, col="red")

