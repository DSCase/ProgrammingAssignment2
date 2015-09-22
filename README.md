### Introduction

In this programming assignment carried out during the R-programming course
of Coursera, a set of functions was developped able to cache potentially 
time-consuming computations.In the functions at hand the inverse matrix
pertaining to some given matrix is calculated and subsequently cached.
This appears to be handy in particular those cases where the given matrix
has not changed and we are in need of the inverse matrix over and over 
again. Latter can happen in for instance loops. Avoiding time-consuming
recalculations of the inverse matrix, but instead reading it from cache
can be advantageous especially from a performance point of view.


### Caching the Inverse Matrix pertaining to a given Matrix

In the functions to be developped we will use the `<<-` operator which 
can be used to assign a value to an object in an environment that is 
different from the current environment. 

The two functions specified here determine a matrix and its inverse.
Latter matrix is calculated via the cacheSolve function and subsequently
cached via the makeCacheMatrix functions, thus avoiding time consuming
recalculations of the matrix inverse.
The plural functionS is used here because we take advantage of the R 
capability of storing functions within functions.

The makeCacheMatrix function defines the matrix (x) to start of with.
Apart from this, this function acts as a constructor function for 4 other 
functions.These functions are used to
   SET (define) another matrix, i.e. one that is different from the original 
        matrix (x) within this function the new matrix (y) is assigned to x.
   GET the matrix (x) at hand
   SETINVERSE assigns the calculated inverse matrix to the MTI object 
        (Note: MTI is short for MaTrix Inverse)
   GETINVERSE reads the MTI object from cache when available.
These functions together are stored in a list object and act as the 
return object of the constructor function makeCacheMatrix. This means
that by for instance assigning the object `a` to the function call of 
makeCacheMatrix, the above mentioned constituent functios can be called
via a$set(y), a$get() etc.

The cacheSolve function uses the functions defined in the constructor function 
makeCacheMatrix.It reads the inverse matrix pertaining to the matrix
at hand, from cache when available. If it is available this function
uses this inverse matrix as its return object.
If its not available the inverse matrix is calculated and cached using
the setInverse function from the makeCacheMatrix.

For more detailed and step by step comments we refer to the cacheMatrix.R 
file containing the R script files for the makeCacheMatrix 
and cacheSolve functions.


### Testing the functions

The following testscripts can be used for verification.
Copy paste the data in a R-script and run this script after you have
sourced the makeCacheMatrix and cacheSolve functions respectively.

MT<-matrix(1:4,2,2)        # specify an example
a<-makeCacheMatrix(MT)     # run the makeCacheMatrix function on MT
a$get()                    # the get function echos the matrix MT
a$getInverse()             # verify that the inverse has not yet been caculated
cacheSolve(a)              # run cacheSolve on MT which caculates and caches the inverse.
cacheSolve(a)              # run cacheSolve oncemore: the inverse now was read from cache!!
MT%*%cacheSolve(a)         # prove that MT and cacheSolve are each others inverse
                           # matrix multiplication should give rise to the Unity matrix
                           # consisting of zero's everywhere and only one's on its main diagonal
MT<-a$set(matrix(2:5,2,2)) # change the original matrix
a<-makeCacheMatrix(MT)     # run the makeCacheMatrix function on the new MT
a$get()                    # the get function echos the new matrix MT
a$getInverse()             # verify that the inverse of this matrix has not yet been caculated
cacheSolve(a)              # run cacheSolve on MT which caculates and caches the inverse.
cacheSolve(a)              # run cacheSolve oncemore: the inverse now was read from cache!!
MT%*%cacheSolve(a)         # prove that MT and cacheSolve are each others inverse
                           # matrix multiplication should give rise to the Unity matrix
                           # consisting of zero's everywhere and only one's on its main diagonal