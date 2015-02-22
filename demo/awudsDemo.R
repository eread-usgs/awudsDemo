library(ggplot2)
library(awudsDemo)
library(psych)
library(rgdal)
library(maptools)
gpclibPermit()
library(plyr)

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

# Get Spatial Data from ScienceBase and load it up.
# Will pull locally for now, can pull from remote easily.
# Original source of shapefile is here: http://publications.newberry.org/ahcbp/downloads/
county_shp_folder<-"/Users/dblodgett/Documents/Projects/WaterSmart/4_code/R_NetCDF-DSG/AWUDS/US_AtlasHCB_Counties_Gen001/US_HistCounties_Gen001_Shapefile/"
county_shp_file<-"US_HistCounties_Gen001"
counties<-readOGR(county_shp_folder, county_shp_file)
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