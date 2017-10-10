### =======================================================
### Computación en Estadística y en Optimización, 28.9.2017
### Group A, R Lecture 5: Basic graphs (Part I)
### =======================================================

## ¡Ojo! The following command does NOT work in the PC labs of the FME
##       under RStudio. In that case, replace
##       -- units(immuno$lympho1) by attr(immuno$lympho1, "units")
##       -- label(immuno$lympho1) by attr(immuno$lympho1, "label")
library(Hmisc)

## The data set on regular XTC consumption
load("Immunology.RData")
str(immuno)
attributes(immuno)
summary(immuno)

## Which are the missing data of immuno
which(is.na(immuno), arr.ind = TRUE)
# INCORRECT command:
which(immuno == NA)


## Some standard graphs
## ====================
## (a) Boxplots
## ------------
##Opening Graphics Device
windows(width = 8, height = 8)               # Linux: x11(); Apple: quartz()
par(mfrow = c(2, 2), las = 1, font.main = 4, font.lab = 2, font.axis = 2,
    oma = c(0, 0, 1, 0), mar = c(3, 4, 4, 2))
boxplot(lympho1~group, immuno, col = 2:4, lwd = 2, ylab = "Cells per microliter",
        main = "Lymphocytes", pars = list(boxwex = 0.7), pch = 25)

#Varying color parameter: 2:4 to 4:6 
#boxplot(lympho1~group, immuno, col = 4:6, lwd = 2, ylab = "Cells per microliter",
#        main = "Lymphocytes", pars = list(boxwex = 0.7), pch = 16)


boxplot(cd4v1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "CD4 Cells", pars = list(boxwex = 0.7), pch = 16)
boxplot(cd8v1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "CD8 Cells", pars = list(boxwex = 0.7), pch = 16)
boxplot(nkiller1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "Natural Killer Cells", pars = list(boxwex = 0.7), pch = 16)
title("Immunological markers at 1st visit", outer = TRUE, cex.main = 1.5)


# If you want to close the graphics device
dev.off()

## Different ways to save the figures in an external file
## ------------------------------------------------------
# 1) Save a graph in an open graphics device
savePlot("Boxplots", type = "pdf")     # or any other format (jpg, png, tiff)
savePlot("Boxplots", type = "png")

# 2) Draw the graph directly in a pdf file
pdf("Boxplot.pdf", width = 8, height = 8)
par(las = 1, font.main = 4, font.lab = 4, font.axis = 2)
boxplot(lympho1~group, immuno, col = 2:4, lwd = 2, ylab = "Cells per microliter",
        main = "Lymphocytes", pars = list(boxwex = 0.7), pch = 16)
boxplot(cd4v1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "CD4 Cells", pars = list(boxwex = 0.7), pch = 16)
boxplot(cd8v1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "CD8 Cells", pars = list(boxwex = 0.7), pch = 16)
boxplot(nkiller1~group, immuno, col = 2:4, lwd = 2, ylab = units(immuno$lympho1),
        main = "Natural Killer Cells", pars = list(boxwex = 0.7), pch = 16)
dev.off()


## Figures could be saved in a recently created folder
dir.create("Figures")
setwd("Figures")
# Create and save files in "Figures"
# pdf()
# ...
# dev.off()
setwd("..")
# The folder could be deleted in the following way
unlink("Figures", recursive = TRUE)


## (b) Boxplots with a beeswarm
## ----------------------------
# install.packages("beeswarm")
library(beeswarm)
tit <- label(immuno$lympho1)
# tit <- "Lymphocyte level (1st visit)"
windows(width = 12, height = 12)
par(mfrow = c(2, 2), font = 2, font.lab = 4, font.axis = 2, las = 1, pch = 16)
with(immuno, boxplot(lympho1~group, main = tit, ylab = units(lympho1), col = 2:4))
with(immuno, beeswarm(lympho1~group, main = tit, xlab = "", ylab = units(lympho1),
                      col = 2:4))
with(immuno, boxplot(lympho1~group, main = tit, ylab = units(lympho1)))
with(immuno, beeswarm(lympho1~group, main = tit, ylab = units(lympho1), add = TRUE,
                      col = 2:4))
with(immuno, boxplot(lympho1~group, main = tit, ylab = units(lympho1)))
with(immuno, beeswarm(lympho1~group, add = TRUE, pwcol = as.numeric(sex)))
legend("bottomright", levels(immuno$sex), col = 1:2, pch = 16, bty = "n",
       title = "Gender")

dev.off()
rm(tit)


## (c) Histograms
## --------------
windows(width = 15)
par(mfrow = c(1, 3), las = 1, font = 2, font.lab = 4, font.axis = 2, cex = 1)
hist(immuno$lympho1, xlab = units(immuno$lympho1), col = 3,
     main = label(immuno$lympho1))
with(immuno, hist(lympho1, breaks = 20, xlab = units(lympho1),
                  col = "steelblue", main = label(lympho1)))
# Including the estimated density function
par(mar = c(5, 5, 4, 2))
with(immuno, hist(lympho1, breaks = 20, xlab = units(lympho1), col = "maroon",
                  ylab = "", freq = FALSE, main = label(lympho1)))
lines(density(immuno$lympho1), lwd = 3)
mtext("Density", 2, line = 4, las = 0)
dev.off()

# Any other color?
colours()

# What about the rainbow or terrain colours?
windows(width = 8, height = 12)
par(mfrow = 2:1, las = 1, font = 2, font.lab = 4, font.axis = 2,
    oma = c(0, 0, 1, 0))
with(immuno, hist(lympho1, breaks = 20, xlab = units(lympho1), col = rainbow(20),
                  main = label(lympho1)))
with(immuno, hist(lympho1, breaks = 20, xlab = units(lympho1),
                  col = terrain.colors(20), main = label(lympho1)))
dev.off()


# Graphical representation of (nearly) all variables
# using function hist of package Hmisc
windows(width = 12, height = 12)
par(las = 1, font = 2, font.lab = 4, font.axis = 2, oma = c(0, 0, 1, 0))
hist(immuno, nclass = 15)


## (d) Graphs as R objects (HistogramWithText.jpg)
## -----------------------------------------------
histo <- hist(immuno$lympho1, breaks = 20, plot = FALSE)
histo
str(histo)

windows(width = 9)
par(las = 1, font.lab = 4, font.axis = 2)
plot(histo, col = "olivedrab", xlab = units(immuno$lympho1), main = "Lymphocyte level")
text(...)
dev.off()
rm(histo, wmax, hmax)
