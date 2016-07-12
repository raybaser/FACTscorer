#' @title Score the FACT-An 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Anemia (FACT-An, v4) from item responses.
#' 
#' @templateVar MEASURE FACT-An
#' @templateVar SCOREFUN scoreFACT_An
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
#'   \item \strong{AnS} - Anemia subscale
#'   \item \strong{FACT_An_TOTAL} - FACT-An Total Score (PWB+SWB+EWB+FWB+AnS)
#'   \item \strong{FACT_An_TOI} - FACT-An Trial Outcome Index (PWB+FWB+AnS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{AnS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-An Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HI7', 'HI12', 'An1', 'An2', 'An3', 'An4', 'An5', 
#' 'An6', 'An7', 'An8', 'An9', 'An10', 'B1', 'An11', 'An12', 'BL4', 
#' 'An13', 'An14', 'An15', 'An16')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_An(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_An(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_An(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_An(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_An(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'AnS', 'FACT_An_TOTAL', 'FACT_An_TOI')])
#' }
scoreFACT_An <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HI7", "HI12", "An1", "An2", "An3", "An4", "An5", 
                  "An6", "An7", "An8", "An9", "An10", "B1", "An11", "An12", "BL4", 
                  "An13", "An14", "An15", "An16"),
      namesRev = c("HI7", "HI12", "An1", "An2", "An3", "An4", "An6", 
                   "An8", "An9", "An10", "B1", "An11", "An12", "An14", "An15", "An16"),
      nameSub = "AnS",
      nameTot = "FACT_An",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
