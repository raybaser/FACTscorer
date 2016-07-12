#' @title Score the FACT-NP 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Nasopharyngeal Cancer (FACT-NP, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-NP
#' @templateVar SCOREFUN scoreFACT_NP
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
#'   \item \strong{NPS} - Nasopharyngeal Cancer subscale
#'   \item \strong{FACT_NP_TOTAL} - FACT-NP Total Score (PWB+SWB+EWB+FWB+NPS)
#'   \item \strong{FACT_NP_TOI} - FACT-NP Trial Outcome Index (PWB+FWB+NPS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{NPS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-NP Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c("HN1", "HN2", "HN4", "HN5", "HN7", "HN6", "HN10", 
#' "HN11", "HN12", "NP1", "NP2", "NTX6", "NP3", "NP4", "NP5", "NP6")
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_NP(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_NP(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_NP(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_NP(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_NP(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'NPS', 'FACT_NP_TOTAL', 'FACT_NP_TOI')])
#' }
scoreFACT_NP <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HN1", "HN2", "HN4", "HN5", "HN7", "HN6", "HN10", 
                  "HN11", "HN12", "NP1", "NP2", "NTX6", "NP3", "NP4", "NP5", "NP6"),
      namesRev = c("HN2", "HN6", "HN12", "NP1", "NP2", "NTX6", "NP3", 
                   "NP4", "NP6"),
      nameSub = "NPS",
      nameTot = "FACT_NP",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
