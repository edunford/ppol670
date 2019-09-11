# **********************************************
# PPOL670 | Introduction to Data Science
# **********************************************
# Objects, Data Structures, and Operators
# **********************************************

# OBJECTs---------------------------------------------------------------------

    # Different TYPES of Data ----------------------------------------------------

    7                 # Integers
    4.5               # Numeric
    "hello!"          # Character/string
    TRUE              # Logical
    2i                # Complex
    factor("hello!")  # factors -- a string where a numerical value is
    # associated with each entry (more on this later).


# What is an object? ---------------------------------------------------------

      x <- 7
      x

      # `<-` assigns `7` to the letter `x`


      # Once we assign a value, it appears in the `environment`

      ls() # command prints off all `objects` currently in the environment

      # Also look at the `environments` tab in R Studio.


      # We can write over objects to assign them new values.
      x
      x <- "hello"
      x
      x <- 6.556789
      x


      # R is an `object-oriented` language, so all the base line functionality
      # stems from assigning data to objects when we then use down the line.



# Class ----------------------------------------------------------------------

      # Every object and data structure has a specific class. Class tells us
      # specific information about the properties of that object. As we know,
      # there are many different types of information in R and not all of it
      # behaves the same way.

      # We use the function `class()` on an object to tell us what class it is.

      x
      class(x)
      class("hello")
      class(FALSE)
      class(2i)


    # We can also query directly to see if an object is a particular class.

      is.character("hello")
      is.character(1.45)


    # Class is important because it tells use what we can and cannot do with
    # an object. For example, we CANNOT add to a character string.

      object = "A sentence about something."
      class(object)
      object + 1 # error

      object = 1
      class(object)
      object + 1 # success!


# Data structures ---------------------------------------------------------

      # Vector
      y <- c(1,2,3,4,5)
      y


    # c() == concatenate: "link (things) together in a chain or series"

    # Here we can "link" different values together into a single vector.

      z <- c("Nigeria","Canada","Ohio")
      z

    # Look at the environment tab in R Studio. See the new objects we've created.

    # Vectors can also be generated as ranges
      p <- 1:10
      p

      h <- 1:100
      h


    # the class of a vector is always the class of the entries in the vector.
      class(y)
      class(z)



    # When different classes are in the same vector, one class dominates
      vec1 <- c(TRUE,89,3,FALSE) # Logical to Numeric
      vec1

      vec2 <- c("cat",89,3,"dog") # all to character
      vec2

      vec3 <- c(TRUE,"cat",89,3,"dog",FALSE) # all to character
      vec3

      # Character class dominates.



  # Matrix

    # Like a vector, a matrix offers a way of organizing data into a 2-dimensional array

      m <- matrix(c(1,2,3,4,5))
      m
      class(m)

      m <- matrix(c(1,2,3,4,5),nrow=1) # Specify the number of rows
      m

      m <- matrix(1:25,nrow=5,ncol=5) # Specify the number of rows and columns
      m

      # Again, the class rules we identified above are true for a matrix as well.
      mat1 <- matrix(c(1:10,"dog","cat"),ncol=2,nrow=6)
      mat1



  # Array

      # similar to a matrix but with more than dimensions
      a = array(0,c(2,2,2))
      a
      class(a)


      # List

      # A list is a way of organizing data of different lengths and classes
      L = list(var1 = c(1,2,3,4,5),
               var2= c("A","B","C","D","E"))
      L
      class(L)


  # Data Frame

      # A data frame (or a dataset) is what we traditionally think of for data
      # analysis.
      var1=c(1,2,3,4,5)
      var2=c("A","B","C","D","E")
      var1
      var2
      D <- data.frame(var1,var2)
      D
      class(D)

      # Though a data frame looks similar to a matrix, it differs in one
      # important way: a data frame can hold many different types of classes
      # within each column.



      D <- data.frame(var1=c(1,2,3,4,5),
                      var2=c("A","B","C","D","E"))
      M <- matrix(c(1,2,3,4,5,"A","B","C","D","E"),ncol=2)


      # What's the difference between the two?
      D
      M

      M[,1]
      class(M[,1])
      D[,1]
      class(D[,1])



    # Finally, the same object can be "coerced" into taking on a different structure

        x = 1:10
        x
        as.matrix(x)
        as.data.frame(x)
        as.list(x)


