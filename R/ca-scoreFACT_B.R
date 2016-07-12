#' @title Score the FACT-B
#'
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Breast Cancer (FACT-B, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-B
#' @template templateDetailsB
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
#'   \item \strong{BCS} - Breast Cancer subscale
#'   \item \strong{FACT_B_TOTAL} - FACT-B Total Score (PWB+SWB+EWB+FWB+BCS)
#'   \item \strong{FACT_B_TOI} - FACT-B Trial Outcome Index (PWB+FWB+BCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{BCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-B Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Brady, M.J., Cella D.F., Mo, F., Bonomi, A.E., Tulsky, D.S., Lloyd, S.R.,
#' Deasy, S., Cobleigh M., & Shiomoto, G. (1997). Reliability and validity of
#' the Functional Assessment of Cancer Therapy-Breast (FACT-B) quality of life
#' instrument. emph{Journal of Clinical Oncology}, 15, 974-986.
#'
#'
#' @export
#'
#' @examples
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'P2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_B(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_B(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_B(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_B(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_B(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'BCS', 'FACT_B_TOTAL', 'FACT_B_TOI')])
scoreFACT_B <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                        keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC  = c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "P2"),
      namesRev = c("B1", "B2", "B3", "B5", "B6", "B7", "B8", "P2"),
      nameSub = "BCS",
      nameTot = "FACT_B",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )

  return(df_scores)
}
