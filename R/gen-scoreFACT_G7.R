#' @title Score the FACT-G7
#'
#' @description
#' Scores the 7-item short-form of the Functional Assessment of Cancer
#' Therapy-General (FACT-G7) from item responses.
#'
#'
#' @details
#' Given a data frame that includes all of the FACT-G7 items as variables,
#' appropriately named, this function generates the FACT-G7 scale score.  It is
#' crucial that the item variables in the supplied data frame are named
#' according to FACT conventions.  For example, the first item should be named
#' GP1, the second GP2, and so on.  Please refer to the materials provided by
#' \url{http://www.facit.org} for the particular questionnaire you are using. In
#' particular, refer to the left margin of the official questionnaire (i.e.,
#' from facit.org) for the appropriate item variable names.
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
#' @template paramsFACTG
#'
#'
#' @return A data frame containing the following scale score is returned:
#'
#' \itemize{
#'   \item \strong{FACTG7} - FACT-G7 Total Score
#' }
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#'
#' @references FACT-G7 Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Yanez, B., Pearman, T., Lis, C. G., Beaumont, J. L., & Cella, D. (2013). The
#' FACT-G7: a rapid version of the functional assessment of cancer
#' therapy-general (FACT-G) for monitoring symptoms and concerns in oncology
#' practice and research. \emph{Annals of Oncology}, 24(4), 1073-1078.
#'
#'
#' @aliases scoreFACT_G7 score_FACT_G7 score_FACTG7 scorefactg7 ScoreFACTG7
#'
#'
#' @seealso For additional details on the function arguments, see
#'   \code{\link{scoreFACTG}} and \code{\link{FACTscorer}}.
#'
#'
#' @export
#'
#' @templateVar ITEMS1 'GP1', 'GP4', 'GP2', 'GE6', 'GF5', 'GF3', 'GF7'
#' @templateVar SCOREFUN scoreFACTG7
#' @templateVar NAMESUB FACTG7
#' @template example1score_items1

scoreFACTG7 <- function(df, id = NULL, updateItems = FALSE, keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("GP1", "GP4", "GP2", "GE6", "GF5", "GF3", "GF7"),
    namesRev = c("GP1", "GP4", "GP2", "GE6"),
    nameSub = "FACTG7",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
    )
  return(df_scores)
}

