#' @title Score the FACT-V 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Vulvar Cancer (FACT-V, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-V
#' @templateVar SCOREFUN scoreFACT_V
#' @template templateDetailsAC
#'
#'
#' @template templateParamsAC
#'
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
#'   \item \strong{VCS} - Vulvar Cancer subscale
#'   \item \strong{FACT_V_TOTAL} - FACT-V Total Score (PWB+SWB+EWB+FWB+VCS)
#'   \item \strong{FACT_V_TOI} - FACT-V Trial Outcome Index (PWB+FWB+VCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{VCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-V Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Janda, M., Obermair, A., Cella, D., Crandon, A.J., & Trimmel, M. (2004).
#' Vulvar cancer patients' quality of life: A qualitative assessment.
#' \emph{International Journal of Gynecological Cancer}, 14, 875-881.
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('V1', 'V2', 'Cx3', 'V3', 'Cx4', 'V4', 'Cx5', 
#' 'BL4', 'C7', 'Cx6', 'C6', 'BL1', 'V5', 'Cx7', 'V6', 'V7', 'V8', 
#' 'V9', 'HN1')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_V(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_V(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_V(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_V(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_V(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'VCS', 'FACT_V_TOTAL', 'FACT_V_TOI')])
#' }
scoreFACT_V <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("V1", "V2", "Cx3", "V3", "Cx4", "V4", "Cx5", 
                  "BL4", "C7", "Cx6", "C6", "BL1", "V5", "Cx7", "V6", "V7", "V8", 
                  "V9", "HN1"),
      namesRev = c("V1", "V2", "Cx3", "V3", "Cx4", "V4", "Cx5", 
                   "Cx6", "BL1", "V5", "Cx7", "V6", "V7", "V8", "V9"),
      nameSub = "VCS",
      nameTot = "FACT_V",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}