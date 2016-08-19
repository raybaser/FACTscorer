#' @title Score the FACT-B+4
#'
#' @description
#' Scores the Functional Assessment of Cancer Therapy - Breast Cancer plus
#' Lymphedema (FACT-B+4, v4) from item responses.  This questionnaire is the
#' FACT-B (Breast) plus 4 additional items assessing concerns specfic to
#' patients with upper limb lymphedema.  As such, the "Additional Concerns"
#' items yield 2 subscales: the Breast Cancer subscale (BCS) and the Arm
#' subscale.  However, the Arm subscale is not used in the calculation of the
#' Total scores or TOI.
#'
#' @templateVar MEASURE FACT-B+4
#' @templateVar SCOREFUN scoreFACT_Bplus4
#' @template templateDetailsAC
#'
#' @template templateParamsAC
#'
#' @return A data frame with the following scale scores is returned:
#'
#' \describe{
#'   \item{PWB}{Physical Well-Being subscale}
#'   \item{SWB}{Social/Family Well-Being subscale}
#'   \item{EWB}{Emotional Well-Being subscale}
#'   \item{FWB}{Physical Well-Being subscale}
#'   \item{FACTG}{FACT-G Total Score (i.e., PWB+SWB+EWB+FWB)}
#'   \item{BCS}{Breast Cancer subscale}
#'   \item{ARM}{Arm subscale}
#'   \item{FACT_B_TOTAL}{FACT-B Total Score (i.e., PWB+SWB+EWB+FWB+BCS)}
#'   \item{FACT_B_TOI}{FACT-B Trial Outcome Index (e.g., PWB+FWB+BCS)}
#' }
#'
#' @references FACT-B+4 Scoring Guidelines, available at \url{http://www.facit.org}
#'
#' @section NOTE - Recent Scoring Changes:
#' A small change was made to the official scoring instructions for this
#' questionnaire on March 8, 2016.  Previously, item P2 was not scored.  It is
#' now scored as part of BCS.
#'
#' @export
#'
#' @examples
#' \dontshow{
#'
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7',
#'                'B8', 'B9', 'B10','B11', 'B12', 'B13', 'P2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Bplus4(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Bplus4(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Bplus4(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Bplus4(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Bplus4(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' }
scoreFACT_Bplus4 <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                        keepNvalid = FALSE) {
  df_GplusBCS <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "P2"),
      namesRev = c("B1", "B2", "B3", "B5", "B6", "B7", "B8", "P2"),
      nameSub = "BCS",
      nameTot = "FACT_B",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  df_arm <-
    scoreFACT_any(
      df = df,
      id = NULL,
      namesAC = c("B3", "B10", "B11", "B12", "B13"),
      namesRev = c("B3", "B10", "B11", "B12", "B13"),
      nameSub = "ARM",
      nameTot = "FACT_B",
      AConly = TRUE,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  df_scores <- data.frame(df_GplusBCS, df_arm)
  df_scores$B3_rc.1 <- NULL
  return(df_scores)
}

