#' @title Score the FACT-Th18 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Thrombo-Cytopenia (FACT-Th18, v4) from item responses.
#' 
#' @templateVar MEASURE FACT-Th18
#' @templateVar SCOREFUN scoreFACT_Th18
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
#'   \item \strong{ThS18} - Thrombo-Cytopenia subscale
#'   \item \strong{FACT_Th18_TOTAL} - FACT-Th18 Total Score (PWB+SWB+EWB+FWB+ThS18)
#'   \item \strong{FACT_Th18_TOI} - FACT-Th18 Trial Outcome Index (PWB+FWB+ThS18)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{ThS18}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Th18 Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('An5', 'An7', 'Th1', 'Th2', 'Th3', 'Th4', 'Th5', 
#' 'Th6', 'Th7', 'Th8', 'Th9', 'HI7', 'Th10', 'Th11', 'Th12', 'Th13', 
#' 'Th14', 'Th15')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Th18(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Th18(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Th18(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Th18(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Th18(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'Th18', 'FACT_Th18_TOTAL', 'FACT_Th18_TOI')])
#' }
scoreFACT_Th18 <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("An5", "An7", "Th1", "Th2", "Th3", "Th4", "Th5", 
                  "Th6", "Th7", "Th8", "Th9", "HI7", "Th10", "Th11", "Th12", "Th13", 
                  "Th14", "Th15"),
      namesRev = c("Th1", "Th2", "Th3", "Th4", "Th5", "Th6", "Th7", 
                   "Th8", "Th9", "HI7", "Th10", "Th11", "Th12", "Th13", "Th14", "Th15"),
      nameSub = "Th18",
      nameTot = "FACT_Th18",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
