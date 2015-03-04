#'@title Add water use summaries.
#'@description Adds water use summary columns to the awudsData dataframe.
#'
#'@param awudsDAta Dataframe returned (from \link{getAWUDSdump})
#'
#'@return AWUDS data with publicSupply, domestic, irrigation, thermoelectricPower, livestockAndAquaculture, industrial, and mining added
#'
#'@examples \dontrun{
#'  awudsData<-getAWUDSdump('http://nwis.usgs.gov/awuds/dump/countydata')
#'  awudsData<-addSummaryColumns(awudsData)
#' }
#'@export
addSummaryColumns<-function(awudsData)
{
  awudsData$publicSupply <- apply(awudsData[,c('PS.WGWFr','PS.WGWSa','PS.WSWFr','PS.WSWSa')],1, sum, na.rm=TRUE)
  
  awudsData$domestic <- apply(awudsData[,c('DO.WGWFr','DO.WGWSa','DO.WSWFr','DO.WSWSa')],1, sum, na.rm=TRUE)
  
  awudsData$irrigation <- apply(awudsData[,c('IT.WGWFr','IT.WGWSa','IT.WSWFr','IT.WSWSa')],1, sum, na.rm=TRUE)

  
  awudsData$thermoelectricPower <- apply(awudsData[,c('PF.WGWFr','PF.WGWSa','PF.WSWFr','PF.WSWSa','PG.WGWFr',
                                                      'PG.WGWSa','PG.WSWFr','PG.WSWSa','PN.WGWFr','PN.WGWSa',
                                                      'PN.WSWFr','PN.WSWSa','PO.WGWFr','PO.WGWSa','PO.WSWFr',
                                                      'PO.WSWSa','PC.WGWFr','PC.WGWSa','PC.WSWFr','PC.WSWSa')],1, sum, na.rm=TRUE)

  
  awudsData$livestockAndAquaculture <- apply(awudsData[,c('LS.WGWFr','LS.WGWSa','LS.WSWFr','LS.WSWSa','LI.WGWFr',
                                                          'LI.WSWFr','LA.WGWFr','LA.WGWSa','LA.WSWFr','LA.WSWSa',
                                                          'AQ.WGWFr','AQ.WGWSa','AQ.WSWFr','AQ.WSWSa')],1, sum, na.rm=TRUE)

  
  awudsData$industrial <- apply(awudsData[,c('IN.WGWFr','IN.WGWSa','IN.WSWFr','IN.WSWSa')],1, sum, na.rm=TRUE)

  
  awudsData$mining <- apply(awudsData[,c('MI.WGWFr','MI.WGWSa','MI.WSWFr','MI.WSWSa')],1, sum, na.rm=TRUE)

  return(awudsData)
}