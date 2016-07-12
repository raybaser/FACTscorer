#' @title Score the FACIT-D 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Chronic Illness Therapy - 
#' Diarrhea (FACIT-D, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACIT-D
#' @templateVar SCOREFUN scoreFACIT_D
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
#'   \item \strong{ADS} - Diarrhea subscale
#'   \item \strong{FACIT_D_TOTAL} - FACIT-D Total Score (PWB+SWB+EWB+FWB+ADS)
#'   \item \strong{FACIT_D_TOI} - FACIT-D Trial Outcome Index (PWB+FWB+ADS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{ADS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACIT-D Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C3', 'ITF1', 'ITU2', 'D1', 'D2', 'D3', 'D4', 
#' 'D5', 'D6', 'ITF3', 'ITF5')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACIT_D(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACIT_D(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACIT_D(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACIT_D(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACIT_D(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'ADS', 'FACIT_D_TOTAL', 'FACIT_D_TOI')])
#' }
scoreFACIT_D <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C3", "ITF1", "ITU2", "D1", "D2", "D3", "D4", 
                  "D5", "D6", "ITF3", "ITF5"),
      namesRev = c("ITF1", "ITU2", "D1", "D2", "D3", "D4", "D5", 
                   "D6", "ITF3", "ITF5"),
      nameSub = "ADS",
      nameTot = "FACIT_D",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}