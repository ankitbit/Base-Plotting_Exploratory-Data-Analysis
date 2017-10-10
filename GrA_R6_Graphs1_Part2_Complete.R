### =======================================================
### Computación en Estadística y en Optimización, 5.10.2017
### Group A, R Lecture 6: Basic graphs (II)
### =======================================================

load("Immunology.RData")

## Labels and units
## ----------------
## If Hmisc can be loaded, labels and units can be extracted as follows:
library(Hmisc)
Label(immuno)
label(immuno$cd4v1)
units(immuno$cd4v1)
# Alternatives that do not depend on package Hmisc
attr(immuno$cd4v1, "label")
attr(immuno$cd4v1, "units")


## Bidimensional plots
## ===================
## (a) Scatterplots
## ----------------
windows(width = 8)
par(las = 1, font = 2, font.lab = 4, font.axis = 2)
plot(cd4v1~nkiller1, immuno)
# Much nicer:
with(immuno, plot(cd4v1~nkiller1, xlab = "Cells per microliter",
                  ylab = "Cells per microliter", pch = 16,
                  col = as.numeric(group), cex = 1.5))
title("CD4 cells vs. Natural killer cells", cex.main = 1.3)
legend("bottomright", levels(immuno$group), col = 1:3, pch = 16)
# legend("bottom", levels(immuno$group), col = 1:3, pch = 16, bty = "n",
#        title = "Study group")


# Function locator can be used to indicate where to set the legend
legend(locator(1), levels(immuno$group), col = 1:3, pch = 16)

# Points can be identified with the identify function
# (press Esc to stop identifying points)
with(immuno, identify(nkiller1, cd4v1))
with(immuno, identify(nkiller1, cd4v1, label = vol))
with(immuno, identify(nkiller1, cd4v1, label = sex))


## More code but more flexible:
## ----------------------------
xli <- range(immuno$nkiller1)
yli <- range(immuno$cd4v1)
windows(width = 8)
par(las = 1, font = 2, font.lab = 4, font.axis = 2)
with(subset(immuno, group == "MDMA"),
     plot(cd4v1~nkiller1, xlab = attr(nkiller1, "label"),
          ylab = attr(cd4v1, "label"), pch = 16, cex = 1.3,
          xlim = xli, ylim = yli))
with(subset(immuno, group == "Cannabis"),
     points(cd4v1~nkiller1, pch = 17, col = 2, cex = 1.3))
with(subset(immuno, group == "Control"),
     points(cd4v1~nkiller1, pch = 18, col = 4, cex = 1.3))
title("CD4 cells vs. Natural killer cells", cex.main = 1.3)
legend("bottom", levels(immuno$group), col = c(1, 2, 4), pch = 16:18,
       bty = "n", title = "Study group")

dev.off()
rm(xli, yli)
# See also function scatterplot of the car package

## Date variables can also be used in scatterplots
windows(width = 8)
par(las = 1, font = 2, font.lab = 4, font.axis = 2)
plot(age~datbirth, immuno, xlab = "Year", ylab = "Age", pch = 16, cex = 1.3)
dev.off()

## Scatterplot matrices
windows(width = 10, height = 10)
pairs(immuno[8:19], upper.panel = NULL, lower.panel = panel.smooth, pch = 16)
dev.off()


## Where can we find specific help about the plot functions?
methods(plot)
attr(methods(plot), "info")
?plot           # Very general help
?plot.default   # Help on scatterplots
?plot.lm        # Help on the residual plots of linear models
## Where can we find the code of funtion plot.lm?
getAnywhere(plot.lm)


## (b) Mosaicplots
## ---------------
windows()
with(immuno, mosaicplot(group~sex))
par(las = 1, font = 2, font.axis = 2, font.lab = 4)
with(immuno, mosaicplot(group~sex, xlab = "Study group", ylab = "Gender",
                        main = "Gender distribution per group", cex.axis = 1,
                        col = 2:3))
dev.off()


## Several graphs in one graphics device:
## Alternatives to the mfrow argument
## ======================================
## (a) Function layout (ManyInOne.jpg)
## -----------------------------------
windows(width = 12, height = 10)
par(las = 1, font = 2, font.axis = 2, font.lab = 4)
layout(matrix(c(1, 2, 2, 3, 2, 2, 4:6), nr = 3, byrow = TRUE))
# layout(matrix(c(1, 2, 2, 3, 2, 2, 4:6), nr = 3, byrow = TRUE), width = c(.4, .3, .3))
pie(table(immuno$group), clockwise = TRUE, col = rainbow(10))
with(immuno, plot(cd4v1~nkiller1, xlab = attr(nkiller1, "label"),
                  ylab = attr(cd4v1, "label"), pch = 16,
                  col = as.numeric(group), cex = 1.5))
legend("bottomright", levels(immuno$group), col = 1:3, pch = 16)
boxplot(lympho1~group, immuno, col = 2:4, lwd = 2, main = "Lymphocytes",
        pars = list(boxwex = 0.5))
boxplot(cd4v1~group, immuno, col = 2:4, lwd = 2, main = "CD4 Cells",
        pars = list(boxwex = 0.5))
boxplot(cd8v1~group, immuno, col = 2:4, lwd = 2, main = "CD8 Cells",
        pars = list(boxwex = 0.5))
