#' @title Score the FACT-G
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer
#' Therapy-General (FACT-G) from item responses.
#'
#' @details
#' Given a data frame that includes all of the FACT-G items as variables,
#' appropriately named, this function generates all of the FACT-G scale
#' scores. It is crucial that the item variables in the supplied data frame
#' are named according to FACT conventions. For example, the first physical
#' well-being item should be named GP1, the second GP2, and so on. Please
#' refer to the materials provided by \url{http://www.facit.org} for the
#' particular questionnaire you are using. In particular, refer to the left
#' margin of the official questionnaire (i.e., from facit.org) for the
#' appropriate item variable names.
#'
#' Most users will want to omit the \code{updateItems} and \code{keepNvalid}
#' arguments or, equivalently, set them both to \code{FALSE}.
#'
#' Some item variables are reverse coded for the purpose of generating the scale
#' scores. The official (e.g., from \url{http://www.facit.org}) SAS and SPSS
#' scoring algorithms for this questionnaire automatically replace the original
#' items with their reverse coded versions (as well as recode values of 8 or 9
#' to missing values). This can be confusing and may produce incorrect scale
#' scores if you accidentally run the SAS/SPSS algorithm more than once on your
#' data. Therefore, \code{scoreFACTG} DOES NOT replace any of your original
#' item variables with the reverse coded versions. However, for consistency
#' with the behavior of the other algorithms on \url{http://www.facit.org}, the
#' \code{updateItems} argument is provided. If set to \code{TRUE}, then an
#' updated set of items will be included in the output data frame. These
#' updated items differ from the original items in 3 ways: (1) any original item
#' that needs to be reverse coded for scoring will be updated with its reverse
#' coded version, (2) any values of 8 or 9 will be replaced with NA, and (3) the
#' updated items will be renamed by adding the suffix "_rc" (for "re-coded") to
#' the original names, e.g., \code{GP1_rc}.
#'
#' The \code{keepNvalid} argument is intended to provide additional information
#' on missing item patterns and will not be of interest to most users. For most
#' of the scale scores, one of the intermediate steps in the scoring algorithm
#' is to calculate for each respondent the number of valid, non-missing items on
#' the scale. If \code{keepNvalid = TRUE}, then additional variables with these
#' valid item counts will be returned for each applicable scale score. These
#' variables are named with the suffix "_N", e.g., in the format,
#' \code{SCALENAME_N}.
#'
#'
#' @section Note:
#' This function scores ONLY the general FACT-G items.  It does not score any
#' "Additional Concerns" items (which assess issues relevant to a specific
#' cancer type, treatment, or symptom).  If you have any "Additional Concerns"
#' items in your data, then you should use the \code{\link{FACTscorer}} scoring
#' function that corresponds to the specific FACT questionnaire you
#' administered.  For example, if you administered the FACT-B (i.e., FACT-Breast
#' Cancer) questionnaire, you should use the \code{\link{scoreFACT_B}} function
#' instead of \code{scoreFACTG}.
#'
#' Keep in mind that this function (and R in general) is case-sensitive.
#'
#' All variables should be in numeric or integer format.
#'
#' This scoring function expects missing item responses to be coded as NA,
#' 8, or 9, and valid item responses to be coded as 0, 1, 2, 3, or 4. Any
#' other value for any of the items will result in an error message and no
#' scores.
#'
#'
#' @template paramsFACTG
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
#' }
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#'
#' @references FACT-G Scoring Guidelines, available at \url{http://www.facit.org}
#'
#' Cella, D.F., Tulsky, D.S., Gray, G., et al. (1993). The Functional
#' Assessment of Cancer Therapy (FACT) scale: Development and validation
#' of the general measure. \emph{Journal of Clinical Oncology}, 11(3), 570-579.
#'
#' Webster, K., Odom, L., Peterman, A., Lent, L., & Cella, D. (1999).
#' The Functional Assessment of Chronic Illness Therapy (FACIT) measurement
#' system: Validation of version 4 of the core questionnaire.
#' \emph{Quality of Life Research}, 8(7), 604.
#'
#' Winstead-Fry, P., & Schultz, A. (1997). Psychometric assessment of the
#' Functional Assessment of Cancer Therapy-General (FACT-G) scale in a
#' rural sample. \emph{Cancer}, 79(12), 2446-2452.
#'
#' Overcash, J., Extermann, M., Parr, J., Perry, J., & Balducci, L. (2001).
#' Validity and reliability of the FACT-G scale for use in the older person
#' with cancer. \emph{American Journal of Clinical Oncology}, 24(6), 591-596.
#'
#' Webster, K., Cella, D., & Yost, K. (2003). The Functional Assessment of
#' Chronic Illness Therapy (FACIT) Measurement System: Properties,
#' applications, and interpretation. \emph{Health and Quality of Life Outcomes},
#' 1, 79.
#'
#' @aliases scoreFACT_G score_FACT_G score_FACTG scorefactg ScoreFACTG
#'
#' @seealso See \code{\link{FACTscorer}} for more comprehensive information
#'   about using the functions in this package.
#'
#' @export
#'
#' @examples
#' ## FIRST creating a df with fake item data to score
#' exampleDat <- make_FACTdata()
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' scoredDat <- scoreFACTG(exampleDat)
#' scoredDat
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' scoredDat <- scoreFACTG(exampleDat, id = "ID")
#' scoredDat
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACTG(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG')])
scoreFACTG <- function(df, id = NULL, updateItems = FALSE, keepNvalid = FALSE) {
  ## Test whether id (if given) is in df.
  if (!is.null(id)) {
    if (!(id %in% names(df))) {
      stop("Cannot find your id variable name in your df.
           Make sure it is typed correctly, and in quotes.
           Or just omit the id argument, since it is optional.")
      break
    }
  }

  dfup <- df
  names(dfup) <- toupper(names(df))
  PWB_names <- c("GP1", "GP2", "GP3", "GP4", "GP5", "GP6", "GP7")
  SWB_names <- c("GS1", "GS2", "GS3", "GS4", "GS5", "GS6", "GS7")
  EWB_names <- c("GE1", "GE2", "GE3", "GE4", "GE5", "GE6")
  FWB_names <- c("GF1", "GF2", "GF3", "GF4", "GF5", "GF6", "GF7")
  revNames <- c("GP1", "GP2", "GP3", "GP4", "GP5", "GP6", "GP7", "GE1",
      "GE3", "GE4", "GE5", "GE6")
  items <- dfup[, c(PWB_names, SWB_names, EWB_names, FWB_names)]
  if (any(!(as.matrix(items) %in% c(0:4, 8, 9, NA)))) {
    stop("At least 1 response is out of range (i.e., not 0-4, 8, 9, or NA)")
    break
  }
  makeMiss <- function(x) {
    x[x %in% c(8, 9)] <- NA
    return(x)
  }
  items <- as.data.frame(lapply(items, makeMiss))
  revHelper <- function(x) {
    return(4 - x)
  }
  items[, revNames] <- lapply(items[, revNames], revHelper)
  valid_N <- as.data.frame(lapply(items, function(x) as.numeric(!is.na(x))))
  PWB_N <- rowSums(valid_N[, PWB_names])
  SWB_N <- rowSums(valid_N[, SWB_names])
  EWB_N <- rowSums(valid_N[, EWB_names])
  FWB_N <- rowSums(valid_N[, FWB_names])
  FACTG_N <- PWB_N + SWB_N + EWB_N + FWB_N
  PWB <- round(rowMeans(items[, PWB_names], na.rm = TRUE) *
               length(PWB_names), 3)
  PWB[PWB_N/length(PWB_names) <= 0.5] <- NA
  SWB <- round(rowMeans(items[, SWB_names], na.rm = TRUE) *
               length(SWB_names),3)
  SWB[SWB_N/length(SWB_names) <= 0.5] <- NA
  EWB <- round(rowMeans(items[, EWB_names], na.rm = TRUE) *
               length(EWB_names), 3)
  EWB[EWB_N/length(EWB_names) <= 0.5] <- NA
  FWB <- round(rowMeans(items[, FWB_names], na.rm = TRUE) *
               length(FWB_names), 3)
  FWB[FWB_N/length(FWB_names) <= 0.5] <- NA
  FACTG <- round(PWB + SWB + EWB + FWB, 3)
  FACTG[FACTG_N/ncol(items) <= 0.8] <- NA

  # rename items to format "ITEM_rc"
  names(items) <- paste0(names(items), "_rc")

  if (updateItems) {                  # BOTH updateItems AND keepNvalid TRUE
    if (keepNvalid) {
      dfOut <- data.frame(df[id], items, PWB_N, SWB_N, EWB_N, FWB_N,
                          FACTG_N, PWB, SWB, EWB, FWB, FACTG)
    }
    else {                          # updateItems TRUE, keepNvalid FALSE
      dfOut <- data.frame(df[id], items, PWB, SWB, EWB, FWB, FACTG)
    }
  }
  else {
    if (keepNvalid) {               # updateItems FALSE, keepNvalid TRUE
      dfOut <- data.frame(df[id], PWB_N, SWB_N, EWB_N, FWB_N,
                          FACTG_N, PWB, SWB, EWB, FWB, FACTG)
    }
    else {                          # BOTH updateItems AND keepNvalid FALSE
      dfOut <- data.frame(df[id], PWB, SWB, EWB, FWB, FACTG)
    }
  }

  return(dfOut)
}
