library(shiny)
library(plotly)
library(markdown)
library(shinythemes)

markdown <- function(s) {
  s <- gsub("\\n[ \\t]*", "\n", s)
  HTML(markdownToHTML(fragment.only = TRUE, text = s))
}

shinyUI(
  navbarPage("Monte Carlo Methods",
             tabPanel(
               "Inverse - Transform Sampling",
               sidebarLayout(
                 sidebarPanel( width = 3,
                   sliderInput("Simulations",
                               "Number of Simulations",
                               min = 0,
                               max = 100000,
                               value = 500),
                   sliderInput("lambda",
                               " Rate parameter (lambda)",
                               min = 0,
                               max = 1,
                               value = 0.5)
                 ),
                 mainPanel(
                   plotlyOutput("distPlot"),
                   withMathJax(
                     helpText('Suppose we have uniform numbers from \\([0,1]\\). We want to transform uniform
                              random variables from uniform distribution to our target exponential distribution.
                              We know the probability density function of our target distribution:
                              $$f(x) = e^{-\\lambda x}, x \\geq 0$$ and  $$f(x) = 0, x < 0$$'),
                     helpText('We also know the cumulative density function of our target distribution: CDF tells us, what is the
                     probability that you choose a number that is \\(x\\) or less from the distribution?
                              $$F(x) = 1 - e^{-\\lambda x}, x \\geq 0$$ and  $$F(x) = 0, x < 0$$'),
                     helpText('Mathematically speaking: What is the transformation \\(T\\) that we can do to \\(U\\) in order
                              to get the exponential numbers \\(X\\)?
                                $$T(U) = X$$'),
                     helpText('From the cdf definition,
                              $$F(x) = P(X \\leq x)$$'),
                     helpText('In other words, what is the probability that the exponential distribution
                              is less than or equal to small \\(x\\)?'),
                     helpText('We know that big \\(X\\) is same as \\(T(U)\\).We can rewrite above expression as:
                              $$P(T(U) \\leq x)$$'),
                     helpText('Taking the inverse of \\(T\\) on both sides, we get:
                              $$P(U \\leq T^{-1}(x))$$
                              What is the probability that the uniform distribution is less than
                              or equals to some value \\(T^{-1}(x)\\)? In other words, what is the probability that
                              uniform distribution is behind the range \\([0, T^{-1}(x)]\\)? Let us think for a second?
                              What is the probability of the area being behind \\(T^{-1}(x)\\) = \\(0.25\\). It is \\(0.25\\)
                              because of nice characteristic of uniform distribution (it is uniform all across)'),
                     helpText('Hence,
                              \\(F(x) = T^{-1}(x)\\) and
                              $$F^{-1}(x) = T(x)$$'),
                     helpText('We found that cumulative density function for exponential distribution is equals to the
                              inverse of \\(T\\) of \\(x\\). In conclusion, \\(F\\) and \\(T\\) are inverse functions so if
                              we figure out the inverse of the given density function then we are going to have a transformation
                              we need and apply it to the uniform numbers to get exponential distribution back.'),
                     helpText('Solving for \\(x\\) to get the inverse:
                              $$y = 1 - e ^{-\\lambda x}$$
                              $$1 - y = e ^{-\\lambda x}$$
                              $$-\\frac{ln(1-y)}{\\lambda} = x$$'),
                     helpText('Let us replace \\(y\\) with \\(u\\).
                              $$-\\frac{ln(1-u)}{\\lambda} = x$$
                              Since uniform distribution is symmetric, we can slightly
                              optimize the above result. Hence:
                              $$X = -\\frac{ln(U)}{\\lambda}$$'),
                     helpText('Note: We need cdf in order to apply this method')


                   )
                 ),
                 position = "right",
                 fluid = TRUE
               )
             ),
             tabPanel("Accept - Reject Sampling"),
             tabPanel("Metropolis Hastings"))
)
