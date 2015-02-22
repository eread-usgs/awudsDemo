library(ggplot2)

# Get Latest Data from AWUDS: Also here: http://nwis.usgs.gov/awuds/dump/countydata
awudsData<-getAWUDSdump('/Users/dblodgett/Documents/Projects/WaterSmart/4_code/R_NetCDF-DSG/AWUDS/wu_countydata.txt')

# Scatter plot of county population vs a water use category.
# Add up all the public supply categories. (source NWC public supply summary category)
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50, binwidth=150)
summaryHistogram(awudsData, 'publicSupply', popNorm=TRUE, truncateLower=1)

# Calculate some statistics based on AWUDS

# Load subset of data for New Jersey

# Bar chart of water use category by county

# Box and whiskers of multiple water use categories for all counties in a state.

# Pie chart of water use categories for a given county

# Get Spatial Data from ScienceBase

# Choropleth of counties colored by water use category

# Tabular data view

# Map some raw and derived AWUDS data

# Show how this code is being shared and can be contributed to.