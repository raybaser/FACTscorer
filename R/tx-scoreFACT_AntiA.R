#' @title Score the FACT-AntiA (Anti-Angiogenesis)
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Anti-Angiogenesis (FACT-AntiA, v4) from item responses.
#'
#' @templateVar MEASURE FACT-AntiA
#' @templateVar SCOREFUN scoreFACT_AntiA
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
#'   \item \strong{AntiAS23} - AntiA subscale, 23-item version
#'   \item \strong{AntiAS24} - AntiA subscale, 24-item version
#'   \item \strong{FACT_AntiA_TOTAL} - FACT-AntiA Total Score
#'   (PWB+SWB+EWB+FWB+AntiAS23)
#'   \item \strong{FACT_AntiA_TOI} - FACT-AntiA Trial Outcome Index
#'   (PWB+FWB+AntiAS23)
#' }
#'
#' @section NOTE - Difference Between the 2 Versions of the AntiA Subscale:
#'
#' The scoring instructions for the FACT-AntiA on \url{www.FACIT.org} were
#' updated in February 2016 to include 2 versions of the AntiA Subscale.
#' \code{AntiAS23} is scored from 23 items and \code{AntiAS24} is scored from 24
#' items.  The additional item in \code{AntiAS24} is GP2, from the PWB subscale
#' of the FACT-G.  \code{AntiAS23} is used for the calculation of the FACT-AntiA
#' Total Score and TOI to avoid counting the GP2 item more than once in those
#' scores.  An earlier version of the manuscript in the References below
#' (downloaded from \url{www.FACIT.org}) states: "Because one item ("I have
#' nausea") from the AntiA subscale is also on the FACT-G, the AntiA subscale
#' consists of 23 rather than 24 items when combined with the FACT-G."  This
#' statement appears to be omitted from the official published version of the
#' manuscript.  This function will provide both versions of the subscale;
#' however, I assume that most users will want to use \code{AntiAS23} because if
#' item GP2 was administered it is likely that all of the FACT-G items were
#' administered.  As of this version of the \code{\link{FACTscorer}} package,
#' there does not appear to be a version of the questionnaire on
#' \url{www.FACIT.org} that contains only the 24 items needed for the 24-item
#' version.  In the validation study in the References, an additional 5
#' subscales are scored from the 24 items on \code{AntiAS24}.  Currently,
#' \code{scoreFACT_AntiA} does not produce these subscale scores.
#'
#' @references FACT-AntiA Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Kaiser, K, Beaumont, JL, Webster, K, Yount, SE, Wagner, LI, Kuzel, TM, &
#' Cella, D. (2015). Development and validation of the functional assessment of
#' cancer therapy-antiangiogenesis subscale. \emph{Cancer Medicine}, 4(5),
#' 690-698. \url{http://doi.org/10.1002/cam4.385}
#'
#' @export
#'
#' @examples
#' \dontshow{
#'
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c('HI7', 'HI12', 'AA1', 'AA2', 'AA3', 'AA4', 'AA5',
#' 'AA6', 'AA7', 'C5', 'AA8', 'BMT13', 'BRM5', 'MS3', 'BRM1', 'Cx6',
#' 'AA9', 'TH5', 'B5', 'AA10', 'GA1', 'B1', 'O2')
#' exampleDat <- make_FACTdata(namesAC = itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_AntiA(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_AntiA(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_AntiA(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_AntiA(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_AntiA(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'AntiAS23', 'FACT_AntiA_TOTAL', 'FACT_AntiA_TOI')])
#' }

scoreFACT_AntiA <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                            keepNvalid = FALSE) {
## If AConly == FALSE,
##  - Score as normal with AntiAS23
##  - Also run scoreFACT_any() with AConly = TRUE to get only AntiAS24
##  - Combine and output

  if (AConly == FALSE) {
    df_GplusAA23 <-
      scoreFACT_any(
        df = df,
        id = id,
        namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                    "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1", "Cx6",
                    "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                     "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1", "Cx6",
                     "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        nameSub = "AntiAS23",
        nameTot = "FACT_AntiA",
        AConly = FALSE,
        updateItems = updateItems,
        keepNvalid = keepNvalid
      )
    df_AA24 <-
      scoreFACT_any(
        df = df,
        id = NULL,
        namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                    "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                    "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "GP2", "O2"),
        namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                     "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                     "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "GP2", "O2"),
        nameSub = "AntiAS24",
        nameTot = "FACT_AntiA",
        AConly = TRUE,
        updateItems = FALSE,
        keepNvalid = keepNvalid
      )
    df_scores <- data.frame(df_GplusAA23, df_AA24)
  }

  ## If AConly == TRUE,
  ##  - Test to see if there is an item with name "GP2" in df
  ##  - If so, output both AntiAS23 and AntiAS24

  if ((AConly == TRUE) && ("GP2" %in% names(df))) {
    df_AA23 <-
      scoreFACT_any(
        df = df,
        id = id,
        namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                    "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                    "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                     "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                     "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        nameSub = "AntiAS23",
        nameTot = "FACT_AntiA",
        AConly = TRUE,
        updateItems = FALSE,
        keepNvalid = keepNvalid
      )
    df_AA24 <-
      scoreFACT_any(
        df = df,
        id = NULL,
        namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                    "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                    "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "GP2", "O2"),
        namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                     "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                     "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "GP2", "O2"),
        nameSub = "AntiAS24",
        nameTot = "FACT_AntiA",
        AConly = TRUE,
        updateItems = updateItems,
        keepNvalid = keepNvalid
      )
    df_scores <- data.frame(df_AA23, df_AA24)
  }

  ##  - If not, output only AntiAS23

  if ((AConly == TRUE) && ("GP2" %nin% names(df))) {
    df_scores <-
      scoreFACT_any(
        df = df,
        id = id,
        namesAC = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                    "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                    "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        namesRev = c("HI7", "HI12", "AA1", "AA2", "AA3", "AA4", "AA5",
                     "AA6", "AA7", "C5", "AA8", "BMT13", "BRM5", "MS3", "BRM1",
                     "Cx6", "AA9", "TH5", "B5", "AA10", "GA1", "B1", "O2"),
        nameSub = "AntiAS23",
        nameTot = "FACT_AntiA",
        AConly = TRUE,
        updateItems = updateItems,
        keepNvalid = keepNvalid
      )
  }
  return(df_scores)
}
