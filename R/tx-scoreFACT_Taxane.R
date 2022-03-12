#' @title Score the FACT-Taxane
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Taxane (FACT-Taxane, v4) from item responses.
#'
#' @templateVar MEASURE FACT-Taxane
#' @templateVar SCOREFUN scoreFACT_Taxane
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
#'   \item \strong{TaxS} - Taxane subscale
#'   \item \strong{FACT_Taxane_TOTAL} - FACT-Taxane Total Score (PWB+SWB+EWB+FWB+TaxS)
#'   \item \strong{FACT_Taxane_TOI} - FACT-Taxane Trial Outcome Index (PWB+FWB+TaxS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{TaxS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Taxane Scoring Guidelines, available at
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
#' 'Ntx6', 'Ntx7', 'Ntx8', 'Ntx9', 'An6', 'Tax1', 'Tax2', 'Tax3',
#' 'Tax4', 'Tax5')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Taxane(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Taxane(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Taxane(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Taxane(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Taxane(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c("PWB", "SWB", "EWB", "FWB", "FACTG",
#'                       "TaxS", "FACT_Taxane_TOTAL", "FACT_Taxane_TOI")])
#' }
scoreFACT_Taxane <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12",
                  "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Tax1", "Tax2", "Tax3",
                  "Tax4", "Tax5"),
      namesRev = c("Ntx1", "Ntx2", "Ntx3", "Ntx4", "Ntx5", "HI12",
                   "Ntx6", "Ntx7", "Ntx8", "Ntx9", "An6", "Tax1", "Tax2", "Tax3",
                   "Tax4", "Tax5"),
      nameSub = "TaxS",
      nameTot = "FACT_Taxane",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
