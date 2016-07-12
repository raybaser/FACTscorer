#' @title Score the FACIT-F 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Chronic Illness Therapy - 
#' Fatigue (FACIT-F, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACIT-F 
#' @templateVar SCOREFUN scoreFACIT_F
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
#'   \item \strong{FS} - Fatigue subscale
#'   \item \strong{FACIT_F_TOTAL} - FACIT-F Total Score (PWB+SWB+EWB+FWB+FS)
#'   \item \strong{FACIT_F_TOI} - FACIT-F Trial Outcome Index (PWB+FWB+FS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{FS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACIT-F Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HI7', 'HI12', 'An1', 'An2', 'An3', 'An4', 'An5', 
#' 'An7', 'An8', 'An12', 'An14', 'An15', 'An16')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACIT_F(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACIT_F(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACIT_F(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACIT_F(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACIT_F(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'FS', 'FACIT_F_TOTAL', 'FACIT_F_TOI')])
#' }
scoreFACIT_F <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HI7", "HI12", "An1", "An2", "An3", "An4", "An5", 
                  "An7", "An8", "An12", "An14", "An15", "An16"),
      namesRev = c("HI7", "HI12", "An1", "An2", "An3", "An4", "An8", 
                   "An12", "An14", "An15", "An16"),
      nameSub = "FS",
      nameTot = "FACIT_F",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
