#' @title Score the FACT-Gastric 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Gastric Cancer (FACT-Gastric, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Gastric
#' @templateVar SCOREFUN scoreFACT_Gastric
#' @template templateDetailsAC
#'
#' @template templateParamsAC
#'
#' @return A data frame with the following scale scores is returned:
#'
#' \itemize{
#'   \item \strong{PWB} - Physical Well-Being subscale
#'   \item \strong{SWB} - Social/Family Well-Being subscale
#'   \item \strong{EWB} - Emotional Well-Being subscale
#'   \item \strong{FWB} - Physical Well-Being subscale
#'   \item \strong{FACTG} - FACT-G Total Score (PWB+SWB+EWB+FWB)
#'   \item \strong{GaCS} - Gastric Cancer subscale
#'   \item \strong{FACT_Gastric_TOTAL} - FACT-Gastric Total Score (PWB+SWB+EWB+FWB+GaCS)
#'   \item \strong{FACT_Gastric_TOI} - FACT-Gastric Trial Outcome Index (PWB+FWB+GaCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{GaCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Gastric Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#' 
#' Eremenco, S., Cashy, J., & Webster, K.  (2003). Linguistic validation of the
#' FACT-Gastric (FACT-Ga) in Japanese and English. \emph{Quality of Life Research},
#' 12(7), 818.
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C2', 'Ga1', 'Ga2', 'HN1', 'Ga6', 'Ga5', 'C1', 
#' 'Ga12', 'Ga4', 'E6', 'Ga10', 'Ga9', 'Ga7', 'Hep8', 'Ga14', 'C5', 
#' 'An2', 'HI12', 'Leu4')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Gastric(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Gastric(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Gastric(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Gastric(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Gastric(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'GaCS', 'FACT_Gastric_TOTAL', 'FACT_Gastric_TOI')])
#' }
scoreFACT_Gastric <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C2", "Ga1", "Ga2", "HN1", "Ga6", "Ga5", "C1", 
                  "Ga12", "Ga4", "E6", "Ga10", "Ga9", "Ga7", "Hep8", "Ga14", "C5", 
                  "An2", "HI12", "Leu4"),
      namesRev = c("C2", "Ga1", "Ga2", "Ga6", "Ga5", "C1", "Ga12", 
                   "Ga4", "Ga10", "Ga9", "Ga7", "Hep8", "Ga14", "C5", "An2", "HI12", 
                   "Leu4"),
      nameSub = "GaCS",
      nameTot = "FACT_Gastric",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}