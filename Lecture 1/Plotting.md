## Lattice Ploting System
It is implemented using the "lattice" (that has functions xyplot, bplot etc.) and "grid" package. The lattice package is built on top of grid package and we rarely call the
functions of grid package directly.
a) Most useful for Conditioning Plots: For e.g. showing how y changes with x across levels of z. 

b) Entire plot is created using a single function call (xyplot, bwplot etc.). 
It's good for plotting many many plots on the screen. Things like margins/spacing set automatically as the entore plot is specified at once.

## Base Plotting System
There are mostly two amjor packages that are employed by this system. These are "graphics" and "grDevices" package. It is one of the most
powerful system for creating 2D graphics and it is created using following two steps-

a) Initializing a new plot

b) Annotating to an existing plot (i.e. the newly created plot maybe in present context)

#### ?par is used for finding what possible adjustments in parameters are possible for a plot in base plotting system. There is a wide range of such choices available.





a) 
b) What graphics system has to be employed after thoroughly understanding the requirements of the plot.
