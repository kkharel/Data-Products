#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlotly({

        # generate simulations based on input$simulation from ui.R
        Nsim = input$Simulations # Number of random variables
        lambda = input$lambda
        U = runif(Nsim, min = 0, max = 1)
        X  = -log(U) / lambda # transforms of uniforms
        Y = rexp(Nsim, rate = lambda) #exponentials from R
        fit = density(X)
        fit1 = density(U)
        fit2 = density(Y)
        # draw the histogram
        fig = plot_ly(alpha = 0.6)
        fig = fig %>% add_histogram(x = X, name = "Transform of Uniform distribution")
        fig = fig %>% add_histogram(x = Y, name = "Exponential Distribution from R")
        fig = fig %>% add_histogram(x = U, name = "Uniform Distribution")
        fig = fig %>% add_trace(x = fit$x, y = fit$y, type = "scatter", yaxis = "y2", name = "Transformed Exponential Density", type = "scatter", mode = "markers")
        fig = fig %>% add_trace(x = fit1$x, y = fit1$y, type = "scatter", yaxis = "y2", name = "Uniform Density", type = "scatter", mode = "markers")
        fig = fig %>% add_trace(x = fit2$x, y = fit2$y, type = "scatter", yaxis = "y2", name = "R Exponential Density", type = "scatter", mode = "markers")
        fig = fig %>% layout(yaxis2 = list(overlaying = "y", side = "right"), barmode = "stack", title = "Histograms & Densities")
    })
})
