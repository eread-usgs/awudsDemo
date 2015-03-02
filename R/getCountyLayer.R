
#'@title Downloads and returns loaded county spatial layer for plotting
#'
#'@return A sp Spatial Data Frame with all US countiesloaded
#'
#'@import rgdal
#'@import httr 
#'
#'@export
getCountyLayer = function(){
  
  layer_url = 'http://www.sciencebase.gov/catalogMaps/mapping/ows/54f494bde4b02419550d003a?service=wfs&request=GetFeature&outputFormat=SHAPE-ZIP&version=1.0.0&typeName=sb:US_HistCounties_Gen001'
  
  local_temp = tempfile(fileext='.zip') 
  
  GET(layer_url, write_disk(local_temp, overwrite=TRUE))
  
  shp_dir = tempdir()
  unzip(local_temp, exdir=shp_dir)
  
  county_shp_file<-"US_HistCounties_Gen001"
  counties<-readOGR(shp_dir, county_shp_file)
  
  return(counties)
} 