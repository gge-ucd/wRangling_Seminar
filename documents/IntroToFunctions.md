Intro To Functions
================
Myfanwy Johnston
3/13/2017

Functions in R
--------------

These materials are taken mostly from the Software Carpentry Lesson on Creating Functions, and From Wickham's Advanced R Book.

R is a functional programming language. You can do anything with functions that you can do with vectors: you can assign them to variables, store them in lists, pass them as arguments to other functions, create them inside functions, and even return them as the result of a function.

The key to understanding/practicing writing functions is to start small and simple, then build up, often through nesting functions.

Rstudio function shortcut
=========================

Rstudio provides a shortcut for a skeleton function: type 'fun' and hit tab, and you get:

Usually the skeleton provides what you need for every function: a name, arguments (to which you will provide variables for the function to evaluate), and brackets that will contain the body of the function. What the skeleton doesn't provide is the call to the return() function, which you will probably need to include yourself if you want the function to return a value or values that you can see or store.

Let's fill in that skeleton with our first function:

``` r
# our first function: convert a temperature from fahrenheit to kelvin:
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

# and call it:
# what is the freezing point of water in Kelvin?
fahr_to_kelvin(32)
```

    ## [1] 273.15

``` r
# boiling point of water?
fahr_to_kelvin(212)
```

    ## [1] 373.15

``` r
# we can store the output of our function to an object:

kelvin100 <- fahr_to_kelvin(100)
kelvin100
```

    ## [1] 310.9278

``` r
# and we can pass numeric vectors to it:
kelvinvector <-fahr_to_kelvin(1:10)
kelvinvector
```

    ##  [1] 255.9278 256.4833 257.0389 257.5944 258.1500 258.7056 259.2611
    ##  [8] 259.8167 260.3722 260.9278

``` r
# or use it to store new values in a dataframe:
temp <- get("pressure")
temp
```

    ##    temperature pressure
    ## 1            0   0.0002
    ## 2           20   0.0012
    ## 3           40   0.0060
    ## 4           60   0.0300
    ## 5           80   0.0900
    ## 6          100   0.2700
    ## 7          120   0.7500
    ## 8          140   1.8500
    ## 9          160   4.2000
    ## 10         180   8.8000
    ## 11         200  17.3000
    ## 12         220  32.1000
    ## 13         240  57.0000
    ## 14         260  96.0000
    ## 15         280 157.0000
    ## 16         300 247.0000
    ## 17         320 376.0000
    ## 18         340 558.0000
    ## 19         360 806.0000

``` r
temp$kelv <- fahr_to_kelvin(temp$temperature)
temp
```

    ##    temperature pressure     kelv
    ## 1            0   0.0002 255.3722
    ## 2           20   0.0012 266.4833
    ## 3           40   0.0060 277.5944
    ## 4           60   0.0300 288.7056
    ## 5           80   0.0900 299.8167
    ## 6          100   0.2700 310.9278
    ## 7          120   0.7500 322.0389
    ## 8          140   1.8500 333.1500
    ## 9          160   4.2000 344.2611
    ## 10         180   8.8000 355.3722
    ## 11         200  17.3000 366.4833
    ## 12         220  32.1000 377.5944
    ## 13         240  57.0000 388.7056
    ## 14         260  96.0000 399.8167
    ## 15         280 157.0000 410.9278
    ## 16         300 247.0000 422.0389
    ## 17         320 376.0000 433.1500
    ## 18         340 558.0000 444.2611
    ## 19         360 806.0000 455.3722

Composing/Nesting Functions:
----------------------------

We want to write a little set of functions that convert temperatures from different scales. We already have the fahr to kelvin one, what about kelvin to celcius?

    ## [1] -273.15

...or fahrenheit to celcius? We have the building blocks for this (fahr -&gt; kelvin -&gt; celcius), so let's put it all together:

``` r
# we'll write a function that calls our other function inside of it:

fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}

# freezing point of water in Celsius
fahr_to_celsius(32.0)
```

    ## [1] 0

We went through writing a separate function, above, to show you how functions can call other functions within their internals. But a more parsimonious way to do this is to chain function calls:

``` r
# freezing point of water in Celsius
kelvin_to_celsius(fahr_to_kelvin(32.0))
```

    ## [1] 0

