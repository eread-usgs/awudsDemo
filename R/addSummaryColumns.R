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
  awudsData$publicSupply <- sum(awudsData$PS.WGWFr, awudsData$PS.WGWSa, awudsData$PS.WSWFr, awudsData$PS.WSWSa, na.rm=TRUE)
  
  awudsData$domestic <- sum(awudsData$DO.WGWFr, 
                            awudsData$DO.WGWSa, 
                            awudsData$DO.WSWFr,
                            awudsData$DO.WSWSa, na.rm=TRUE)
  
  awudsData$irrigation <- sum(awudsData$IT.WGWFr,
                              awudsData$IT.WGWSa,
                              awudsData$IT.WSWFr,
                              awudsData$IT.WSWSa, na.rm=TRUE)
  
  awudsData$thermoelectricPower <- sum(awudsData$PF.WGWFr, 
                                       awudsData$PF.WGWSa,
                                       awudsData$PF.WSWFr,
                                       awudsData$PF.WSWSa,
                                       awudsData$PG.WGWFr,
                                       awudsData$PG.WGWSa,
                                       awudsData$PG.WSWFr,
                                       awudsData$PG.WSWSa,
                                       awudsData$PN.WGWFr,
                                       awudsData$PN.WGWSa,
                                       awudsData$PN.WSWFr,
                                       awudsData$PN.WSWSa,
                                       awudsData$PO.WGWFr,
                                       awudsData$PO.WGWSa,
                                       awudsData$PO.WSWFr,
                                       awudsData$PO.WSWSa,
                                       awudsData$PC.WGWFr,
                                       awudsData$PC.WGWSa,
                                       awudsData$PC.WSWFr,
                                       awudsData$PC.WSWSa, na.rm=TRUE)
  
  awudsData$livestockAndAquaculture <- sum(awudsData$LS.WGWFr,
                                           awudsData$LS.WGWSa,
                                           awudsData$LS.WSWFr,
                                           awudsData$LS.WSWSa,
                                           awudsData$LI.WGWFr,
                                           awudsData$LI.WSWFr,
                                           awudsData$LA.WGWFr,
                                           awudsData$LA.WGWSa,
                                           awudsData$LA.WSWFr,
                                           awudsData$LA.WSWSa,
                                           awudsData$AQ.WGWFr,
                                           awudsData$AQ.WGWSa,
                                           awudsData$AQ.WSWFr,
                                           awudsData$AQ.WSWSa, na.rm=TRUE)
  
  awudsData$industrial <- sum(awudsData$IN.WGWFr,
                              awudsData$IN.WGWSa, 
                              awudsData$IN.WSWFr,
                              awudsData$IN.WSWSa, na.rm=TRUE)
  
  awudsData$mining <- sum(awudsData$MI.WGWFr,
                          awudsData$MI.WGWSa, 
                          awudsData$MI.WSWFr,
                          awudsData$MI.WSWSa, na.rm=TRUE)
  return(awudsData)
}