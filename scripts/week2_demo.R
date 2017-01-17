
# WEEK 2 ------------------------------------------------------------------

# Use Ctrl or Command + Shift + R to add section breaks

# Learning Vectors --------------------------------------------------------

# Make a vector of names
firstnames <- c("Ryan", "Sue", "John", "Rachel")
firstnames

str(firstnames)  # tells you structure of data

# make a vector of animals
animals <- c('cat', "dog", 'rat', 'mouse')
animals

# combine vectors
biglist <- c(firstnames, animals)

biglist

# Make a vector of numbers

lista <- c(1, 2, 5, 8, 11, NA, 15)
lista
str(lista)

# find out length of vector
length(lista)

# summarizes data based on type
summary(lista)
summary(biglist)

mean(x=lista, na.rm = TRUE)


# Working with NAs --------------------------------------------------------



is.na(lista)

lista[6] # accessing 6 item in the vector
lista_noNA <- lista[!is.na(lista)]

length(lista_noNA)

lista[6] <- 0
lista

rm(lista_noNA)


# Reading in Data ---------------------------------------------------------

download.file("https://ndownloader.figshare.com/files/2292169", "data/portal_data_joined.csv")

surveys <- read.csv('data/portal_data_joined.csv')

head(surveys)
tail(surveys)
summary(surveys)

str(surveys)

summary(surveys$species_id)
levels(surveys$species_id)

dim(surveys)
dim(surveys)[2] # access how many colummns in data

surveys[10,]

summary(surveys[,4]) # pull summary of specific col
summary(surveys$year)


# FILTER DATA TO A GIVEN YEAR ---------------------------------------------

dat1977 <- surveys[surveys$year==1977, ]

barplot(height = dat1977$hindfoot_length)

plot(x = dat1977$hindfoot_length, y = dat1977$weight, pch=21, bg="maroon")
