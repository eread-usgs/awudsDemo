#'@title Load AWUDS data into a dataframe
#'@description Given an AWUDS CSV dump file, returns a dataframe containing all 
#'collumns of data optionally converted to numerical data types. 
#'
#'
#'@param dataLocation A local or network path to the data file.
#'@param convertToNumerical (optional) TRUE (default) or FALSE to try to convert non numerical 
#'types (typically factors) to numerical.
#'
#'@return Data frame of AWUDS data.
#'
#'@examples \dontrun{
#'  awudsData<-getAWUDSdump('http://nwis.usgs.gov/awuds/dump/countydata')
#' }
#'@export
getAWUDSdump<-function(dataLocation, convertToNumerical=TRUE)
{
  # Reads data using default setting and deal with the consequences.
  awuds_data<-read.delim(dataLocation, na.strings="--")
  if(convertToNumerical)
  {
    # Pull out a subset of the names that are the actual data.
    awuds_data_names<-unlist(names(awuds_data))[8:length(names(awuds_data))]
    # Search for non-numeric imported data that should be numeric. All collumns 8 on should be numerical.
    # Yeah, I know this could be a function run through apply.
    for (i in 1:(length(awuds_data_names))){
      if(!is.numeric(awuds_data[awuds_data_names[i]][[1]])){
        try({awuds_data[awuds_data_names[i]][[1]]<-as.numeric(awuds_data[awuds_data_names[i]][[1]])
            print(paste('changed', awuds_data_names[i], 'to numerical.'))})
      }
    }
  }
  names(awuds_data)[5]<-"FIPS"
  return(awuds_data)
}