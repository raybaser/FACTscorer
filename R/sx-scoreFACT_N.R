#' @title Score the FACT-N 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Neutropenia (FACT-N, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-N
#' @templateVar SCOREFUN scoreFACT_N
#' @template templateDetailsAC
#'
#'
#' @template templateParamsAC
#'
#' @return A data frame with the following scale scores is returned:
#'
#' \itemize{
#'   \item \strong{PWB} - Physical Well-Being subscale
#'   \item \strong{SWB} - Social/Family Well-Being subscale
#'   \item \strong{EWB} - Emotional Well-Being subscale
#'   \item \strong{FWB} - Physical Well-Being subscale
#'   \item \strong{FACTG} - FACT-G Total Score (PWB+SWB+EWB+FWB)
#'   \item \strong{NS} - Neutropenia subscale
#'   \item \strong{FACT_N_TOTAL} - FACT-N Total Score (PWB+SWB+EWB+FWB+NS)
#'   \item \strong{FACT_N_TOI} - FACT-N Trial Outcome Index (PWB+FWB+NS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{NS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-N Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('N1', 'N2', 'P1', 'An14', 'N3', 'N4', 'An5', 
#' 'BRM3', 'BRM2', 'ES3', 'An16', 'N5', 'An1', 'An13', 'N6', 'N7', 
#' 'N8', 'An3', 'MS3')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_N(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_N(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_N(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_N(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_N(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'NS', 'FACT_N_TOTAL', 'FACT_N_TOI')])
#' }
scoreFACT_N <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("N1", "N2", "P1", "An14", "N3", "N4", "An5", 
                  "BRM3", "BRM2", "ES3", "An16", "N5", "An1", "An13", "N6", "N7", 
                  "N8", "An3", "MS3"),
      namesRev = c("N1", "N2", "P1", "An14", "N3", "N4", "BRM3", 
                   "BRM2", "ES3", "An16", "N5", "An1", "N6", "N7", "N8", "An3", "MS3"),
      nameSub = "NS",
      nameTot = "FACT_N",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
