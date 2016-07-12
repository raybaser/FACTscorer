#' @title Score the FACT-P
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Prostate Cancer (FACT-P, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-P
#' @templateVar SCOREFUN scoreFACT_P
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
#'   \item \strong{PCS} - Prostate Cancer subscale
#'   \item \strong{FACT_P_TOTAL} - FACT-P Total Score (PWB+SWB+EWB+FWB+PCS)
#'   \item \strong{FACT_P_TOI} - FACT-P Trial Outcome Index (PWB+FWB+PCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{PCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-P Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Esper, P., Mo, F., Chodak, G., Sinner, M., Cella, D., & Pienta, K.J. (1997).
#' Measuring quality of life in men with prostate cancer using the Functional
#' Assessment of Cancer Therapy-Prostate (FACT-P) instrument. \emph{Urology}, 50(6),
#' 920-928.
#'
#'
#'
#' @export
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C2', 'C6', 'P1', 'P2', 'P3', 'P4', 'P5', 'P6',
#' 'P7', 'BL2', 'P8', 'BL5')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_P(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_P(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_P(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_P(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_P(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'PCS', 'FACT_P_TOTAL', 'FACT_P_TOI')])
#' }
scoreFACT_P <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C2", "C6", "P1", "P2", "P3", "P4", "P5", "P6",
                  "P7", "BL2", "P8", "BL5"),
      namesRev = c("C2", "P1", "P2", "P3", "P6", "P7", "BL2", "P8"),
      nameSub = "PCS",
      nameTot = "FACT_P",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
