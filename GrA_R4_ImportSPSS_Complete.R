### =======================================================
### Computación en Estadística y en Optimización, 26.9.2017
### Group A, R Lecture 4: Data import from SPSS
### =======================================================

# install.packages("Hmisc")
library(Hmisc)                  # Works with the present version of RStudio

## Importing the SPSS file Immunology.sav
## --------------------------------------
# The following R command will only work if your working directory contains
# the folder Datasets, which contains the SPSS file Immunology.sav.
getwd()
"Immunology.sav" %in% dir("Datasets")
# If TRUE, then continue; if FALSE, then first set your working directory
immuno <- spss.get("Datasets/Immunology.sav", datevars = c("datbirth", "datvisit1",
                                                           "datvisit2", "datvisit3"))
str(immuno)
head(immuno)
summary(immuno)
Label(immuno)


## Editing the data frame
## ----------------------
immuno$vol <- as.factor(immuno$vol)
# Delete level "Undefined", which has no observation
immuno$group <- factor(immuno$group)

# Missing data
immuno[immuno == 9999] <- NA
# Alternative
is.na(immuno) <- immuno == 9999


# It can be useful to store the units of numeric variables
# (using function units of package Hmisc)
for (i in 8:19) {
  units(immuno[, i]) <- "Cells per microliter"
}
rm(i)
describe(immuno)


## Computation of the ages of the volunteers at study begin
## --------------------------------------------------------
head(immuno[, 1:5])
with(immuno, datvisit1 - datbirth)
with(immuno, difftime(datvisit1, datbirth))
immuno$age <- with(immuno, as.vector(trunc(difftime(datvisit1, datbirth))/365.25))
# Gives the same result
with(immuno, as.numeric(trunc(difftime(datvisit1, datbirth)/365.25)))
with(immuno, as.vector(floor(difftime(datvisit1, datbirth)/365.25)))
label(immuno$age) <- "Age"
units(immuno$age) <- "Years"

head(immuno)
describe(immuno)


## We may put a comment to the data frame and save the workspace
## -------------------------------------------------------------
comment(immuno) <- "Data from a study on effects of regular XTC consumption"
str(immuno)
attributes(immuno)
save(immuno, file = "Immunology.RData")


## Weekdays and months
weekdays(immuno$datbirth)
months(immuno$datbirth)


## The language in use
Sys.getlocale("LC_ALL")

## The units used in R can be expressed in other languages
# Castellano
Sys.setlocale("LC_ALL", "esp")
weekdays(immuno$datbirth)
# Català
Sys.setlocale("LC_ALL", "cat")
weekdays(immuno$datbirth)
# Euskara
Sys.setlocale("LC_ALL", "Basque")
weekdays(immuno$datbirth)
# Galego
Sys.setlocale("LC_ALL", "Galician")
weekdays(immuno$datbirth)
# Greek
Sys.setlocale("LC_ALL", "Greek")
weekdays(immuno$datbirth)
# Arabic
Sys.setlocale("LC_ALL", "Arabic")
weekdays(immuno$datbirth)
# German
Sys.setlocale("LC_ALL", "deu")
weekdays(immuno$datbirth)
# Back to English
Sys.setlocale("LC_ALL", "eng")
weekdays(immuno$datbirth)


## Useful information and packages to work with date and time variables:
## (a) Using Dates and Times in R:
##       http://www.noamross.net/blog/2014/2/10/using-times-and-dates-in-r---presentation-code.html
## (b) David James and Kurt Hornik (2015). chron: Chronological Objects which
##       Can Handle Dates and Times. R package version 2.3-47.
## (c) Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with
##       lubridate. Journal of Statistical Software, 40(3), 1-25.
##       URL: http://www.jstatsoft.org/v40/i03/.
