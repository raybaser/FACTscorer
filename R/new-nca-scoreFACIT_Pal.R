#' @title Score the FACIT-Pal
#'
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Chronic Illness Therapy -
#' Palliative Care (FACIT-Pal, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACIT-Pal
#' @templateVar SCOREFUN scoreFACIT_Pal
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
#'   \item \strong{PalS} - Palliative Care subscale
#'   \item \strong{FACIT_Pal_TOTAL} - FACIT-Pal Total Score (PWB+SWB+EWB+FWB+PalS)
#'   \item \strong{FACIT_Pal_TOI} - FACIT-Pal Trial Outcome Index (PWB+FWB+PalS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{PalS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Pal Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
#'
#'
#'
#'
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('PAL1', 'PAL2', 'PAL3', 'PAL4', 'B1', 'PAL5', 'C2', 'O2',
#'    'PAL6', 'PAL7', 'Br7', 'PAL8', 'PAL9', 'PAL10', 'Sp21', 'PAL12', 'L1',
#'    'PAL13', 'PAL14')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACIT_Pal(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACIT_Pal(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACIT_Pal(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACIT_Pal(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACIT_Pal(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'PalS', 'FACIT_Pal_TOTAL', 'FACIT_Pal_TOI')])
#' }
scoreFACIT_Pal <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("PAL1", "PAL2", "PAL3", "PAL4", "B1", "PAL5", "C2", "O2",
                  "PAL6", "PAL7", "Br7", "PAL8", "PAL9", "PAL10", "Sp21", "PAL12","L1",
                  "PAL13", "PAL14"),
      namesRev = c("PAL4", "B1", "PAL5", "C2", "O2", "Br7", "PAL8", "PAL9", "PAL10", 
                  "Sp21", "PAL12","L1","PAL13", "PAL14"),
      nameSub = "PalS",
      nameTot = "FACIT_Pal",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
