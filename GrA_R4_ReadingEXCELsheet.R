### =======================================================
### Computación en Estadística y en Optimización, 26.9.2017
### Group A, R Lecture 4: Data import from EXCEL
### =======================================================

## Loading necessary packages
## Package Hmisc is needed for variable labels
## Package openxlsx is needed to read the EXCEL spreadsheet

# install.packages("Hmisc")
library(Hmisc)

# install.packages("openxlsx")
library(openxlsx)


## Reading the EXCEL spreadsheet
## --------------------------------------
immuno <- read.xlsx("Datasets/Immunology.xlsx", 1, detectDates = TRUE)
str(immuno)
head(immuno)
summary(immuno)


## Editing the data frame
## ----------------------
immuno$vol <- as.factor(immuno$vol)
# Character variables sex and group may be converted in factors
immuno$sex <- factor(immuno$sex)
immuno$group <- factor(immuno$group)
# Change of the reference category of factor group
immuno$group <- relevel(immuno$group, ref = "MDMA")
# What about missing values?
# All 9999 values are missings
is.na(immuno) <- immuno == 9999
# Alternative:
immuno[immuno == 9999] <- NA
summary(immuno)


## Computation of the ages of the volunteers at study begin
## --------------------------------------------------------
head(immuno[, 1:5])
with(immuno, datvisit1 - datbirth)
with(immuno, difftime(datvisit1, datbirth))
immuno$age <- with(immuno, as.vector(trunc(difftime(datvisit1, datbirth))/365.25))
head(immuno)

## Optional: Labels and units for (some) variables
## -----------------------------------------------
label(immuno$vol)       <- "Volunteer ID"
label(immuno$group)     <- "Study group"
label(immuno$sex)       <- "Sex"
label(immuno$datbirth)  <- "Date of birth"
label(immuno$datvisit)  <- "Date of first visit"
label(immuno$datvisit2) <- "Date of second visit"
label(immuno$datvisit3) <- "Date of third visit"
label(immuno$lympho1)   <- "Lymphocytes (1st visit)"
label(immuno$lympho2)   <- "Lymphocytes (2nd visit)"
label(immuno$lympho3)   <- "Lymphocytes (3rd visit)"
label(immuno$cd4v1)     <- "CD4 T cells (1st visit)"
label(immuno$cd4v2)     <- "CD4 T cells (2nd visit)"
label(immuno$cd4v3)     <- "CD4 T cells (3rd visit)"
label(immuno$cd8v1)     <- "CD8 T cells (1st visit)"
label(immuno$cd8v2)     <- "CD8 T cells (2nd visit)"
label(immuno$cd8v3)     <- "CD8 T cells (3rd visit)"
label(immuno$nkiller1)  <- "Natural killer cells (1st visit)"
label(immuno$nkiller2)  <- "Natural killer cells (2nd visit)"
label(immuno$nkiller3)  <- "Natural killer cells (3rd visit)"
label(immuno$age)       <- "Age at study start"

## Units for some variables using function units(Hmisc)
for (i in 8:19) {
  units(immuno[, i]) <- "Cells per microliter"
}
rm(i)
units(immuno$age) <- "Years"
str(immuno)
Label(immuno)


## We may put a comment to the data frame and save the workspace
## -------------------------------------------------------------
comment(immuno) <- "Data from a study on effects of regular XTC consumption"
save(immuno, file = "Immunology.RData")


## Useful information and packages to work with date and time variables:
## (a) Using Dates and Times in R:
##       http://www.noamross.net/blog/2014/2/10/using-times-and-dates-in-r---presentation-code.html
## (b) David James and Kurt Hornik (2015). chron: Chronological Objects which
##       Can Handle Dates and Times. R package version 2.3-47.
## (c) Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with
##       lubridate. Journal of Statistical Software, 40(3), 1-25.
##       URL: http://www.jstatsoft.org/v40/i03/.
