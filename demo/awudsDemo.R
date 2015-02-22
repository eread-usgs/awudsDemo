library(ggplot2)
library(awudsDemo)
library(psych)

# Get Latest Data from AWUDS: Also here: http://nwis.usgs.gov/awuds/dump/countydata
awudsData<-getAWUDSdump('/Users/dblodgett/Documents/Projects/WaterSmart/4_code/R_NetCDF-DSG/AWUDS/wu_countydata.txt')
print(names(awudsData))

# Add summary collumns to awudsData data frame.
awudsData<-addSummaryColumns(awudsData)
print(names(awudsData))

# Scatter plot of county population vs a water use category.
# Add up all the public supply categories. (source NWC public supply summary category)
# More here: https://github.com/USGS-CIDA/nwc/blob/master/nwc/src/main/webapp/client/nwc/workflows/waterBudget/waterBudgetServices.js
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50, binwidth=150)
summaryHistogram(awudsData, 'publicSupply', popNorm=TRUE, truncateLower=1)

# Calculate some statistics based on AWUDS
summary(awudsData$publicSupply)
fivenum(awudsData$publicSupply)
describe(awudsData$publicSupply)
describe(awudsData) # too much, but worth demonstrating?

# Load subset of data for New Jersey
njAWUDS<-subset(awudsData, awudsData$USSTATEALPHACODE=='NJ')

# Bar chart of water use category by county

# Box and whiskers of multiple water use categories for all counties in a state.

# Pie chart of water use categories for a given county

# Get Spatial Data from ScienceBase

# Choropleth of counties colored by water use category

# Tabular data view

# Map some raw and derived AWUDS data

# Show how this code is being shared and can be contributed to.