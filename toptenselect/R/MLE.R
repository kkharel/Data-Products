
# Binomial Model

# Suppose we have a binomial distribution for N independent bernoulli trials (e.g.,
# coin flips, success or failure etc). There is a probability function that links
# the number of successes and the probability associated with it. The probability function
# gives the probability of data, given a specific parameter.


# Let's see the barplot for probability function where N = 25 trials and fixed parameter
# theta = 0.5. In each of these 25 trials, the probability of landing heads is 50%.

fig <- plot_ly(
  x = 0:25,
  y = dbinom(0:25, size = 25, prob = 0.5),
  name = "density",
  type = "bar",
)
fig <- fig %>% layout(title = "Density",
                      xaxis = list(title = 'x'),
                      yaxis = list(title = 'p(x)'), barmode = 'stack')


fig

# The plot represents the probability of getting each possible number of heads
# in 25 outcomes.We can see that most of the occurences are between 12 and 15.
# The most probable outcome is 12 and 13. It tells the probability of each discrete outcome

# There is a likelihood function that gives the likelihood of a range of parameters,
# given a specific data point. Now, our input is parameters instead of data, this is
# called out likelihood function.

# Example: Suppose we observe ten successes in 25 trials. Here we are not asking
# about the probability of 10 successes but instead asking what is the parameter that
# would have given us 10 successes.

# Let us see the plot explained above. Suppose that in the sequence of 25 coin flips,
# we observe 10 successes(heads). What is the maximum likelihood estimate for theta?
# Assume binomial model:

# Defining likelihood function

negative_log_likelihood_binom = function(data, par) {
  return(-log(dbinom(data, size = 25, prob = par)))
}

# Finding parameters that maximizes the likelihood function

optim(par = 0.5, fn = negative_log_likelihood_binom, data = 10)

theta = seq(from = 0, to = 1, by = 0.01)


fig <- plot_ly(
  x = theta,
  y = dbinom(x=10, size = 25, prob = theta),
  name = "likelihood",
  type = "scatter",
  mode = "lines"
)
fig <- fig %>% layout(title = "Density",
                      xaxis = list(title = 'theta'),
                      yaxis = list(title = 'likelihood'))


fig

# The plot is telling us that the likelihood of observing 10 successes over the
# range of possible values of theta. We can see from the plot, as theta approaches
# 0.4, the likelihood goes up. We can ask the question that what value of theta is
# most likely, given the data we observed?

# We can see that our optimized parameter MLE = par = 0.4.

Kernel density Estimation
========================================================

  ```{r, echo=FALSE}
library(MASS)
library(webshot)
kd <- with(DT, MASS::kde2d(X, Y, n = 50))
fig <- plot_ly(x = kd$x, y = kd$y, z = kd$z) %>% add_surface()
fig

```

