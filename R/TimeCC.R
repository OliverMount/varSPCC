#' Time Cross Correlation Function
#'
#' The TimeCC function calculates the cross-correlation between two time series, providing an asymptotically unbiased estimator. The function assumes that the input time series (x and y) are of the same length.
#'
#' @param x The first time series.
#' @param y The second time series.
#'
#' @return A numeric vector representing the combined cross-correlation values for positive and negative lags.
#'
#' @details
#' The cross-correlation is not symmetric, so be careful when dealing with negative lags.
#'
#' @references
#' Insert any relevant references or citations here.
#'
#' @examples
#' # Example usage:
#' x <- c(1, 2, 3, 4, 5)
#' y <- c(5, 4, 3, 2, 1)
#' result <- TimeCC(x, y)
#'
#' @seealso
#' \code{\link{crossprod}}, \code{\link{rev}}
#'
#' @export

TimeCC<-function(x,y)
{
  # Time Cross correlation function  
  # Asymtotically unbiased estimator
  # x and y are assumed to be of same length
  # Cross correlation is not symmetric (careful to deal with the negative lags)
  
  # Initializations
  M=length(x)
  rp <- array(0, dim = c(M))   # Positive part
  rn <- array(0, dim = c(M-1)) # Negative part
  
  # For positive lags
  for (i in 1:M)
  {
    rp[i]=(1/(M))*(x[i:M]%*%y[1:(M-i+1)])   # dot product in R
  }
  
  # For negative lags
  for (i in 1:M)
  {
    rn[i]=(1/(M))*(y[i:M]%*%x[1:(M-i+1)])   # dot product in R
  }
  
  # Combined negative and positive parts returned
  return(c(rev(rn[2:M]),rp))
}
