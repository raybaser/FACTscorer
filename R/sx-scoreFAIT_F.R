#' @title Score the FAIT_F
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Incontinence Therapy - 
#' Fecal Incontinence (FAIT-F, v4) from item responses.
#' 
#'
#' @templateVar MEASURE FAIT_F
#' @templateVar SCOREFUN scoreFAIT_F
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
#'   \item \strong{FIS} - Fecal Incontinence subscale
#'   \item \strong{FAIT_F_TOTAL} - FAIT-F Total Score (PWB+SWB+EWB+FWB+FIS)
#'   \item \strong{FAIT_F_TOI} - FAIT-F Trial Outcome Index (PWB+FWB+FIS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{FIS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FAIT-F Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c("ITU1", "C3", "ITF1", "ITU2", "ITU3", "ITU4", 
#' "ITU5", "ITU6", "ITF2", "ITF3", "ITF4", "ITF5")
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFAIT_F(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFAIT_F(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFAIT_F(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFAIT_F(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFAIT_F(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'FIS', 'FAIT_F_TOTAL', 'FAIT_F_TOI')])
#' }
scoreFAIT_F <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("ITU1", "C3", "ITF1", "ITU2", "ITU3", "ITU4", 
                  "ITU5", "ITU6", "ITF2", "ITF3", "ITF4", "ITF5"),
      namesRev = c("ITF1", "ITU2", "ITU3", "ITU4", "ITU5", "ITU6", 
                   "ITF2", "ITF3", "ITF5"),
      nameSub = "FIS",
      nameTot = "FAIT_F",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
