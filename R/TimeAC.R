#' Calculate Time-Lagged Autocorrelation
#'
#' This function computes the time-lagged autocorrelation of a given time series.
#'
#' @param x A numeric vector representing the time series.
#'        type A character vector indicating the type of estimator c("unbiased","biased")
#'        Default value is "unbiased"
#'        
#' @return A numeric vector containing the time-lagged autocorrelation values.
#'
#' @details
#' The function calculates the autocorrelation for different time lags and
#'  returns a vector of (double-sided) autocorrelation values.
#'
#' @examples
#' # Example usage:
#' data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
#' result <- TimeAC(data)
#' print(result)
#'
#' @seealso
#' \code{\link{acf}} for autocorrelation functions in base R.
#'
#' @references
#' Insert any relevant references or citations here.
#'
#' @export
TimeAC <- function(x,type="unbiased") {
  
  M <- length(x)
  r <- array(0, dim = c(M))  # One-sided autocorrelation
  
  for (i in 1:M) {
    r[i] = (x[1:(M - i + 1)] %*% x[i:M])  # Dot product in r
  }
  
  rr = c(rev(r[2:M]), r[1:M]) 
  
  if (type=='unbiased'){
    rr<- rr/M
  }
  
  return(rr)
}
