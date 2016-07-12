#' @title Score the FACT-CNS 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Central Nervous System (FACT-CNS, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-CNS
#' @templateVar SCOREFUN scoreFACT_CNS
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
#'   \item \strong{CNSS} - Central Nervous System subscale
#'   \item \strong{FACT_CNS_TOTAL} - FACT-CNS Total Score (PWB+SWB+EWB+FWB+CNSS)
#'   \item \strong{FACT_CNS_TOI} - FACT-CNS Trial Outcome Index (PWB+FWB+CNSS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{CNSS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-CNS Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('An10', 'Br3', 'CNS1', 'CNS2', 'Br6', 'Br9', 
#' 'CNS4', 'CNS5', 'CNS6', 'CNS7', 'BL1', 'C3')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_CNS(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_CNS(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_CNS(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_CNS(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_CNS(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'CNSS', 'FACT_CNS_TOTAL', 'FACT_CNS_TOI')])
#' }
scoreFACT_CNS <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("An10", "Br3", "CNS1", "CNS2", "Br6", "Br9", 
                  "CNS4", "CNS5", "CNS6", "CNS7", "BL1", "C3"),
      namesRev = c("An10", "Br6", "Br9", "CNS6", "CNS7", "BL1"),
      nameSub = "CNSS",
      nameTot = "FACT_CNS",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