boxplot(nkiller1~group, immuno, col = 2:4, lwd = 2, main = "Natural Killer Cells",
        pars = list(boxwex = 0.5))
dev.off()


## (b) Argument fig (ScatHistBoxplot.jpg)
## --------------------------------------
windows(width = 10, height = 8)
par(fig = c(0, .8, 0, .75), las = 1, font = 2, font.lab = 4, font.axis = 2,
    mar = c(5, 4, 1, 1))
plot(cd4v1~nkiller1, immuno)
with(immuno, plot(cd4v1~nkiller1, xlab = attr(nkiller1, "label"),
                  ylab = attr(cd4v1, "label"), pch = 16,
                  col = as.numeric(group)), cex.pch = 1.5)
legend("bottomright", levels(immuno$group), col = 1:3, pch = 16)
par(fig = c(0, .8, .75, 1), mar = c(1, 4, 2, 2), new = TRUE)
hist(immuno$nkiller1, breaks = 20, xlab = NULL, main = NULL, xaxt = "n")
par(fig = c(0.8, 1, 0, .75), mar = c(5, 1, 1, 1), bty = "n", new = TRUE)
boxplot(immuno$cd4v1, xlab = NULL, main = NULL, yaxt = "n")
dev.off()


## (c) Function split.screen
## -------------------------
windows(width = 12, height = 8)
par(las = 1, font = 2, font.axis = 2, font.lab = 4)
split.screen(c(2, 1))
split.screen(c(1, 3), screen = 1)
split.screen(c(1, 2), screen = 2)
screen(4)
with(immuno, plot(cd4v1~nkiller1, xlab = attr(nkiller1, "label"),
                  ylab = attr(cd4v1, "label"), pch = 16,
                  col = as.numeric(group), cex = 1.2))
screen(6)
with(immuno, hist(nkiller1, breaks = 20, xlab = attr(nkiller1, "label"),
                  col = "steelblue"))
screen(7)
with(immuno, hist(cd4v1, breaks = 20, xlab = attr(cd4v1, "label"),
                  col = "tomato"))
# Back to full screen
close.screen(all.screens = TRUE)
with(immuno, hist(cd4v1, breaks = 20, xlab = attr(cd4v1, "label"),
                  col = "tomato"))
dev.off()


## Drawing some functions
## ======================
windows(width = 12, height = 8)
par(mfrow = c(2, 2), lwd = 3, font = 2, font.lab = 2, font.axis = 4,
    oma = c(0, 0, 1, 0), las = 1)
curve(dnorm(x, mean = 0, sd = 1), from = -4, to = 4, ylab = "", col = 2)
title("The standard normal distribution")
curve(dchisq(x, 3), from = 0, to = 10, ylab = "", col = "springgreen4")
title("The chi-squared distribution with n = 3")
curve(dnorm(x, mean = 0, sd = 1.5), from = -4, to = 4, ylab = "",
      col = "slateblue2")
title("The Normal distribution with mu = 0 and sigma = 1.5")
# title(expression(bold(paste("The Normal distribution with ", mu, " = 0 and ",
#                             sigma, " = 1.5", sep = ""))))
curve(sin(x), from = 0, to = 10, ylab = "", col = "steelblue")
title("Not a density function: the sinus curve")
title("Some density functions", outer = TRUE, cex.main = 1.5, family = "serif")
dev.off()

# Use of other text fonts in functions like par or title
windowsFonts()


## Shading density plots
## =====================
## (Slightly modified) Example from:
## http://stackoverflow.com/questions/3494593/shading-a-kernel-density-plot-between-two-points
set.seed(123)
draws <- rnorm(1000)^2
dens <- density(draws, from = 0)
dens
str(dens)

windows(width = 8)
par(lwd = 3, font = 2, font.lab = 2, font.axis = 4)
plot(dens)

# Objective: To shade the area below the curve from the 75% to the 95% quantile
(q75 <- quantile(draws, .75))
(q95 <- quantile(draws, .95))

x1 <- min(which(dens$x >= q75))
x2 <- max(which(dens$x <  q95))
with(dens, polygon(x = c(x[c(x1, x1:x2, x2)]), y = c(0, y[x1:x2], 0),
                   col = "gray"))


## A graph window with text only
## =============================
# install.packages("gplots")
library(gplots)
windows(width = 14, height = 7)
par(mfrow = c(1, 2), font = 2, font.lab = 4, font.axis = 2, las = 1)
# Left panel
with(immuno, plot(cd4v1~nkiller1, xlab = "Cells per microliter",
                  ylab = "Cells per microliter", pch = 16,
                  col = as.numeric(group), cex = 1.3))
title("CD4 T cells vs. Natural killers")
legend("bottomright", levels(immuno$group), col = 1:3, pch = 16)
abline(lm(cd4v1~nkiller1, immuno), lwd = 3)
# Right panel
summary(lm(cd4v1~nkiller1, immuno))
sumreg <- summary(lm(cd4v1~nkiller1, immuno))
capture.output(sumreg)
textplot(capture.output(sumreg), valign = "top")
title("Linear Regression: CD4 count vs. Natural Killer Cells")

graphics.off()
rm(sumreg)
