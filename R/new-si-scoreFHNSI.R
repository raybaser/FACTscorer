#' @title Score the FHNSI
#'
#' @description
#' Scores the Functional Assessment of Cancer Therapy-Head & Neck Symptom Index
#' (FHNSI) from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FHNSI
#' @templateVar NAMESUB FHNSI
#' @templateVar SCORENAME FACT Head and Neck Symptom Index
#' @templateVar SCOREFUN scoreFHNSI
#' @template details1score
#'
#' @templateVar ITEMS1 'GP4', 'GP1', 'HN7', 'HN12', 'HN3', 'HN10', 'GP2', 'HN11',
#' @templateVar ITEMS2 'GE6', 'GF7'
#' @template example1score_items2
#'
#'
#' @references FHNSI Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
scoreFHNSI <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("GP4", "GP1", "HN7", "HN12", "HN3", "HN10", "GP2", "HN11",
                "GE6", "GF7"),
    namesRev = c("GP4", "GP1", "HN12", "HN3", "GP2", "GE6"),
    nameSub = "FHNSI",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
