#' @title Score the FACT-Hep 
#' 
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy - 
#' Hepatobiliary Cancer (FACT-Hep, v4) from item responses.
#' 
#' 
#' @templateVar MEASURE FACT-Hep
#' @templateVar SCOREFUN scoreFACT_Hep
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
#'   \item \strong{HCS} - Hepatobiliary Cancer subscale
#'   \item \strong{FACT_Hep_TOTAL} - FACT-Hep Total Score (PWB+SWB+EWB+FWB+HCS)
#'   \item \strong{FACT_Hep_TOI} - FACT-Hep Trial Outcome Index (PWB+FWB+HCS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{HCS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-Hep Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'   
#' Heffernan, N., Cella, D., Webster, K., Odom, L., Marone, M., Passik, S.,
#' Bookbinder, M., Fong, Y., Jarnagin, W., Blumbart, L. (2002). Measuring
#' health-related quality of life in patients with hepatobiliary cancers: The
#' Functional Assessment of Cancer Therapy - Hepatobiliary (FACT-Hep)
#' questionnaire. \emph{Journal of Clinical Oncology}, 20(9), 2229-2239.
#'
#'
#' @export
#' 
#' @examples 
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'Hep1', 'Cns7', 
#' 'Cx6', 'HI7', 'An7', 'Hep2', 'Hep3', 'Hep4', 'Hep5', 'Hep6', 'HN2', 
#' 'Hep8')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_Hep(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_Hep(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_Hep(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_Hep(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_Hep(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'HCS', 'FACT_Hep_TOTAL', 'FACT_Hep_TOI')])
#' }
scoreFACT_Hep <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                         keepNvalid = FALSE) {
  df_scores <-
    scoreFACT_any(
      df = df,
      id = id,
      namesAC = c("C1", "C2", "C3", "C4", "C5", "C6", "Hep1", "Cns7", 
                  "Cx6", "HI7", "An7", "Hep2", "Hep3", "Hep4", "Hep5", "Hep6", "HN2", 
                  "Hep8"),
      namesRev = c("C1", "C2", "C5", "Hep1", "Cns7", "Cx6", "HI7", 
                   "Hep2", "Hep3", "Hep4", "Hep5", "Hep6", "HN2", "Hep8"),
      nameSub = "HCS",
      nameTot = "FACT_Hep",
      AConly = AConly,
      updateItems = updateItems,
      keepNvalid = keepNvalid
    )
  return(df_scores)
}