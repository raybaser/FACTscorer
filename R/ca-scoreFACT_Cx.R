#' @title Score the FACT-Cx 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Cervix Cancer (FACT-Cx, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Cx
#' @templateVar SCOREFUN scoreFACT_Cx
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
#'   \item \strong{CxCS} - Cervix Cancer subscale
#'   \item \strong{FACT_Cx_TOTAL} - FACT-Cx Total Score (PWB+SWB+EWB+FWB+CxCS)
#'   \item \strong{FACT_Cx_TOI} - FACT-Cx Trial Outcome Index (PWB+FWB+CxCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{CxCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Cx Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('Cx1', 'Cx2', 'Cx3', 'B4', 'Cx4', 'BMT7', 'Cx5', 
#' 'BL4', 'C7', 'Cx6', 'C6', 'BL1', 'BL3', 'Cx7', 'HN1')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Cx(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Cx(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Cx(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Cx(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Cx(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'CxCS', 'FACT_Cx_TOTAL', 'FACT_Cx_TOI')])
#' }
scoreFACT_Cx <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("Cx1", "Cx2", "Cx3", "B4", "Cx4", "BMT7", "Cx5", 
                  "BL4", "C7", "Cx6", "C6", "BL1", "BL3", "Cx7", "HN1"),
      namesRev = c("Cx1", "Cx2", "Cx3", "Cx4", "BMT7", "Cx5", "Cx6", 
                   "BL1", "BL3", "Cx7"),
      nameSub = "CxCS",
      nameTot = "FACT_Cx",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}