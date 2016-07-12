#' @title Score the FACT-MM 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Multiple Myeloma (FACT-MM, v4) from item responses.
#' 
#' @templateVar MEASURE FACT-MM
#' @templateVar SCOREFUN scoreFACT_MM
#' @template templateDetailsAC
#'
#'
#' @template templateParamsAC
#'
#'
#' @return A data frame with the following scale scores is returned:
#'
#' \itemize{
#'   \item \strong{PWB} - Physical Well-Being subscale
#'   \item \strong{SWB} - Social/Family Well-Being subscale
#'   \item \strong{EWB} - Emotional Well-Being subscale
#'   \item \strong{FWB} - Physical Well-Being subscale
#'   \item \strong{FACTG} - FACT-G Total Score (PWB+SWB+EWB+FWB)
#'   \item \strong{MMS} - Multiple Myeloma subscale
#'   \item \strong{FACT_MM_TOTAL} - FACT-MM Total Score (PWB+SWB+EWB+FWB+MMS)
#'   \item \strong{FACT_MM_TOI} - FACT-MM Trial Outcome Index (PWB+FWB+MMS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{MMS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-MM Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('P2', 'HI12', 'BMT6', 'HI8', 'N3', 'LEU3', 'LEU4', 
#' 'LEU6', 'BRM9', 'BP1', 'An14', 'MM1', 'HI7', 'ES10')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_MM(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_MM(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_MM(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_MM(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_MM(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'MMS', 'FACT_MM_TOTAL', 'FACT_MM_TOI')])
#' }
scoreFACT_MM <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("P2", "HI12", "BMT6", "HI8", "N3", "LEU3", "LEU4", 
                   "LEU6", "BRM9", "BP1", "An14", "MM1", "HI7", "ES10"),
      namesRev = c("P2", "HI12", "BMT6", "HI8", "N3", "LEU3", "LEU4", 
                   "LEU6", "BRM9", "BP1", "An14", "MM1", "HI7", "ES10"),
      nameSub = "MMS",
      nameTot = "FACT_MM",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
