# Install needed R packages
install.packages('devtools')
install.packages('ggplot2')
install.packages('psych')

# Need devtools to install the in development package from github.
library(devtools)
install_github('dblodgett-usgs/awudsDemo')

library(ggplot2)
library(awudsDemo)
library(psych)

# Show help for awudsDemo Package !!!

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
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE)
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50)
summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50, binwidth=150)
summaryHistogram(awudsData, 'publicSupply', popNorm=TRUE, truncateLower=1)
