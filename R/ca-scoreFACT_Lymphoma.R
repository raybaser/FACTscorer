#' @title Score the FACT-Lymphoma 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Lymphoma (FACT-Lymphoma, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Lymphoma
#' @templateVar SCOREFUN scoreFACT_Lymphoma
#' @template templateDetailsAC
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
#'   \item \strong{LYMS} - Lymphoma subscale
#'   \item \strong{FACT_Lymphoma_TOTAL} - FACT-Lymphoma Total Score (PWB+SWB+EWB+FWB+LYMS)
#'   \item \strong{FACT_Lymphoma_TOI} - FACT-Lymphoma Trial Outcome Index (PWB+FWB+LYMS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{LYMS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Lymphoma Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Eremenco, S., Webster, K., Kutikova, L., Bowman, L., & Cella D. (2004).
#' Development and multilingual validation of the FACT-Lymphoma Instrument.
#' \emph{Quality of Life Research}, 13(9), 1501.
#' 
#' Webster K, Cashy J, Cella D, Kutikova L, Gauthier J, Liepa A, Bowman L, &
#' Gregory S.  Measuring quality of life (QOL) in patients with non-Hodgkin's
#' Lymphoma (NHL): The Functional Assessment of Cancer Therapy-Lymphoma
#' (FACT-Lym). (2005). \emph{Quality of Life Research}, 14(9), 1650.
#' 
#' Cella D, Webster K, Cashy J, Kutikova L, Burgess MF, Lin BK, Bowman L, Liepa
#' AM, Gauthier JE, Gregory SA, Johnson SA, and Bruce D. Cheson on Behalf of the
#' FACT-Lym Development Group. Development of a Measure of Health-Related
#' Quality of Life for Non-Hodgkin's Lymphoma Clinical Research: The Functional
#' Assessment of Cancer Therapy - Lymphoma (FACT-Lym). \emph{Blood (ASH Annual Meeting
#' Abstracts)}, Nov 2005; 106: 750.
#'
#' 
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('P2', 'LEU1', 'BRM3', 'ES3', 'LYM1', 'LYM2', 'BMT6', 
#' 'C2', 'GA1', 'HI8', 'N3', 'LEU6', 'LEU7', 'BRM9', 'LEU4')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Lymphoma(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Lymphoma(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Lymphoma(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Lymphoma(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Lymphoma(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'LYMS', 'FACT_Lymphoma_TOTAL', 'FACT_Lymphoma_TOI')])
#' }
scoreFACT_Lymphoma <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("P2", "LEU1", "BRM3", "ES3", "LYM1", "LYM2", "BMT6", 
                  "C2", "GA1", "HI8", "N3", "LEU6", "LEU7", "BRM9", "LEU4"),
      namesRev = c("P2", "LEU1", "BRM3", "ES3", "LYM1", "LYM2", "BMT6", 
                   "C2", "GA1", "HI8", "N3", "LEU6", "LEU7", "BRM9", "LEU4"),
      nameSub = "LYMS",
      nameTot = "FACT_Lymphoma",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}
