#' @title Score the FACT-O 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Ovarian Cancer (FACT-O, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-O
#' @templateVar SCOREFUN scoreFACT_O
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
#'   \item \strong{OCS} - Ovarian Cancer subscale
#'   \item \strong{FACT_O_TOTAL} - FACT-O Total Score (PWB+SWB+EWB+FWB+OCS)
#'   \item \strong{FACT_O_TOI} - FACT-O Trial Outcome Index (PWB+FWB+OCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{OCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-O Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Basen-Enquist, K., Bodurka-Bevers, D., Fitzgerald, M.A., Webster, K., Cella,
#' D., Hu, S., & Gershenson D.M. (2001). Reliability and validity of the
#' Functional Assessment of Cancer Therapy-Ovarian (FACT-O). \emph{Journal of Clinical
#' Oncology}, 19(6), 1809-1817.
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('O1', 'C2', 'C3', 'O2', 'B5', 'C6', 'C7', 'BMT5', 
#' 'B9', 'O3', 'BL4')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_O(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_O(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_O(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_O(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_O(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'OCS', 'FACT_O_TOTAL', 'FACT_O_TOI')])
#' }
scoreFACT_O <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("O1", "C2", "C3", "O2", "B5", "C6", "C7", "BMT5", 
                  "B9", "O3", "BL4"),
      namesRev = c("O1", "C2", "O2", "B5", "O3"),
      nameSub = "OCS",
      nameTot = "FACT_O",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
