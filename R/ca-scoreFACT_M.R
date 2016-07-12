#' @title Score the FACT-M
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer Therapy -
#' Melanoma (FACT-M, v4) from item responses.
#'
#' @details
#' Given a data frame that includes all of the FACT-M (Version 4) items as
#' variables, appropriately named, this function generates all of the FACT-M
#' scale scores.  It is crucial that the item variables in the supplied data
#' frame are named according to FACT conventions.  For example, the first
#' physical well-being item should be named GP1, the second GP2, and so on.
#' Please refer to the materials provided by \url{http://www.facit.org} for the
#' particular questionnaire you are using.  In particular, refer to the left
#' margin of the official questionnaire (i.e., from facit.org) for the
#' appropriate item variable names.
#'
#' This questionnaire consists of two components: (1) FACT-G items and (2)
#' "Additional Concerns" items.  The FACT-G items (G for General) measure
#' general aspects of QoL common to all cancer patients. The "Additional
#' Concerns" items measure issues relevant for a specific cancer type,
#' treatment, or symptom. These two questionnaire components are typically
#' administered together. In some studies, however, ONLY the "Additional
#' Concerns" items are administered. The \code{AConly} argument is provided to
#' accommodate such cases, and should be set to \code{AConly = TRUE} if ONLY the
#' "Additional Concerns" items were administered.
#'
#' For more details on the \code{updateItems} and \code{keepNvalid}
#' arguments, see the documentation entry for \code{\link{scoreFACTG}} and
#' \code{\link{FACTscorer}}.
#'
#'
#' @section Note:
#' Keep in mind that this function (and R in general) is case-sensitive.
#'
#' All variables should be in numeric or integer format.
#'
#' This scoring function expects missing item responses to be coded as NA,
#' 8, or 9, and valid item responses to be coded as 0, 1, 2, 3, or 4.  Any
#' other value for any of the items will result in an error message and no
#' scores.
#'
#'
#' @inheritParams scoreFACT_B
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
#'   \item \strong{MS} - Melanoma subscale
#'   \item \strong{MSS} - Melanoma Surgery subscale
#'   \item \strong{FACT_M_TOTAL} - FACT-M Total Score (PWB+SWB+EWB+FWB+MS)
#'   \item \strong{FACT_M_TOI} - FACT-M Trial Outcome Index (PWB+FWB+MS)
#' }
#'
#' If \code{AConly = TRUE}, the only scale scores returned are \strong{MS} and
#' \strong{MSS}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-M Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Cormier, J., Davidson, L., Xing, Y., Webster, K., & Cella, D. (2005).
#' Measuring quality of life in patients with melanoma: Development of the
#' FACT-Melanoma Subscale.  \emph{The Journal of Supportive Oncology}, 3(5),
#' 139-145.
#'
#'
#' @seealso This function is very similar to the \code{\link{scoreFACT_B}}
#'   function.  To see examples of function usage, please see the documentation
#'   for \code{\link{scoreFACT_B}}.  For additional details on the function
#'   arguments, see \code{\link{scoreFACTG}} and \code{\link{FACTscorer}}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## To see examples using this function, run:  example(scoreFACT_M)
#' ## Also see the examples for the very similar scoreFACT_B function }
#' \dontshow{
#' ## Setting up item names for fake data
#' G_names <- c(paste0('GP', 1:7),
#'              paste0('GS', 1:7),
#'              paste0('GE', 1:6),
#'              paste0('GF', 1:7))
#' AC_names1 <- c('M1', 'M2', 'M3', 'B1', 'ITU4', 'An10', 'Hep3', 'C1', 'C6',
#' 'M5', 'M6', 'ITU3', 'MS8', 'M8',  'M9', 'HI7')
#' AC_names2 <- c('M10', 'M11', 'M12', 'M13', 'M14', 'M15', 'M16', 'M17')
#' AC_names <- c(AC_names1, AC_names2)
#' itemNames <- c(G_names, AC_names)
#' ## Generating random item responses for 8 fake respondents
#' set.seed(6375309)
#' exampleDat <- t(replicate(8, sample(0:4, size = length(itemNames), replace = TRUE)))
#' ## Making half of respondents missing about 10% of items,
#' ## half missing about 50%.
#' miss10 <- t(replicate(4, sample(c(0, 9), prob = c(0.9, 0.1),
#'     size = length(itemNames), replace = TRUE)))
#' miss50 <- t(replicate(4, sample(c(0, 9), prob = c(0.5, 0.5),
#'     size = length(itemNames), replace = TRUE)))
#' missMtx <- rbind(miss10, miss50)
#' ## Using 9 as the code for missing responses
#' exampleDat[missMtx == 9] <- 9
#' exampleDat <- as.data.frame(cbind(ID = paste0('ID', 1:8),
#'     as.data.frame(exampleDat)))
#' names(exampleDat) <- c('ID', itemNames)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' (scoredDat <- scoreFACT_M(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- scoreFACT_M(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_M(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
#'                       'MS', 'MSS', 'FACT_M_TOTAL', 'FACT_M_TOI')])
#'
#' ## If ONLY the "Additional Concerns" items are in df, use AConly = TRUE
#' (scoredDat <- scoreFACT_M(exampleDat, AConly = TRUE))
#'
#' ## AConly = TRUE with an id variable
#' (scoredDat <- scoreFACT_M(exampleDat, id = "ID", AConly = TRUE))
#'
#' ## Clean up
#' rm(miss10, miss50, missMtx, exampleDat, scoredDat, mergeDat)
#' }
scoreFACT_M <- function(df, id = NULL, AConly = FALSE, updateItems = FALSE,
                        keepNvalid = FALSE) {
  ## Test whether id (if given) is in df.
  if (!is.null(id)) {
    if (!(id %in% names(df))) {
      stop("Cannot find your id variable name in your df.
           Make sure it is typed correctly, and in quotes.
           Or just omit the id argument, since it is optional.")
      break
    }
  }

  ## Prep the AC items, regardless of AConly value
  dfAC <- df
  names(dfAC) <- toupper(names(dfAC))
  G_names <- c(paste0("GP", 1:7), paste0("GS", 1:7), paste0("GE", 1:6),
               paste0("GF", 1:7))
  G_names <- paste0(G_names, "_rc")
  AC_names1 <- toupper(c("M1", "M2", "M3", "B1", "ITU4", "An10", "Hep3", "C1",
                         "C6", "M5", "M6", "ITU3", "MS8", "M8", "M9", "HI7"))
  AC_names2 <- toupper(c("M10", "M11", "M12", "M13", "M14", "M15", "M16",
                         "M17"))
  AC_names <- c(AC_names1, AC_names2)
  revNames <- toupper(c("M1", "M2", "M3", "B1", "ITU4", "An10", "Hep3", "C1",
                        "M5", "M6", "ITU3", "MS8", "M8", "M9", "HI7", "M10",
                        "M11", "M12", "M13", "M14", "M15", "M16"))
  AC_items <- dfAC[, AC_names]
  if (any(!(as.matrix(AC_items) %in% c(0:4, 8, 9, NA)))) {
    stop("At least 1 response is out of range (i.e., not 0-4, 8, 9, or NA)")
    break
  }
  makeMiss <- function(x) {
    x[x %in% c(8, 9)] <- NA
    return(x)
  }
  AC_items <- as.data.frame(lapply(AC_items, makeMiss))
  revHelper <- function(x) {
    return(4 - x)
  }
  AC_items[, revNames] <- lapply(AC_items[, revNames], revHelper)
  valid_N <- as.data.frame(lapply(AC_items, function(x) as.numeric(!is.na(x))))

  ## score the  TWO AC SUBSCALES!!!!!
  AC_N1 <- rowSums(valid_N[, AC_names1])
  AC1 <- round(rowMeans(AC_items[, AC_names1], na.rm = TRUE) *
                 length(AC_names1), 3)
  AC1[AC_N1/length(AC_names1) <= 0.5] <- NA

  AC_N2 <- rowSums(valid_N[, AC_names2])
  AC2 <- round(rowMeans(AC_items[, AC_names2], na.rm = TRUE) *
                 length(AC_names2), 3)
  AC2[AC_N2/length(AC_names2) <= 0.5] <- NA


  # rename AC_items to format "ITEM_rc"
  names(AC_items) <- paste0(names(AC_items), "_rc")

  ## AConly == FALSE (default)
  if (AConly == FALSE) {
    dfG <- scoreFACTG(df, updateItems = updateItems, keepNvalid = TRUE)
    ## For FACT-M, only MS contributes to Total and TOI
    TOTAL_N <- dfG$PWB_N + dfG$SWB_N + dfG$EWB_N + dfG$FWB_N + AC_N1
    TOTAL <- dfG$PWB + dfG$SWB + dfG$EWB + dfG$FWB + AC1
    TOTAL[TOTAL_N/length(c(G_names, AC_names1)) <= 0.8] <- NA
    TOI <- dfG$PWB + dfG$FWB + AC1

    ## replace generic names with scale-specific names
    FACT_M_TOTAL_N <- TOTAL_N
    MS_N  <- AC_N1
    MSS_N <- AC_N2
    MS  <- AC1
    MSS <- AC2
    FACT_M_TOTAL <- TOTAL
    FACT_M_TOI <- TOI

    # make data frames with AC components
    dfAC_N <- data.frame(MS_N, MSS_N, FACT_M_TOTAL_N)
    dfAC_scores <- data.frame(MS, MSS, FACT_M_TOTAL, FACT_M_TOI)

    # make names indexing parts of FACT-G output (G items already in "G_names")
    gnames_scores <- c("PWB", "SWB", "EWB", "FWB", "FACTG")
    gnames_N <- c("PWB_N", "SWB_N", "EWB_N", "FWB_N", "FACTG_N")


    if (updateItems) {                  # BOTH updateItems AND keepNvalid TRUE
      if (keepNvalid) {
        dfOut <- data.frame(df[id], dfG[G_names], AC_items, dfG[gnames_N],
                            dfAC_N, dfG[gnames_scores], dfAC_scores)
      }
      else {                          # updateItems TRUE, keepNvalid FALSE
        dfOut <- data.frame(df[id], dfG[G_names], AC_items,
                            dfG[gnames_scores], dfAC_scores)
      }
    }
    else {
      if (keepNvalid) {               # updateItems FALSE, keepNvalid TRUE
        dfOut <- data.frame(df[id], dfG[gnames_N], dfAC_N,
                            dfG[gnames_scores], dfAC_scores)
      }
      else {                          # BOTH updateItems AND keepNvalid FALSE
        dfOut <- data.frame(df[id], dfG[gnames_scores], dfAC_scores)
      }
    }
  }

  ## AConly == TRUE
  if (AConly == TRUE) {

    ## replace generic names with scale-specific names
    MS_N  <- AC_N1
    MSS_N <- AC_N2
    MS  <- AC1
    MSS <- AC2

    # make data frames with AC components
    dfAC_N <- data.frame(MS_N, MSS_N)
    dfAC_scores <- data.frame(MS, MSS)

    if (updateItems) {                  # BOTH updateItems AND keepNvalid TRUE
      if (keepNvalid) {
        dfOut <- data.frame(df[id], AC_items, dfAC_N, dfAC_scores)
      }
      else {                          # updateItems TRUE, keepNvalid FALSE
        dfOut <- data.frame(df[id], AC_items, dfAC_scores)
      }
    }
    else {
      if (keepNvalid) {               # updateItems FALSE, keepNvalid TRUE
        dfOut <- data.frame(df[id], dfAC_N, dfAC_scores)
      }
      else {                          # BOTH updateItems AND keepNvalid FALSE
        dfOut <- data.frame(df[id], dfAC_scores)
      }
    }
  }
  return(dfOut)
}
