library(ggplot2)
library(awudsDemo)
library(psych)
library(rgdal)
library(maptools)
gpclibPermit()
library(plyr)
library(reshape2)

# Get Latest Data from AWUDS: Also here: http://nwis.usgs.gov/awuds/dump/countydata
awudsData<-getAWUDSdump('http://nwis.usgs.gov/awuds/dump/older_files/countydata')
print(names(awudsData))

# Add summary collumns to awudsData data frame.
awudsData<-addSummaryColumns(awudsData)
print(names(awudsData))

?addSummaryColumns

# Calculate some statistics based on AWUDS
summary(awudsData$publicSupply)
fivenum(awudsData$publicSupply)
describe(awudsData$publicSupply)
describe(awudsData)

# Scatter plot of county population vs a water use category.
# Add up all the public supply categories. (source NWC public supply summary category)
# More here: https://github.com/USGS-CIDA/nwc/blob/master/nwc/src/main/webapp/client/nwc/workflows/waterBudget/waterBudgetServices.js
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE)
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50)
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50, binwidth=150)
summaryHistogram(awudsData, 'publicSupply', popNorm=TRUE, truncateLower=1)
