# library(shiny)
#
# shinyUI(fluidPage(
#   titlePanel("Plot Random Numbers"),
#   sidebarLayout(
#     sidebarPanel(
#       numericInput("numeric", "How many random numbers should be plotted?",
#                    value = 1000, min = 1, max = 1000, step = 1),
#       sliderInput("sliderX", "Pick Minimum and Maximum X values",
#                   -100, 100, value = c(-50, 50)),
#       sliderInput("sliderY", "Pick Minimum and Maximum Y values",
#                   -100, 100, value = c(-50, 50)),
#       checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
#       checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
#       checkboxInput("show_title", "Show/Hide Title")
#     ),
#     mainPanel(
#       h1("Graph of Random Points"),
#       plotOutput("plot1")
#     )
#   )
# ))


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


# Prediction Algorithm for Diabetes


# shinyUI(
#   pageWithSidebar(
#     # Application Title
#     headerPanel("Diabetes prediction"),
#     sidebarPanel(
#       numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
#       submitButton('Submit')
#     ),
#     mainPanel(
#       h3('Results of prediction'),
#       h4('You entered'),
#       verbatimTextOutput("inputValue"),
#       h4('Which resulted in a prediction of '),
#       verbatimTextOutput("prediction") # function to display the output of our server.R functions
#     )
#   )
# )


#Galton Data

# shinyUI(
#   pageWithSidebar(
#     headerPanel("Example Plot"),
#     sidebarPanel(
#       sliderInput('mu', 'Guess at the mean', value = 70, min = 62, max = 74, step = 0.05)
#     ),
#     mainPanel(
#       plotOutput('newHist')
#     )
#   )
# )
#

# reactive expression

# library(shiny)
#
# shinyUI(
#   fluidPage(
#     titlePanel("Predict Horsepower from MPG"),
#     sidebarLayout(
#       sidebarPanel(
#         sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20), # range from 10 miles per gallon to 35 and default value of 20
#         checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
#         checkboxInput("showModel2", "Show`/Hide Model 2", value = TRUE),
#         submitButton("Submit") # delayed reactive
#       ),
#       mainPanel(
#         plotOutput("plot1"),
#         h3("Predicted Horesepower from Model 1:"),
#         textOutput("pred1"),
#         h3("Predicted Horsepower from model 2:"),
#         textOutput("pred2")
#       )
#     )
#   )
# )


# Advanced UI
#
# We can include different UI mix into our app including tabls, navbars, and sidebars.
# We can use tab to have multiple views in our app.
# The tabsetPanel() function specifies a group of tabs and then the tabPanel() function
# specifies the contents of an individual tab.


# library(shiny)
#
# shinyUI(
#   fluidPage(
#     titlePanel("Tabs!"),
#     sidebarLayout(
#       sidebarPanel(
#         textInput("box1", "Enter Tab 1 Text:", value = "Tab 1!"),
#         textInput("box2", "Enter Tab 2 Text:", value = "Tab 2!"),
#         textInput("box3", "Enter Tab 3 Text:", value = "Tab 3!")
#       ),
#       mainPanel(
#         tabsetPanel(type = "tabs",
#                     tabPanel("Tab 1", br(), textOutput("out1")),
#                     tabPanel("Tab 2", br(), textOutput("out2")),
#                     tabPanel("Tab 3", br(), textOutput("out3"))
#                     )
#       )
#     )
#   )
# )


# Interactive Graphics

# Shiny can create graphics that users can interact with.
# One method we can use to select multiple data points on the graph
# is by using brush argument in plotOutput() on ui.R and then using the
# brushedPoints() function on the server.R
#
# example:
#
# Fitting a linear model for the selected points and then drawing a line of best fit for the resulting model.


# library(shiny)
#
# shinyUI(
#   fluidPage(
#     titlePanel("Visualize Many Models"),
#     sidebarLayout(
#       sidebarPanel(
#         h3("Slope"),
#         textOutput("slopeOut"),
#         h3("Intercept"),
#         textOutput("intOut")
#       ),
#       mainPanel(
#         plotOutput("plot1", brush = brushOpts(
#           id = "brush1"
#         ))
#       )
#     )
#   )
# )

# Shiny Gadgets

# provides a way to use Shiny's interactivity and user interface tools as a part of
# data analysis. With Shiny Gadgets, we can create a function that opens a small Shiny app.
# Since these apps are smaller we will be using miniUI package for creating
# user interfaces

# At its core Shiny Gadget is a function that launches a small (single-page) shiny application.
# Since shiny gadgets are meant to be displayed in the RStudio viewer pane, the miniUI package
# comes in handy for its smaller graphical elements.

# Constructing a simple Shiny Gadget

# library(shiny)
# library(miniUI)
#
# myFirstGadget = function() {
#   ui = miniPage(
#     gadgetTitleBar("My first Gadget")
#   )
#   server = function(input, output, session) {
#     # Done button closes the app
#     observeEvent(input$done, {
#       stopApp()
#     })
#   }
#   runGadget(ui, server)
# }


# One of the advantages of Shiny Gadgets is that since Shiny Gadgets are functions, they
# can take values as arguments and they can return values.
# The following shiny Gadget takes two different vectors of numbers as arguments
# and uses those vectors to populate two selectInputs.
# The user can then choose two numbers within the Gadget, and the product of those two numbers
# will be returned


# library(shiny)
# library(miniUI)
#
# multiplyNumbers = function(numbers1, numbers2) {
#   ui = miniPage(
#     gadgetTitleBar("Multiply Two Numbers"),
#     miniContentPanel(
#       selectInput("num1", "First Number", choices = numbers1),
#       selectInput("num2", "Seconf Number", choices = numbers2)
#     )
#   )
#   server = function(input, output, session) {
#     observeEvent(input$done, {
#       num1 = as.numeric(input$num1)
#       num2 = as.numeric(input$num2)
#       stopApp(num1 * num2)
#     })
#   }
#   runGadget(ui,server)
# }


# Gadgets with Interactive Graphics

# library(shiny)
# library(miniUI)
#
# pickTrees = function() {
#   ui = miniPage(
#     gadgetTitleBar("Select Points by Dragging your Mouse"),
#     miniContentPanel(
#       plotOutput("plot", height = "100%", brush = "brush")
#     )
#   )
#   server = function(input, output, session) {
#     output$plot = renderPlot({
#       plot(trees$Girth, trees$Volume, main = "Trees!",
#            xlab = "Girth", ylab = "Volume")
#     })
#     observeEvent(input$done, {
#       stopApp(brushedPoints(trees, input$brush,
#                             xvar = "Girth", yvar = "Volume"))
#     })
#   }
#   runGadget(ui, server)
# }


# Google Vis API


# The R function creates an HTML page
# The HTML page calls Google Charts
# The result is an interactive HTML graphics

## Example: Go to Markdown File

