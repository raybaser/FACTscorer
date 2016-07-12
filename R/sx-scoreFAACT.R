#' @title Score the FAACT 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Functional Assessment of Anorexia Cachexia Therapy (FAACT, v4) from item responses.
#' 
#' @templateVar MEASURE FAACT
#' @templateVar SCOREFUN scoreFAACT
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
#'   \item \strong{ACS} - Anorexia Cachexia subscale
#'   \item \strong{FAACT_TOTAL} - FAACT Total Score (PWB+SWB+EWB+FWB+ACS)
#'   \item \strong{FAACT_TOI} - FAACT Trial Outcome Index (PWB+FWB+ACS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{ACS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FAACT Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C6', 'ACT1', 'ACT2', 'ACT3', 'ACT4', 'ACT6', 
#' 'ACT7', 'ACT9', 'O2', 'ACT10', 'ACT11', 'ACT13')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFAACT(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFAACT(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFAACT(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFAACT(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFAACT(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'ACS', 'FAACT_TOTAL', 'FAACT_TOI')])
#' }
scoreFAACT <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C6", "ACT1", "ACT2", "ACT3", "ACT4", "ACT6", 
                  "ACT7", "ACT9", "O2", "ACT10", "ACT11", "ACT13"),
      namesRev = c("ACT2", "ACT3", "ACT4", "ACT6", "ACT7", "ACT9", 
                   "O2", "ACT10", "ACT11"),
      nameSub = "ACS",
      nameTot = "FAACT",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}