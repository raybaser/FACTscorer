#' @title Score the FACT/GOG-Ntx13
#' 
#' @description
#' Generates all of the scores of the FACT/GOG-Ntx13 (Version 4) from 
#' item responses.
#' 
#' 
#' @templateVar MEASURE FACT/GOG-Ntx13
#' @templateVar SCOREFUN scoreFACTGOG_Ntx13
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
#'   \item \strong{NtxS13} - GOG_Ntx13 subscale
#'   \item \strong{FACTGOG_Ntx13_TOTAL} - FACT/GOG-Ntx13 Total Score (PWB+SWB+EWB+FWB+NtxS13)
#'   \item \strong{FACTGOG_Ntx13_TOI} - FACT/GOG-Ntx13 Trial Outcome Index (PWB+FWB+NtxS13)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{NtxS13}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT/GOG-Ntx13 Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('Ntx1', 'Ntx2', 'Ntx3', 'Ntx4', 'Ntx5', 'HI12', 
#' 'Ntx6', 'Ntx7', 'Ntx8', 'Ntx9', 'An6', 'Ntx10', 'Ntx11')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACTGOG_Ntx13(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACTGOG_Ntx13(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACTGOG_Ntx13(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACTGOG_Ntx13(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACTGOG_Ntx13(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'NtxS13', 'FACTGOG_Ntx13_TOTAL', 'FACTGOG_Ntx13_TOI')])
#' }
scoreFACTGOG_Ntx13 <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12", 
                  "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Ntx10", "Ntx11"),
      namesRev = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12", 
                   "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Ntx10", "Ntx11"),
      nameSub = "NtxS13",
      nameTot = "FACTGOG_Ntx13",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}

