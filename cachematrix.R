## The two functions specified here determine a matrix and its inverse.
## Latter matrix is calculated via the cacheSolve function and subsequently
## cached via the makeCacheMatrix functions, thus avoiding time consuming
## recalculations of the matrix inverse.
## The plural functionS is used here because we take advantage of the R 
## capability of storing functions within functions.


## The makeCacheMatrix function defines the matrix (x) to start of with.
## Apart from this, this function acts as a constructor function for 4 other 
## functions.These functions are used to
##   SET (define) another matrix, i.e. one that is different from the original 
##        matrix (x) within this function the new matrix (y) is assigned to x.
##   GET the matrix (x) at hand
##   SETINVERSE assigns the calculated inverse matrix to the MTI object 
##        (Note: MTI is short for MaTrix Inverse)
##   GETINVERSE reads the MTI object from cache when available.
## These functions together are stored in a list object and act as the 
## return object of the constructor function makeCacheMatrix. This means
## that by for instance assigning the object `a` to the function call of 
## makeCacheMatrix, the above mentioned constituent functions can be called
## via a$set(y), a$get() etc.

makeCacheMatrix <- function(x = matrix()) {
  MTI <- NULL # initiatie MTI to NULL
  set <- function(y) { # rewrite matrix x with matrix y
    x <<- y
    MTI <<- NULL # (re-)initiate MTI to NULL since it has to be (re-)calulated
  }
  get <- function() x #get the matrix present at hand
  setInverse<- function(Inverse) MTI <<- Inverse # assign the calculated 'Inverse' to MTI
  getInverse <- function() MTI # get the inverse matrix when available in cache
  list(set = set, get = get, # return the list function object
       setInverse = setInverse,
       getInverse = getInverse)
}


## The cacheSolve function uses the functions defined in the constructor function 
## makeCacheMatrix.It reads the inverse matrix pertaining to the matrix
## at hand, from cache when available. If it is available this function
## uses this inverse matrix as its return object.
## If its not available the inverse matrix is calculated and cached using
## the setInverse function from the makeCacheMatrix.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  MTI <- x$getInverse() # get the inverse matrix when available
  if(!is.null(MTI)) { # if the inverse is available it is returned here.
    message("getting cached Inverse of Matrix")
    return(MTI)
  }
  MT <- x$get() # if the inverse is not available get the original matrix here
  MTI <- solve(MT, ...)# if the inverse is not available it is calculated here
  x$setInverse(MTI) # the inverse matrix is cached here
  MTI
}