``` r
# we do this all the time in scripting. For example:

length(unique(iris$Species))
```

    ## [1] 3

Practice:
=========

1.  Write a function called `fence` that takes two vectors as arguments, called original and wrapper\`, and returns a new vector that has the wrapper vector at the beginning and end of the original.

``` r
fence <- function(original, wrapper) {
  wrapped <- c(wrapper, original, wrapper)
  return(wrapped)
}

fence("Oh hi", "hmmm")
```

    ## [1] "hmmm"  "Oh hi" "hmmm"

1.  Write a function called `outside` that returns a vector made up of just the first and last elements of its input.

``` r
outside <- function(vector) {
  ans = c(vector[1],
          vector[length(vector)])
  return(ans)
}

test <- 1:10
outside(test)
```

    ## [1]  1 10

``` r
test2 <- letters
outside(letters)
```

    ## [1] "a" "z"

The Call Stack and Scoping
==========================

For a deeper understanding of how functions work, you’ll need to learn how they create their own environments and point to variables created by other functions. Calls to functions are managed via the call stack. The call stack is the organization system that R uses to make sure that every variable in the R environment points to what it's supposed to at any given time. Your R session environment has its own stack frame (environment), a one-to-one relationship you can see in the Environment panel in RStudio. Whenever a function is called, R creates a new stack frame (environment) on top of the base environment to keep that function's variables separate from those defined by other functions. That function's environment disappears when the function is done running, and its output gets added to the base environment.

The call stack can be better understood through something called scoping, which is like an order of operations for how R looks for named objects in its environment:

``` r
input1 = 20 # we create an object in our environment called input1

# we write a function that has an argument also called input1:
mySum <- function(input1, input2 = 10) {
  output <- input1 + input2
  return(output)
}

# what should we expect when we call mySum(input1 = 1, 3)?
mySum(input1 = 1, input2 = 3)
```

    ## [1] 4

``` r
# Another scoping example:

y <- 10

# We create a function, f, that includes a definition of the variable y within it:
f <- function(x) {
       
    y <- 2  # R will look to this value first when y is called by the function
    y*2 + x
}

f(5)
```

    ## [1] 9

``` r
# and another function, g, which does not define y within its functional environment:
g <- function(x) {
     x*y # R will first look inside the function; finding nothing, it will look in the global environment and find y <- 10.  It will use this value.
}

g(5)
```

    ## [1] 50

``` r
# Now, let's re-write the function f so that it calls g within it:
f <- function(x) {
       
    y <- 2  # R will look to this value first within the function f
    y*2 + g(x) #...and will have to look outside to the global env when this one is called, so you'll get 2*2 + x*10
}

f(3)
```

    ## [1] 34

A note on default values for arguments:
=======================================

You can specify defaults for arguments, like we did above with `input2 = 10`. When you call a function, arguments can be passed by matching based on name (i.e. `input2`), by position (R will assume the value in the second position is for `input2`), or by omitting them (in which case the default value, `10` is used).

Documenting Functions
=====================

``` r
center <- function(data, desired) {
  # return a new vector containing the original data centered around the
  # desired value.
  # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
  new_data <- (data - mean(data)) + desired
  return(new_data)
}

center(data = c(0,0,0,0), desired = 5)
```

    ## [1] 5 5 5 5

Anonymous Functions
===================

If you choose not to give the function a name, you get an anonymous function.

You use an anonymous function when it’s not worth the effort to give it a name:

``` r
lapply(mtcars, function(x) length(unique(x)))
```

    ## $mpg
    ## [1] 25
    ## 
    ## $cyl
    ## [1] 3
    ## 
    ## $disp
    ## [1] 27
    ## 
    ## $hp
    ## [1] 22
    ## 
    ## $drat
    ## [1] 22
    ## 
    ## $wt
    ## [1] 29
    ## 
    ## $qsec
    ## [1] 30
    ## 
    ## $vs
    ## [1] 2
    ## 
    ## $am
    ## [1] 2
    ## 
    ## $gear
    ## [1] 3
    ## 
    ## $carb
    ## [1] 6

``` r
Filter(function(x) !is.numeric(x), mtcars)
```

    ## data frame with 0 columns and 32 rows

You can call anonymous functions with named arguments, but doing so is a good sign that your function needs a name.

What functions would you like to write?
=======================================
