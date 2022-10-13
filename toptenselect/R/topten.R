#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' Building a prediction model with top ten features
#'
#' This function develops the prediction algorithm based on the top ten features of x that are most predictive of y.
#'
#' @param x is a n x p matrix of n observations and p predictors.
#'
#' @param y is a vector of length n representing the response
#'
#' @return a vector of coefficients from the final fitted model with top ten features
#' @author Credit goes to Roger Peng
#' @details
#' This function runs a univariate regression of y on each predictors in x
#' and calculates a pvalues indicating the significance of the association
#' The final set of 10 predictors is taken from the 10 smallest p-values
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm



topten = function(x,y) {
  p = ncol(x) # preditor is going to be number of columns
  if (P<10)
    stop("there are less than ten predictors")
  pvalues = numeric(p)
  for (i in seq_len(p)) {
    fit = lm(y~x[, i])
    summ = summary(fit) #to get the p-values from summary
    pvalues[i] = summ$coefficients[2,4] #coefficients from 2nd and 4th column
  }
  ord = order(pvalues) # gives smallest to largest
  ord = ord[1:10]
  x10 = x[, ord] # top ten predictors
  fit = lm(y~x10)
  coef(fit)
}

#' Prediction with the top ten features
#' This function takes the sets of coefficients produced by the \code{topten} function
#' and makes the prediction for each of the values provided in the input 'X' matrix
#'
#' @param X  a n x 10 matrix containing n new observations
#' @param b vector of coefficients obtained from the \code{topten} function
#' @return a numeric vector containing the predicted values
#' @export

predict10 = function(X, b) { # X matrix is going to be only 10 columns, b is the vector of coefficients
  X = cbind(1,X) # Adding intercept to this matrix
  drop(X%*%b) # gives the matrix multiplication and drops the dimension and gives the vector

}

# returns the vectors of predicted responses
