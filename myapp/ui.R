library(shiny)

shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric", "How many random numbers should be plotted?",
                   value = 1000, min = 1, max = 1000, step = 1),
      sliderInput("sliderX", "Pick Minimum and Maximum X values",
                  -100, 100, value = c(-50, 50)),
      sliderInput("sliderY", "Pick Minimum and Maximum Y values",
                  -100, 100, value = c(-50, 50)),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
    mainPanel(
      h1("Graph of Random Points"),
      plotOutput("plot1")
    )
  )
))


# Reactivity

# A reactive expression is like a recipe that manipulates inputs from Shiny and then
# returns a value. Reactivity provides a way for your app to respond since inputs will change
# depending on how users interact with your user interface. Expressions wrapped by reactive()
# should be expressions that are subject to change.

# Creating a reactive expression is just like creating a function.
#
# calc_sum = reactive({
#   input$box1 + input$box2
# })
#
# calc_sum()


