#' @title Score the FAIT-U
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Incontinence Therapy - 
#' Urinary Incontinence (FAIT-U, v4) from item responses.
#' 
#' @templateVar MEASURE FAIT-U
#' @templateVar SCOREFUN scoreFAIT_U
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
#'   \item \strong{UIS} - Urinary Incontinence subscale
#'   \item \strong{FAIT_U_TOTAL} - FAIT-U Total Score (PWB+SWB+EWB+FWB+UIS)
#'   \item \strong{FAIT_U_TOI} - FAIT-U Trial Outcome Index (PWB+FWB+UIS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{UIS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FAIT-U Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('BL1', 'ITU1', 'BL2', 'ITU2', 'ITU3', 'ITU4', 
#' 'ITU5', 'ITU6', 'ITU7', 'ITU8', 'ITU9')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFAIT_U(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFAIT_U(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFAIT_U(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFAIT_U(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFAIT_U(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'UIS', 'FAIT_U_TOTAL', 'FAIT_U_TOI')])
#' }
scoreFAIT_U <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("BL1", "ITU1", "BL2", "ITU2", "ITU3", "ITU4", 
                  "ITU5", "ITU6", "ITU7", "ITU8", "ITU9"),
      namesRev = c("BL1", "BL2", "ITU2", "ITU3", "ITU4", "ITU5", 
                   "ITU6", "ITU7", "ITU8", "ITU9"),
      nameSub = "UIS",
      nameTot = "FAIT_U",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
