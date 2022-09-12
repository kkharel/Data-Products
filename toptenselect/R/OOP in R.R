### class is a description of some thing ( new idea, new data type)

# can de defined using
setClass()

# object is an instance of a class. Objects can be created using
new()

# method is a function that only operates on certain class of objects

# A generic function is an R function which dispatches methods

# A generic function usually encapsulates plot, predict, mean etc...

# Generic function actually does not do any computation

# A method is the implementation of a generic function for an object of a particular class

# help ?Classes ?Methods ?setClass ?setMethod ?setGeneric

#Classes

# All objects in R has classes

class(1)

class(TRUE)

class(NA)

class("Kk")

class(rnorm(100))

#Data classes go beyond the atomic classes

x = rnorm(100)

y = x + rnorm(100)

fit = lm(y~x)

class(fit)

mean

print

methods("mean")

show

showMethods("show")

# If we want to see the code for the s3 method, use function getS3method
getS3method(generic, class)

# For s4 methods, getMethod
getMethod(generic, signature)


# S3 class/method example 1

set.seed(2)
x = rnorm(10)
mean(x)

# The class of x is numeric
# But there is no mean method for "numeric" objects
# So we call the default function for mean

head(getS3method("mean","default"),10)
tail(getS3method("mean","default"),10)

# S3 class method example 2

set.seed(3)

df = data.frame(x = rnorm(100), y = 1:100)
sapply(df,mean)

# the class of df is dataframe, each column can be an object of different class
# sapply over the columns of df and call the mean function for each column
# In each column, mean checks the class of the object and dispatches the appropriate method
# We have numeric column and an integer column, mean calls the default method for both

# Some S3 methods are visible to the user
# Never call the methods directly
# Use the generic function and let the appropriate methods be dispatch automatically resulting in cleaner code
# With S4 methods, we cannot call them directly at all

# S3 class/method example 3

set.seed(10)
x = rnorm(100)
plot(x)


# For time series data, plot connects the dots

set.seed(10)
x = rnorm(100)
x = as.ts(x)
plot(x)

# Writing own methods

# If we write new methods for new classes, we will probably end up writing methods
# for following generics: print/show, summary, plot

# There are two ways to extend the R system through classes/methods

# 1) Write a method for a new class but for an existing generic function ( like print)
# 2) Write new generic functions and new methods for those generics

# S4 classes

# Why do we want to create new classes?

# To represent new types of data ( gene-expressions, space-time, hierarchial, sparse matrices etc)

# New concepts/ideas that haven't been thought of yet ( a fitted point process model, mixed-effect model, a sparse matrix)

# To abstract/hide implementation details from the user.

# S4 class/method: Creating a new class

# a new class can be defined using setClass function

# At a minimum, need to specify the name of the class

# Can also specify data elements that are called slots

# then can define methods for the class with the setMethod function
# information about a class definition can be obtained from the showClass function

# Polygon Class

# Creating a new class/method is not usually done at the console, likely want to save the code in a separate file

library(methods)
setClass("polyon",
         representation(x = "numeric",
                        y = "numeric"))

# The slots for this class are x and y
# The slots for an S4 object can be accessed with the @ operator

# A plot method can be created with setMethod function

# For setMethod, need to specify a generic function (plot) and a signature

# A signature is a character vector indicating the classes of objects that are accepted by the method

# In this case, the plot method takes one type of object, a polygon object

# Creating a plot method with setMethod

setClass("polyon", representation(x = "numeric", y = "numeric"))

setMethod("plot", "polygon",
          function(x,y, ...) {
            plot(x@x, x@y, type = "n", ...)
            xp = c(x@x, x@x[1])
            yp = c(x@y, x@y[1])
            lines(xp, yp)
          })

library(methods)

showMethods(plot)

p = new("polygon", x = c(1,2,3,4), y = c(1,2,3,1))
plot(p)
