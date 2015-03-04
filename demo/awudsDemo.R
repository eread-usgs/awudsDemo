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
njAWUDS<-subset(awudsData, USSTATEALPHACODE=='NJ' & YEAR == 2005)

# Bar chart of water use category by county
x=barplot(njAWUDS$irrigation,  ylab="Irrigation by county",xaxt="n")
labs <- njAWUDS$COUNTYNAME
text(cex=1, x=x+0.25, y=-1.25, labs, xpd=TRUE, srt=45, pos=2)

# Box and whiskers of multiple water use categories by state
boxplot(mining~USSTATEALPHACODE, awudsData, ylab='Mining', xlab='State')
boxplot(publicSupply~USSTATEALPHACODE, awudsData, ylab='Public Supply', xlab='State')
boxplot(domestic~USSTATEALPHACODE, awudsData, ylab='Domestic', xlab='State')
boxplot(irrigation~USSTATEALPHACODE, awudsData, ylab="Irrigation", xlab='State')
boxplot(thermoelectricPower~USSTATEALPHACODE, awudsData, ylab='Thermoelectric', xlab='State')

# Pie chart of water use categories for a given county
i=5
pie(unlist(njAWUDS[i,c("publicSupply", "domestic", "irrigation", "thermoelectricPower", "livestockAndAquaculture", "industrial" )]), main = njAWUDS[i,'COUNTYNAME'])


# Get Spatial Data from ScienceBase and load it up.
# Pulling data from ScienceBase
# Original source of shapefile is here: http://publications.newberry.org/ahcbp/downloads/

counties<-getCountyLayer()

counties@data$id <- rownames(counties@data)
summary(counties)
proj4string(counties) <- CRS("+init=epsg:4326") # The native projection is epsg:4326, this will warn.
counties <- spTransform(counties, CRS("+init=epsg:3857")) # Change to web mercator for fun.
summary(counties)
njCounties <- counties[counties$STATE_TERR == "New Jersey",]
summary(njCounties)
njCounties@data$id <- rownames(njCounties@data)
njCountiesMap<-fortify(njCounties,region="id")
njCountiesMap <- join(njCountiesMap, njCounties@data, by="id")
# This join doesn't appear to be working right.
njCountiesAWUDS <- join(njCountiesMap, awudsData, by="FIPS", match="all")

# This works, but it's kinda messed up, I need help.
map<-ggplot(njCountiesAWUDS) + 
  aes(long, lat, group=group, fill=TP.TotPop) + 
  geom_polygon() + geom_path(color="black") + 
  coord_equal() + scale_fill_gradient(low="green",high="darkgreen")
map
map + scale_fill_gradient(low = "white", high = "black")
# Choropleth of counties colored by water use category
map<-ggplot(njCountiesAWUDS) + 
  aes(long, lat, group=group, fill=publicSupply) + 
  geom_polygon() + geom_path(color="black") + 
  coord_equal() + scale_fill_gradient(low="green",high="darkgreen")
map

# Tabular data view

# Map some raw and derived AWUDS data

# Show how this code is being shared and can be contributed to.