#' @title Score the FACT-C 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Colorectal Cancer (FACT-C, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-C
#' @templateVar SCOREFUN scoreFACT_C
#' @template templateDetailsAC
#'
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
#'   \item \strong{CCS} - Colorectal Cancer subscale
#'   \item \strong{FACT_C_TOTAL} - FACT-C Total Score (PWB+SWB+EWB+FWB+CCS)
#'   \item \strong{FACT_C_TOI} - FACT-C Trial Outcome Index (PWB+FWB+CCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{CCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-C Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Ward, W.L., Hahn, E.A., Mo, F., Hernandez, L., Tulsky, D.S., & Cella, D.
#' (1999). Reliability and validity of the Functional Assessment of Cancer
#' Therapy-Colorectal (FACT-C) quality of life instrument. \emph{Quality of Life
#' Research}, 8(3), 181-195.
#'
#'
#' @export
#' 
#' @examples
#'\dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_C(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_C(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_C(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_C(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_C(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'CCS', 'FACT_C_TOTAL', 'FACT_C_TOI')])
#' }
scoreFACT_C <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C1", "C2", "C3", "C4", "C5", "C6", "C7"),
      namesRev = cc("C1", "C2", "C5"),
      nameSub = "CCS",
      nameTot = "FACT_C",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
