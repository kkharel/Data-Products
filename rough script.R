library(manipulate)

manipulate(plot(1:x), x = slider(1,100))

library(HistData)

data(Galton)

myHist = function(mu){
  hist(Galton$child, col = "blue", breaks = 100)
  lines(c(mu, mu), c(0, 150), col = "red", lwd = 5)
  mse =  mean((Galton$child - mu)^2)
  text(63, 150, paste("mu = ", mu))
  text(63, 140, paste("MSE = ", round(mse,2)))
}

manipulate(myHist(mu), mu = slider(62,74, step = 0.5))


rsconnect::setAccountInfo(name='kkharel',
                          token='006410000E80156CB66651AA2C423F47',
                          secret='XlR7Iw06++ipOY/FYNqDMf/FnFXPj+vM9OY/OkgC')


library(rsconnect)

rsconnect::deployApp('C:/Users/kkhar/OneDrive/Documents/Data_Products/Data-Products/myapp')


library(shiny)
library(miniUI)

myFirstGadget = function() {
  ui = miniPage(
    gadgetTitleBar("My first Gadget")
  )
  server = function(input, output, session) {
    # Done button closes the app
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui, server)
}

library(googleVis)
M = gvisMotionChart(Fruits, idvar = "Fruit", timevar = "Year",
                    options = list(width = 600, height = 400)) # creating gvis motion chart

print(M, "chart")
plot(M)

