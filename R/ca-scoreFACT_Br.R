#' @title Score the FACT-Br
#'
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Brain Cancer (FACT-Br, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-Br
#' @templateVar SCOREFUN scoreFACT_Br
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
#'   \item \strong{BrCS} - Brain Cancer subscale
#'   \item \strong{FACT_Br_TOTAL} - FACT-Br Total Score (PWB+SWB+EWB+FWB+BrCS)
#'   \item \strong{FACT_Br_TOI} - FACT-Br Trial Outcome Index (PWB+FWB+BrCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{BrCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Br Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Weitzner, M.A., Meyers, C.A., Gelke, C., Byrne, K., Cella, D.F., & Levin,
#' V.A. (1995). The Functional Assessment of Cancer Therapy (FACT) scale:
#' Development of a brain subscale and revalidation of the general version
#' (FACT-G) in patients with primary brain tumors. \emph{Cancer}, 75(5),
#' 1151-1161.
#'
#'
#' @export
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('Br1', 'Br2', 'Br3', 'Br4', 'Br5', 'Br6', 'Br7', 'Ntx6',
#'    'Br8', 'Br9', 'Br10', 'Br11', 'Br12', 'Br13', 'Br14', 'Br15', 'Br16',
#'    'Br17', 'Br18')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Br(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Br(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Br(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Br(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Br(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'BrCS', 'FACT_Br_TOTAL', 'FACT_Br_TOI')])
#' }
scoreFACT_Br <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                        keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("Br1", "Br2", "Br3", "Br4", "Br5", "Br6", "Br7", "Ntx6",
                  "Br8", "Br9", "Br10", "Br11", "Br12", "Br13", "Br14", "Br15",
                  "Br16", "Br17", "Br18"),
      namesRev = c("Br2", "Br4", "Br5", "Br6", "Ntx6", "Br9", "Br10",
                   "Br12", "Br14"),
      nameSub = "BrCS",
      nameTot = "FACT_Br",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
