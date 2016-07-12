#' @title Score the FACT-HN
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Head and Neck Cancer subscale (FACT-HN, v4) from item responses.
#'
#'
#' @templateVar MEASURE FACT-HN
#' @templateVar SCOREFUN scoreFACT_HN
#' @template templateDetailsAC
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
#'   \item \strong{HNCS} - Head and Neck Cancer subscale
#'   \item \strong{FACT_HN_TOTAL} - FACT-HN Total Score (PWB+SWB+EWB+FWB+HNCS)
#'   \item \strong{FACT_HN_TOI} - FACT-HN Trial Outcome Index (PWB+FWB+HNCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{HNCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-HN Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' List, M.A., D'Antonio, L.L., Cella, D.F., Siston, A., Mumby, P., Haraf, D., &
#' Vokes, E. (1996). The Performance Status Scale for head and neck cancer
#' patients and the Functional Assessment of Cancer Therapy-Head and Neck
#' (FACT-H&N) scale: A study of utility and validity. \emph{Cancer}, 77, 2294-2301.
#' 
#' D'Antonio, L.L., Zimmerman, G.J., Cella, D.F., & Long, S.A. (1996). Quality
#' of life and functional status measures in patients with head and neck cancer.
#' \emph{Archives of Otolaryngol Head & Neck Surgery}, 122, 482-487.
#'
#'
#'
#' @export
#' 
#' @examples
#'  \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HN1', 'HN2', 'HN3', 'HN4', 'HN5', 'HN6', 'HN7',
#' 'HN10', 'HN11', 'HN12')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_HN(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_HN(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_HN(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_HN(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_HN(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'HNCS', 'FACT_HN_TOTAL', 'FACT_HN_TOI')])
#' }
scoreFACT_HN <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("HN1", "HN2", "HN3", "HN4", "HN5", "HN6", "HN7",
                  "HN10", "HN11", "HN12"),
      namesRev = c("HN2", "HN3", "HN6", "HN12"),
      nameSub = "HNCS",
      nameTot = "FACT_HN",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}