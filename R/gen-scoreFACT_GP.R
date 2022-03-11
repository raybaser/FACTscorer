#' @title Score the FACT-GP
#'
#' @description
#' Generates all of the scores of the Functional Assessment of Cancer
#' Therapy-General Population (FACT-GP) from item responses.
#'
#' @details
#' Given a data frame that includes all of the FACT-GP items as variables,
#' appropriately named, this function generates all of the FACT-GP scale
#' scores.  It is crucial that the item variables in the supplied data frame
#' are named according to FACT conventions.  For example, the first physical
#' well-being item should be named GP1, the second GP2, and so on.  Please
#' refer to the materials provided by \url{http://www.facit.org} for the
#' particular questionnaire you are using.  In particular, refer to the left
#' margin of the official questionnaire (i.e., from facit.org) for the
#' appropriate item variable names.
#'
#' Most users will want to omit the \code{updateItems} and \code{keepNvalid}
#' arguments or, equivalently, set them both to \code{FALSE}. For more details
#' on these arguments, see the documentation entry for \code{\link{scoreFACTG}}
#' and \code{\link{FACTscorer}}.
#'
#' Note that the FACT-GP subscale scores are \strong{not} sums of the item
#' scores.  The FACT-GP is meant to be comparable to the FACT-G; however, the
#' FACT-GP has fewer items than the FACT-G due to elimination of the FACT-G
#' items specific to illness or treatment.  Therefore, in order to make the
#' FACT-GP scores comparable to those from the FACT-G, they are rescaled to have
#' the same ranges as the corresponding FACT-G scores.  See the Brucker et al.
#' (2005) reference for more information.
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
#'   \item \strong{FACT_GP} - FACT-GP Total Score (PWB+SWB+EWB+FWB)
#' }
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @references FACT-GP Scoring Guidelines, available at \url{http://www.facit.org}
#'
#' Brucker, P. S., Yost, K., Cashy, J., Webster, K., & Cella, D. (2005). General
#' population and cancer patient norms for the Functional Assessment of Cancer
#' Therapy-General (FACT-G). Evaluation & the Health Professions, 28(2),
#' 192–211.
#'
#' @seealso See \code{\link{FACTscorer}} for more comprehensive information
#'   about using the functions in this package.  This function is very similar
#'   to the \code{\link{scoreFACTG}} function.  See the documentation for
#'   \code{\link{scoreFACTG}} for more details on the arguments and for
#'   examples.  For brevity, examples are omitted below, but can be accessed by
#'   running \code{example(scoreFACT_GP)}.
#'
#' @export
#'
#' @examples
#' \dontshow{
#' ## FIRST creating a df with fake item data to score
#' exampleDat <- make_FACTdata()
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale scores
#' scoredDat <- scoreFACT_GP(exampleDat)
#' scoredDat
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' scoredDat <- scoreFACT_GP(exampleDat, id = "ID")
#' scoredDat
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## Returns scale scores, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- scoreFACT_GP(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACT_GP')])
#' }
scoreFACT_GP <- function(df, id = NULL, updateItems = FALSE, keepNvalid = FALSE) {
  ## Test whether id (if given) is in df.
  if (!is.null(id)) {
    if (!(id %in% names(df))) {
      stop("Cannot find your id variable name in your df.
           Make sure it is typed correctly, and in quotes.
           Or just omit the id argument, since it is optional.")
    }
  }

  dfup <- df
  names(dfup) <- toupper(names(df))
  PWB_names <- c("GP1", "GP2", "GP3", "GP4", "GP6", "GP7")
  SWB_names <- c("GS1", "GS2", "GS3", "GS6", "GS7")
  EWB_names <- c("GE1", "GE4", "GE5", "GE6")
  FWB_names <- c("GF1", "GF2", "GF3", "GF5", "GF6", "GF7")
  revNames <- c("GP1", "GP2", "GP3", "GP4", "GP6", "GP7", "GE1", "GE4",
      "GE5", "GE6")
  items <- dfup[, c(PWB_names, SWB_names, EWB_names, FWB_names)]
  if (any(!(as.matrix(items) %in% c(0:4, 8, 9, NA)))) {
    stop("At least 1 response is out of range (i.e., not 0-4, 8, 9, or NA)")
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
  FACT_GP_N <- PWB_N + SWB_N + EWB_N + FWB_N

  ## NOTE: Scaling scores below to have same range as FACT-G scores
  PWB <- round(rowMeans(items[, PWB_names], na.rm = TRUE) * 7, 3)
  PWB[PWB_N/length(PWB_names) <= 0.5] <- NA
  SWB <- round(rowMeans(items[, SWB_names], na.rm = TRUE) * 7, 3)
  SWB[SWB_N/length(SWB_names) <= 0.5] <- NA
  EWB <- round(rowMeans(items[, EWB_names], na.rm = TRUE) * 6, 3)
  EWB[EWB_N/length(EWB_names) <= 0.5] <- NA
  FWB <- round(rowMeans(items[, FWB_names], na.rm = TRUE) * 7, 3)
  FWB[FWB_N/length(FWB_names) <= 0.5] <- NA
  FACT_GP <- round(PWB + SWB + EWB + FWB, 3)
  FACT_GP[FACT_GP_N/ncol(items) <= 0.8] <- NA

  # rename items to format "ITEM_rc"
  names(items) <- paste0(names(items), "_rc")

  if (updateItems) {                  # BOTH updateItems AND keepNvalid TRUE
    if (keepNvalid) {
      dfOut <- data.frame(df[id], items, PWB_N, SWB_N, EWB_N, FWB_N,
                          FACT_GP_N, PWB, SWB, EWB, FWB, FACT_GP)
    }
    else {                          # updateItems TRUE, keepNvalid FALSE
      dfOut <- data.frame(df[id], items, PWB, SWB, EWB, FWB, FACT_GP)
    }
  }
  else {
    if (keepNvalid) {               # updateItems FALSE, keepNvalid TRUE
      dfOut <- data.frame(df[id], PWB_N, SWB_N, EWB_N, FWB_N,
                          FACT_GP_N, PWB, SWB, EWB, FWB, FACT_GP)
    }
    else {                          # BOTH updateItems AND keepNvalid FALSE
      dfOut <- data.frame(df[id], PWB, SWB, EWB, FWB, FACT_GP)
    }
  }

  return(dfOut)
  }
