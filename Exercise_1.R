### ==============================================================
### Computación en Estadística y en Optimización, 19.9.2017
### Group A, R Lecture 2: Several solutions of Exercise 1 (Test 0)
### ==============================================================

## Exercise 1
## ==========
set.seed(1909)
age <- rpois(20, 40)
hei <- round(rnorm(20, 175, 10), 2)
age
hei

# 1a
# --
max(hei)


# 1b
# --
minhei <- which.min(hei)
minhei
age[minhei]
# Alternative (that always works)
minhei <- which(hei == min(hei))
age[minhei]

# Be aware of the following problem of function which.min
set.seed(123)
x <- rbinom(20, 10, .5)
sort(x)  #for sorting the random variable
which(x == min(x)) 
which.min(x)

# Use function duplicated to check for duplicated values
duplicated(age)
# How many values are duplicated?
sum(duplicated(age))
# Is there, at least, one duplicated value?
any(duplicated(age))


# 1c
# --
# Possible solutions
length(which(age >= 30 & age <= 40))
length(age[age >= 30 & age <= 40])
# Better solutions
sum(age >= 30 & age <= 40)
sum(age %in% 30:40)


# 1d
# --
uni <- sample(c("Estadística", "Física", "Biología", "Medicina"), 20,
              replace = TRUE)
uni


# 1e
# --
median(age[uni == "Física" | uni == "Medicina"])
median(age[uni %in% c("Física", "Medicina")])
# ¡Ojo! The following is NOT correct
median(age[uni == c("Física", "Medicina")])


# 1f
# --
uni[uni == "Física"] <- "Phys"
uni[uni == "Estadística"] <- "Stats"
# Alternatives using functions replace and sub
uni <- replace(uni, uni == "Estadística", "Stats")
uni <- sub("Física", "Phys", uni)
uni

#Alternatively, we use loops and conditionals
for(i in 1:length(uni))
{
  if(uni[i]=="Fisica"){
    uni[i]<- "Phys"
  }
  else{
    next()
  }
}


# A few examples of functions sub and gsub
# (that do not work with function replace)
sub("í", "i", uni)
sub("o", "O", uni)
gsub("o", "O", uni)


# Solutions of 1d, 1e, and 1f using factors
# -----------------------------------------
# 1d
# --
unif <- factor(sample(c("Estadística", "Física", "Biología", "Medicina"), 20,
                      replace = TRUE))
unif
# The levels of factor unif
levels(unif)
# Factors are stored as numeric objects
mode(unif)

# 1e
# --
median(age[unif %in% c("Física", "Medicina")])
median(age[as.numeric(unif) > 2])

# 1f
# --
levels(unif)
levels(unif)[2:3] <- c("Stats", "Phys")
unif

# The order of the levels of a factor can be changed as follows:
# (i)
relevel(unif, ref = "Stats")
# (ii)
factor(unif, levels = c("Stats", "Medicina", "Phys", "Biología"))
# Same result:
factor(unif, levels = levels(unif)[c(2, 4, 3, 1)])


# Functions that work with character vectors but not with factors
nchar(uni)
nchar(unif)
nchar(as.character(unif))   # Ahora sí...

c(c("A", "B"), c("a", "b"))
c(factor(c("A", "B")), factor(c("a", "b")))


# 1g
# --
datfram <- data.frame(Age = age, Height = hei, Profession = uni)
# Saving the whole work space
save.image("Test0.RData")
# Saving only data frame datfram
save(datfram, file = "Test0bis.RData")
# Check the contents of the working directory
dir()
# If you want to delete a file from within R
unlink("Test0bis.RData")
dir()