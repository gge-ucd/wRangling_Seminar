# ModernDiver

#A new and very nicely put together R/Stats Book worth checking out is here:
  
#  - https://ismayc.github.io/moderndiver-book/
  
#  What's great is it teaches R and how to implement R from a modeling framework, #demonstrates a powerful pipeline that we all should follow. It's based in part using #Hadley Wickam's R book, and the "tidyverse" of packages. We'll talk more about this # next week. 


needed_pkgs <- c("nycflights13", "dplyr", "ggplot2", "knitr", 
                 "okcupiddata", "dygraphs", "rmarkdown", "mosaic", "ggplot2movies")

new.pkgs <- needed_pkgs[!(needed_pkgs %in% installed.packages())]

if(length(new.pkgs)) {
  install.packages(new.pkgs, repos = "http://cran.rstudio.com")
}

