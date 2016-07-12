#' @title Score the FACT-E 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Esophagus Cancer (FACT-E, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-E
#' @templateVar SCOREFUN scoreFACT_E
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
#'   \item \strong{ECS} - Esophagus Cancer subscale
#'   \item \strong{FACT_E_TOTAL} - FACT-E Total Score (PWB+SWB+EWB+FWB+ECS)
#'   \item \strong{FACT_E_TOI} - FACT-E Trial Outcome Index (PWB+FWB+ECS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{ECS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-E Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HN1', 'HN2', 'HN3', 'HN4', 'HN5', 'HN10', 'HN7', 
#' 'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'C6', 'E7', 'ACT11', 'C2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_E(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_E(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_E(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_E(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_E(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'ECS', 'FACT_E_TOTAL', 'FACT_E_TOI')])
#' }
scoreFACT_E <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HN1", "HN2", "HN3", "HN4", "HN5", "HN10", "HN7", 
                  "E1", "E2", "E3", "E4", "E5", "E6", "C6", "E7", "ACT11", "C2"),
      namesRev = c("HN2", "HN3", "E1", "E2", "E3", "E4", "E5", "E7", 
                   "ACT11", "C2"),
      nameSub = "ECS",
      nameTot = "FACT_E",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
