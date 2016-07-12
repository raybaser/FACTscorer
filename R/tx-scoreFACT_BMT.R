#' @title Score the FACT-BMT 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Bone Marrow Transplant (FACT-BMT, v4) from item responses.
#' 
#' @templateVar MEASURE FACT-BMT
#' @templateVar SCOREFUN scoreFACT_BMT
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
#'   \item \strong{BMTS} - Bone Marrow Transplant subscale
#'   \item \strong{FACT_BMT_TOTAL} - FACT-BMT Total Score (PWB+SWB+EWB+FWB+BMTS)
#'   \item \strong{FACT_BMT_TOI} - FACT-BMT Trial Outcome Index (PWB+FWB+BMTS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{BMTS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-BMT Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('BMT1', 'BMT2', 'BMT3', 'BMT4', 'C6', 'C7', 'BMT5', 
#' 'BMT6', 'BL4', 'BMT8')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_BMT(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_BMT(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_BMT(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_BMT(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_BMT(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'BMTS', 'FACT_BMT_TOTAL', 'FACT_BMT_TOI')])
#' }
scoreFACT_BMT <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("BMT1", "BMT2", "BMT3", "BMT4", "C6", "C7", "BMT5", 
                  "BMT6", "BL4", "BMT8"),
      namesRev = c("BMT1", "BMT2", "BMT3", "BMT4", "BMT6"),
      nameSub = "BMTS",
      nameTot = "FACT_BMT",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}