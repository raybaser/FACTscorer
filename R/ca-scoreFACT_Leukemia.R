#' @title Score the FACT-Leukemia 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Leukemia (FACT-Leukemia, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Leukemia
#' @templateVar SCOREFUN scoreFACT_Leukemia
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
#'   \item \strong{LEUS} - Leukemia subscale
#'   \item \strong{FACT_Leukemia_TOTAL} - FACT-Leukemia Total Score (PWB+SWB+EWB+FWB+LEUS)
#'   \item \strong{FACT_Leukemia_TOI} - FACT-Leukemia Trial Outcome Index (PWB+FWB+LEUS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{LEUS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Leukemia Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Webster, K., Chivington, K., Shonk, C., Eremenco, S., Yount, S., Hahn, E.,
#' van Gool, R., Tallman, M., & Cella, D. (2002).  Measuring quality of life
#' (QOL) among patients with leukemia: The Functional Assessment of
#' Cancer-Therapy-Leukemia (FACT-Leu). \emph{Quality of Life Research}, 11(7), 678.
#'
#'
#'
#' @export
#' 
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('BRM3', 'P2', 'BRM2', 'ES3', 'LEU1', 'TH1', 'TH2', 
#'  'HI12', 'BMT6', 'C2', 'C6', 'An7', 'N3', 'LEU5', 'LEU6', 'BRM9', 
#' 'LEU7')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Leukemia(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Leukemia(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Leukemia(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Leukemia(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Leukemia(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'LEUS', 'FACT_Leukemia_TOTAL', 'FACT_Leukemia_TOI')])
#' }
scoreFACT_Leukemia <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("BRM3", "P2", "BRM2", "ES3", "LEU1", "TH1", "TH2", 
                  "HI12", "BMT6", "C2", "C6", "An7", "N3", "LEU5", "LEU6", "BRM9", 
                  "LEU7"),
      namesRev = c("BRM3", "P2", "BRM2", "ES3", "LEU1", "TH1", "TH2", 
                   "HI12", "BMT6", "C2", "N3", "LEU5", "LEU6", "BRM9", "LEU7"),
      nameSub = "LEUS",
      nameTot = "FACT_Leukemia",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}