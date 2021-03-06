#' @title Score the FACT-AntiA 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' AntiA (FACT-AntiA, v4) from item responses.
#' 
#' @templateVar MEASURE FACT-AntiA 
#' @templateVar SCOREFUN scoreFACT_AntiA
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
#'   \item \strong{AntiAS} - AntiA subscale
#'   \item \strong{FACT_AntiA_TOTAL} - FACT-AntiA Total Score (PWB+SWB+EWB+FWB+AntiAS)
#'   \item \strong{FACT_AntiA_TOI} - FACT-AntiA Trial Outcome Index (PWB+FWB+AntiAS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{AntiAS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-AntiA Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HI7', 'HI12', 'AA1', 'AA2', 'AA3', 'AA4', 'AA5', 
#' 'AA6', 'AA7', 'C5', 'AA8', 'BMT13', 'BRM5', 'MS3', 'BRM1', 'Cx6', 
#' 'AA9', 'TH5', 'B5', 'AA10', 'GA1', 'B1', 'O2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_AntiA(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_AntiA(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_AntiA(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_AntiA(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_AntiA(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'AntiAS', 'FACT_AntiA_TOTAL', 'FACT_AntiA_TOI')])
#' }
scoreFACT_AntiA <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5", 
                  "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1", "Cx6", 
                  "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
      namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5", 
                   "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1", "Cx6", 
                   "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
      nameSub = "AntiAS",
      nameTot = "FACT_AntiA",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
