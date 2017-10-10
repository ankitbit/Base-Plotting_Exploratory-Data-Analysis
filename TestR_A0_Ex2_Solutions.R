### ==============================================================
### Computación en Estadística y en Optimización, 21.9.2017
### Group A, R Lecture 3: Several solutions of Exercise 2 (Test 0)
### ==============================================================

## Exercise 2
## ==========
state.x77
state.region

## A little exploration of the data set
View(state.x77)
head(state.x77)
tail(state.x77)
str(state.x77)
?state.x77

# 2a
# --
is.matrix(state.x77)
is.data.frame(state.x77)

## Better
class(state.x77)
# Some additional information on the storage mode of state.x77
mode(state.x77)


# 2b
# --
ncol(state.x77)
# Output that contains the number of columns
dim(state.x77)
str(state.x77)
attributes(state.x77)

# Number of elements of the matrix
length(state.x77)


# 2c
# --
states77 <- data.frame(state.x77)
#Also using as.data.frame()
states77$Regio <- state.region
head(states77)
# Two steps in one:
states77 <- data.frame(state.x77, Regio = state.region)

# Number of columns
ncol(states77)
length(states77)

# Number of elements of the data frame
prod(dim(states77))


# 2d
# --
states77$HS.Grad <- NULL
states77$Frost <- NULL
head(states77)

# Two steps in one:
states77$HS.Grad <- states77$Frost <- NULL

# Alternative solution using function subset
states77 <- subset(states77, select = -c(HS.Grad, Frost))

# Other solution
states77 <- states77[, - which(names(states77) %in% c("HS.Grad", "Frost"))]

# What does NOT work
states77$F <- NULL

## Several ways to refer to a variable
states77$Regio
states77[, "Regio"]
states77[["Regio"]]


# Cambio de los nombres de las variables
names(states77) <- substr(tolower(names(states77)), 1, 4)
head(states77)


# 2e
# --
states77["Alabama", "life"] <- NA
states77["Wyoming", "life"] <- NA
# Two steps in one:
states77[c("Alabama", "Wyoming"), "life"] <- NA


# 2f
# --
# Pairwise computations require 3 executions of function cor. Too many!
cor(states77$inco, states77$illi)
cor(states77$inco, states77$life, use = "complete.obs")
cor(states77$life, states77$illi, use = "c")

# Much better:
cor(states77[, c("inco", "illi", "life")], use = "complete.obs")
# Or (and with some rounding):
round(cor(states77[, c("inco", "illi", "life")], use = "pairwise.complete.obs"), 3)


## ---------------------------------------------
## The use of function attach is not a good idea
round(cor(cbind(inco, illi, life), use = "c"), 3)
attach(states77)
round(cor(cbind(inco, illi, life), use = "c"), 3)
detach(states77)
round(cor(cbind(inco, illi, life), use = "c"), 3)

# What does attach, actually, do.
search()
attach(states77)
search()
ls()
ls(2)
ls(3)
ls.str()
round(cor(cbind(inco, illi, life), use = "c"), 3)
detach(states77)
search()

## BUT!
inco <- 1:15
attach(states77)
round(cor(cbind(inco, illi, life), use = "c"), 3)
rm(inco)
round(cor(cbind(inco, illi, life), use = "c"), 3)
detach(states77)
## ---------------------------------------------


# 2g
# --
mean(subset(states77, regi == "Northeast")$inco)
mean(subset(states77, as.numeric(regi) == 2)$inco)
with(states77, mean(inco[regi == "North Central"]))
with(subset(states77, regi == "West"), mean(inco))

# Better solutions
with(states77, by(inco, regi, mean))
with(states77, tapply(inco, regi, mean))
(tap <- with(states77, tapply(inco, regi, mean)))
which.max(tap)
max(tap)

# Best:
tap[which.max(tap)]