# Accessing a data structure -------------------------------

        # Length/Dimension

        length(1)
        length("hello")

        y
        length(y)

        m
        dim(m)
        nrow(m)
        ncol(m)

        D
        dim(D)


    # Accessing the Structure of a data object

    # in R, we can access ("get inside") an object by using brackets.

        y # vector
        y[1]
        y[3] # we can grab specific locations within a vector.


  # We know a matrix and data frame has two dimensions, and we can
  # leverage that information to give use specific pieces of the object.

        M # look at the row and column heading when we print our matrix
        M[1,] # the first row
        M[,1] # the first column
        M[1,1] # the first cell

        D # data frame
        D[1,] # first row
        D[,1] # first column
        D[,"var1"] # first column using the columns name
        D[1,"var1"] # first cell


  # For data frames, we can access the information inside the set by using a
  # handle (`$`). This helps use extract specific variables.

        D$var1
        D$var2


# MATH OPERATORS ---------------------------------------------------------------

    # let's briefly review common operators by manipulating two objects: x and y

    x <- 3
    y <- 5

    # Mathematical Operators

          x + y  # addition
          x - y  # subtraction
          x * y  # multiplication
          x / y  # division
          x^y    # exponentiation
          x %*% y  # matrix multiplication

    # Mathematical Functions

          log(x) # Natural Log
          log(x,base = 10) # Log with another base
          exp(x) # exponential

          sum(1:100)
          mean(1:100)
          median(1:100)


          round(3.43455)
          round(3.43455,2)
          round(3.43455,3)


    # remember an object stores a specific piece of information, which we can
    # manipulate down the line. Thus we can make piecewise changes and save each
    # step in a NEW OBJECT

          x <- 100
          x
          z <- x + 7
          z
          w <- z * 8
          w
          p <- w/1000
          p

    # Or overwrite each object

          x <- 100
          x
          x <- x + 7
          x
          x <- x * 8
          x
          x <- x/1000
          x

    # what's the dangers of overwriting when manipulating data?



# BOOLEAN OPERATORS ---------------------------------------------------------------

    # Boolean ("logical") Operators

          x == y      # equals to
          x != y      # does not equal
          x >= y      # greater than or equal to
          x <= y      # less than or equal to
          x > y       # greater than
          x < y       # less than
          x==1 & y==5 # "and" conditional statements
          x==1 | y==5 # "or" conditional statements

    # Boolean ("logical") functions

          str <- "hello"
          num <- 1

        # for Class
          is.character(str)
          is.character(num)

          is.numeric(str)
          is.numeric(num)

        # for Data Type
          is.vector(str)
          is.vector(num) # vector of lenght 1

          is.matrix(str)
          is.data.frame(str)

        # For missing values
          is.na(NA)
          is.na(str)


   # Boolean statements can be used to SUBSET entire vectors and data structures

          vec <- c(1,5,0,9,10,100,.6,88,8.3,2.9,4)

          bool <- vec > 3

          # And we can use this statement to subset values within

          vec[bool]


          # Same for matrices and data frames

          mat <- matrix(1:25,ncol=5,nrow=5)

          bool2 <- mat > 10

          mat[bool2]


          # Interestingly we can use this property to quickly convert values

          mat[bool2] <- 1
          mat[!bool2] <- 0
          mat

          mat[bool2] <- "Yes"
          mat[!bool2] <- "No"
          mat


      # Checking if one list of values is located in another list of values

          values1 <- c("cat","dog","fish","cow")
          values2 <- c("zebra","panda","fish","moose","bee")

          values1 == values2 # didn't work!

          values1 %in% values2 # are any of values1 in the object values2?

          values1[values1 %in% values2]

