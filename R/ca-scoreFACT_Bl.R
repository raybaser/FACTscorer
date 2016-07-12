#' @title Score the FACT-Bl
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Bladder Cancer (FACT-Bl, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-Bl
#' @templateVar SCOREFUN scoreFACT_Bl
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
#'   \item \strong{BlCS} - Bladder Cancer subscale
#'   \item \strong{FACT_Bl_TOTAL} - FACT-Bl Total Score (PWB+SWB+EWB+FWB+BlCS)
#'   \item \strong{FACT_Bl_TOI} - FACT-Bl Trial Outcome Index (PWB+FWB+BlCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{BlCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Bl Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('BL1', 'C2', 'C3', 'BL2', 'C5', 'C6', 'C7', 'BL3', 'BL4', 'BL5', 'C8', 'C9')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Bl(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Bl(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Bl(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Bl(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Bl(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'BlCS', 'FACT_Bl_TOTAL', 'FACT_Bl_TOI')])
#' }
scoreFACT_Bl <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("BL1", "C2", "C3", "BL2", "C5", "C6", "C7", "BL3",
                   "BL4", "BL5", "C8", "C9"),
      namesRev = c("BL1", "C2", "BL2", "C5", "BL3", "C8", "C9"),
      nameSub = "BlCS",
      nameTot = "FACT_Bl",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}