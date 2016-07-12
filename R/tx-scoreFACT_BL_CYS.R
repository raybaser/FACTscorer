#' @title Score the FACT-BL-CYS
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' BL-CYS (FACT-BL-CYS, v4) from item responses.
#'
#' @templateVar MEASURE FACT-BL-CYS
#' @templateVar SCOREFUN scoreFACT_BL_CYS
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
#'   \item \strong{BL_CYS} - BL-CYS subscale
#'   \item \strong{FACT_BL_CYS_TOTAL} - FACT-BL-CYS Total Score (PWB+SWB+EWB+FWB+BL_CYS)
#'   \item \strong{FACT_BL_CYS_TOI} - FACT-BL-CYS Trial Outcome Index (PWB+FWB+BL_CYS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{BL_CYS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-BL-CYS Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#'
#' @export
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C2', 'C3', 'C4', 'C6', 'C7', 'BL1', 'ITU7',
#' 'ITU6', 'C9', 'ITU3', 'ITU4', 'ITU5', 'ITU1', 'VC1', 'ITU2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_BL_CYS(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_BL_CYS(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_BL_CYS(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_BL_CYS(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_BL_CYS(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'BL_CYS', 'FACT_BL_CYS_TOTAL', 'FACT_BL_CYS_TOI')])
#' }
scoreFACT_BL_CYS <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C2", "C3", "C4", "C6", "C7", "BL1", "ITU7",
                  "ITU6", "C9", "ITU3", "ITU4", "ITU5", "ITU1", "VC1", "ITU2"),
      namesRev = c("C2", "BL1", "ITU7", "ITU6", "C9", "ITU3", "ITU4",
                   "ITU5", "ITU2"),
      nameSub = "BL_CYS",
      nameTot = "FACT_BL_CYS",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
