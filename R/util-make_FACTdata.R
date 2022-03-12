#' @title Make fake FACT-like data to illustrate scoring functions
#'
#'
#' @description
#' Generates FACT-like questionnaire answers for fake respondents.
#'
#'
#' @details
#' This function is used to generate fake responses to FACT/FACIT
#' questionnaires.  It is a utility to generate example data for testing the
#' functions and for demonstrating their usage.  Missing item proportions can be
#' specified separately for the first and second half of respondents in the
#' generated data frame (using \code{pmiss1} and \code{pmiss2}, respectively).
#' If \code{AConly = FALSE}, the default, then FACT-G items will automatically
#' be generated in addition to any "Additional Concerns" (AC) items given to
#' \code{namesAC}.  Set \code{AConly = TRUE} to generate only the AC items.  If
#' \code{namesAC = NULL} (the default), then only FACT-G items will be
#' generated.
#'
#' If \code{AConly = TRUE} then at least 2 item names must be given to
#' \code{namesAC}.
#'
#' @param namesAC Character vector of the "Additional Concerns" item names.
#' @param N An integer specifying how many fake respondents to generate.
#'   Default is 8.
#' @param AConly Logical, if FALSE (the default) the 27 FACT-G items will be
#'   generated in addition to items you supply to \code{namesAC}.  If TRUE, then
#'   only the items you supply to \code{namesAC} are generated.
#' @param pmiss1 The proportion of items with missing answers in the first half
#'   of respondents.
#' @param pmiss2 The proportion of items with missing answers in the second half
#'   of respondents.
#' @param misscode The value used for missing answers. Default is `NA`.
#'   \code{FACTscorer} functions consider values of `NA`, `8`, and `9` to be
#'   missing answers, so these are the only 3 values for this argument useful
#'   for testing \code{FACTscorer} functions.
#' @return
#' A data frame with \code{N} fake respondents (8 by default).  The first half
#' of respondents will have missing values (coded as \code{9}) for roughly 10\%
#' of the items, and the last half will have missing values for roughly 50\% of
#' the items.
#'
#' @export
#'
#' @examples
#' (exampleDat <- make_FACTdata())
#' itemNames <- c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'P2')
#' (exampleDat <- make_FACTdata(namesAC = itemNames))
#' (exampleDat <- make_FACTdata(namesAC = itemNames, AConly = TRUE))
make_FACTdata <- function(namesAC = NULL, N = 8, AConly = FALSE,
                          pmiss1 = 0.10, pmiss2 = 0.50, misscode = NA) {

  ## Setting up item names for fake data
  G_names <- c(paste0('GP', 1:7),
               paste0('GS', 1:7),
               paste0('GE', 1:6),
               paste0('GF', 1:7))
  if (AConly) {
    G_names <- NULL
  }
  itemNames <- c(G_names, namesAC)

  ## If there is only 1 item, then the hacky code below does not work
  if (length(itemNames) == 1) {
    stop("Need more than 1 name in 'namesAC' if 'AConly = TRUE'. ")
  }

  ## Generating random item responses for N fake respondents
  set.seed(6375309)
  exampleDat <- t(replicate(N, sample(0:4, size = length(itemNames), replace = TRUE)))
  ## Making half of respondents missing about 10% of items,
  ## half missing about 50%.
  miss10 <- t(replicate(N*0.5, sample(c(0, 9), prob = c(1 - pmiss1, pmiss1),
                                      size = length(itemNames), replace = TRUE)))
  miss50 <- t(replicate(N*0.5, sample(c(0, 9), prob = c(1 - pmiss2, pmiss2),
                                      size = length(itemNames), replace = TRUE)))
  missMtx <- rbind(miss10, miss50)
  ## Using NA (instead of 9) as the default code for missing responses
  exampleDat[missMtx == 9] <- misscode
  exampleDat <- as.data.frame(cbind(ID = paste0('ID', 1:N),
                                    as.data.frame(exampleDat)))
  names(exampleDat) <- c('ID', itemNames)
  return(exampleDat)
}
