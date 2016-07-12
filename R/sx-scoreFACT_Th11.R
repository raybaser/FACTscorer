#' @title Score the FACT-Th11 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Thrombo-Cytopenia (FACT-Th11, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Th11
#' @templateVar SCOREFUN scoreFACT_Th11
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
#'   \item \strong{ThS11} - Thrombo-Cytopenia subscale
#'   \item \strong{FACT_Th11_TOTAL} - FACT-Th11 Total Score (PWB+SWB+EWB+FWB+ThS11)
#'   \item \strong{FACT_Th11_TOI} - FACT-Th11 Trial Outcome Index (PWB+FWB+ThS11)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{ThS11}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Th Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('An5', 'An7', 'Th1', 'Th2', 'Th3', 'Th5', 'Th7', 
#' 'Th8', 'Th10', 'Th12', 'Th13')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Th11(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Th11(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Th11(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Th11(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Th11(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'ThS11', 'FACT_Th11_TOTAL', 'FACT_Th11_TOI')])
#' }
scoreFACT_Th11 <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("An5", "An7", "Th1", "Th2", "Th3", "Th5", "Th7", 
                  "Th8", "Th10", "Th12", "Th13"),
      namesRev = c("Th1", "Th2", "Th3", "Th5", "Th7", "Th8", "Th10", 
                   "Th12", "Th13"),
      nameSub = "ThS11",
      nameTot = "FACT_Th11",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
