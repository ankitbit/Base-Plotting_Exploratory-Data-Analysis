#

#  If you don't have time to do EDA, you really don't have time to do hypothesis tests. And you should always do EDA first
# While a good, informative plot can sometimes be the end point of an analysis, it is more like a beginning:
# it helps guide you in the quantitative statistical analyses that come next.

# Import plotting modules
import matplotlib.pyplot as plt
import seaborn as sns


# Set default Seaborn style
sns.set()

# Plot histogram of versicolor petal lengths
plt.hist(versicolor_petal_length)

# Show histogram
plt.show()

# Plot histogram of versicolor petal lengths
_ = plt.hist(versicolor_petal_length)

# Label axes
plt.xlabel('petal length (cm)')
plt.ylabel('count')



# Show histogram
plt.show()

'''
The histogram you just made had ten bins. This is the default of matplotlib. 
The "square root rule" is a commonly-used rule of thumb for choosing number of bins:
choose the number of bins to be the square root of the number of samples. 
Plot the histogram of Iris versicolor petal lengths again, this time using the square root rule for the number of bins. 
You specify the number of bins using the bins keyword argument of plt.hist().

The plotting utilities are already imported and the seaborn defaults already set. 
The variable you defined in the last exercise, versicolor_petal_length, is already in your namespace.
'''

# Import numpy
import numpy as np

# Compute number of data points: n_data
n_data= len(versicolor_petal_length)

# Number of bins is the square root of number of data points: n_bins
n_bins= np.sqrt(n_data)

# Convert number of bins to integer: n_bins
n_bins= int(n_bins)

# Plot the histogram
plt.hist(versicolor_petal_length, bins= n_bins)

# Label axes
_ = plt.xlabel('petal length (cm)')
_ = plt.ylabel('count')

# Show histogram
plt.show()

'''
# Binning Bias: 
'''
# Create bee swarm plot with Seaborn's default settings
sns.swarmplot(x= 'species', y= 'petal length (cm)', data= df)

# Label the axes
plt.xlabel('species')
plt.ylabel('petal length (cm)')
# Show the plot
plt.show()


'''
'''
def ecdf(data):
    """Compute ECDF for a one-dimensional array of measurements."""
    # Number of data points: n
    n = len(data)

    # x-data for the ECDF: x
    x = np.sort(data)

    # y-data for the ECDF: y
    y = np.arange(1, n+1) / n

    return x, y


'''
'''
# Compute ECDF for versicolor data: x_vers, y_vers
x_vers, y_vers = ecdf(versicolor_petal_length)

# Generate plot
plt.plot(x_vers, y_vers, marker= '.', linestyle= 'none')

# Label the axes
plt.xlabel('petal length (cm)')
plt.ylabel('ECDF')


# Display the plot
plt.show()

'''
'''
# Compute ECDFs
x_set, y_set= ecdf(setosa_petal_length)
x_vers, y_vers= ecdf(versicolor_petal_length)
x_virg, y_virg= ecdf(virginica_petal_length)



# Plot all ECDFs on the same plot
plt.plot(x_set, y_set, marker= '.', linestyle= 'none')
plt.plot(x_vers, y_vers, marker= '.', linestyle= 'none')
plt.plot(x_virg, y_virg, marker= '.', linestyle= 'none')



# Annotate the plot
plt.legend(('setosa', 'versicolor', 'virginica'), loc='lower right')
_ = plt.xlabel('petal length (cm)')
_ = plt.ylabel('ECDF')

# Display the plot
plt.show()


'''
'''


