#' Variance of the Sample Pearson Correlation Coefficient
#'
#' The `varSPCC` function calculates the variance of the Sample Pearson Correlation Coefficient
#' (SPCC) between two time series, x and y. The function checks if the input time series have the same length and then performs calculations to estimate the variance of the SPCC.
#'
#' @param x The first time series.
#' @param y The second time series.
#'
#' @return A numeric value representing the variance of the SPCC.
#'
#' @details
#' The function estimates the time series correlation (rx and ry) using the `TimeAC` function and the time series cross-correlation (rxy and ryx) using the `TimeCC` function. The variance of the SPCC is then calculated based on these values.
#'
#' @references
#' Insert any relevant references or citations here.
#'
#' @examples
#' # Example usage:
#' x <- c(1, 2, 3, 4, 5)
#' y <- c(5, 4, 3, 2, 1)
#' result <- varSPCC(x, y)
#'
#' @seealso
#' \code{\link{TimeAC}}, \code{\link{TimeCC}}
#'
#' @export 

varSPCC<- function(x,y)
{

  try ( if (length(x)!=length(y)) stop('Both x and y shoud be of same length')) 

  # x and y are two time series
  N= length(x)   # length of the time series (assuming both are equal length)
  
  # Initialization
  D<-array(0,dim=c(3,3))
 
  # Estimate the time series correlation
  rx=TimeAC(x)
  ry=TimeAC(y)

 #Estimate the time series cross-correlation
  rxy=TimeCC(x,y) 
  ryx=TimeCC(y,x) 

  rx0=rx[N]  # rx(0)
  ry0=ry[N]  # ry(0)
  rxy0=rxy[N]  # rxy(0) 
 
  # Formation of Covariance matrix
  C=c(-rxy0/(2*(sqrt((rx0^3)*ry0))),
      -rxy0/(2*(sqrt(rx0*(ry0^3)))),
      1/sqrt(rx0*ry0))  
  
  # Factor 2 is removed on the diagonals to have the correct transpose
  D[1,1]=sum(rx^2)
  D[1,2]=2*sum(rxy^2)
  D[1,3]=2*sum(rxy*rx)
  D[2,2]=sum(ry^2)
  D[2,3]=2*sum(rxy*ry)
  D[3,3]=0.5*(sum(rx*ry)+sum(rxy*ryx))
  D=(D+t(D))
  
  va=(colSums(C* (D %*% C)))/N   # Variance of the SPCC
 
  return(va)    
}
