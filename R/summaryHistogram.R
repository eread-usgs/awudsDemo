#'@title Categoriy Summary Historgram
#'@description Generates a historgram of a summary category for demonstration purposes.
#'
#'@param awudsDAta Dataframe returned (from \link{getAWUDSdump})
#'@param summaryCategroy A category to summarize. Only publicSupply has been implemented so far.
#'@param popNorm (optional) TRUE of FALSE (default) normalizes to population.
#'@param truncateLower (optional) (0 default) Truncates the data as it will be plotted (after normalization) to some lower bound.
#'@param binwidth (optional) (range/30 default) Passed directly to plotting function to set binwidth.
#'
#'@import ggplot2
#'
#'@return ggplot histogram
#'
#'@examples \dontrun{
#'  summaryHistogram(awudsData, 'publicSupply', popNorm=FALSE, truncateLower=50, binwidth=150)
#'  summaryHistogram(awudsData, 'publicSupply', popNorm=TRUE, truncateLower=1)
#' }
#'@export
summaryHistogram<-function(awudsData, summaryCategory, popNorm=FALSE, truncateLower=0, binwidth=NULL)
{
  # !!! The addSummaryColumns function was written after this function. It needs to be run first. 
  # !!! For the sake of demonstration, this should be OK but this function could be extended to work for any
  # !!! in the AWUDS data from. The way this is written is totally wrong given that concept.
  if(grepl('publicSupply',summaryCategory))
  {
    if(popNorm)
    {
      # Normalize to population
      awudsData$publicSupply<-awudsData$publicSupply/awudsData$TP.TotPop
    }
    if(truncateLower>0)
    {
      # truncate and plot
      truncAWUDS<-subset(awudsData, awudsData$publicSupply>truncateLower)
      ggplot(truncAWUDS, aes(x=publicSupply)) + geom_histogram(binwidth=binwidth)
    }
    else
    {
      # plot
      ggplot(awudsData, aes(x=publicSupply)) + geom_histogram(binwidth=binwidth)
    }
  }
  else stop('Only publicSupply summary for this example.')
}