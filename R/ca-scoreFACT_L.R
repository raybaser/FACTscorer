#' @title Score the FACT-L 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Lung Cancer (FACT-L, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-L
#' @templateVar SCOREFUN scoreFACT_L
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
#'   \item \strong{LCS} - Lung Cancer subscale
#'   \item \strong{FACT_L_TOTAL} - FACT-L Total Score (PWB+SWB+EWB+FWB+LCS)
#'   \item \strong{FACT_L_TOI} - FACT-L Trial Outcome Index (PWB+FWB+LCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{LCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-L Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Cella, D.F., Bonomi, A.E., Lloyd S.R., Tulsky, D.S., Kaplan, E., & Bonomi, P.
#' (1995). Reliability and validity of the Functional Assessment of Cancer
#' Therapy - Lung (FACT-L) quality of life instrument. \emph{Lung Cancer}, 12, 199-220.
#' 
#' Cella, D., Eton, D., Fairclough, D.L., Bonomi, P., Heyes, A., Silberman, C.,
#' Wolf, M.K., & Johnson, D.H. (2002). What is a clinically meaningful change on
#' the Functional Assessment of Cancer Therapy-Lung (FACT-L) questionnaire?
#' Results from Eastern Cooperative Oncology Group (ECOG) Study 5592. \emph{Journal of
#' Clinical Epidemiology}, 55, 285-295.
#' 
#' Cella, D.F., Bonomi, A.E., Lloyd S., Tulsky, D., Bonomi, P., & Kaplan, E.
#' (1994). Reliability and validity of the Functional Assessment of Cancer
#' Therapy-Lung (FACT-L) quality of life instrument. \emph{Lung Cancer}, 11(Suppl 1),
#' 89 (Abstract #336).
#' 
#' Cella, D.F. (1995). The Functional Assessment of Cancer Therapy-Lung (FACT-L)
#' quality of life instrument. In R.J. Gralla & C.M. Moinpour (Eds): Assessing
#' Quality of Life in Patients with Lung Cancer: \emph{A Guide for Clinicians}. New
#' York: NCM Publishers, Inc.
#' 
#' Butt, Z., Webster, K., Eisenstein, A.R., Beaumont, J., Eton, D., Masters,
#' G.A., & Cella, D. (2005). Quality of life in lung cancer: The validity and
#' cross-cultural applicability of the Functional Assessment of Cancer
#' Therapy-Lung scale. \emph{Hematol Oncol Clin N Am}, 19, 389-420.
#'
#' 
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('B1', 'C2', 'L1', 'L2', 'C6', 'L3', 'L4')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_L(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_L(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_L(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_L(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_L(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'LCS', 'FACT_L_TOTAL', 'FACT_L_TOI')])
#' }
scoreFACT_L <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("B1", "C2", "L1", "L2", "C6", "L3", "L4"),
      namesRev = c("B1", "C2", "L2", "L3"),
      nameSub = "LCS",
      nameTot = "FACT_L",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
