#' @title Score the FACT/GOG-Ntx-12 
#' 
#' @description
#' Generates all of the scores of the FACT/GOG-Ntx-12 (Version 4) from 
#' item responses.
#' 
#' @templateVar MEASURE FACT/GOG-Ntx-12
#' @templateVar SCOREFUN scoreFACTGOG_Ntx12
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
#'   \item \strong{NtxS12} - FACT/GOG-Ntx-12 subscale
#'   \item \strong{FACTGOG_Ntx12_TOTAL} - FACT/GOG-Ntx-12 Total Score (PWB+SWB+EWB+FWB+NtxS12)
#'   \item \strong{FACTGOG_Ntx12_TOI} - FACT/GOG-Ntx-12 Trial Outcome Index (PWB+FWB+NtxS12)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{NtxS12}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT/GOG-Ntx-12 Scoring Guidelines, available at
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
#' 'Ntx6', 'Ntx7', 'Ntx8', 'Ntx9', 'An6', 'Ntx10')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACTGOG_Ntx12(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACTGOG_Ntx12(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACTGOG_Ntx12(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACTGOG_Ntx12(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACTGOG_Ntx12(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'NtxS12', 'FACTGOG_Ntx12_TOTAL', 'FACTGOG_Ntx12_TOI')])
#' }
scoreFACTGOG_Ntx12 <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12", 
                  "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Ntx10"),
      namesRev = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12", 
                   "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Ntx10"),
      nameSub = "NtxS12",
      nameTot = "FACTGOG_Ntx12",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
