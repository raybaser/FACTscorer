#' @title Score the FACIT-AI
#'
#' @description
#' Scores the Functional Assessment of Chronic Illness Therapy-Ascites Index
#' (FACIT-AI) from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACIT-AI
#' @templateVar NAMESUB FACIT_AI
#' @templateVar SCORENAME FACIT Ascites Index
#' @templateVar SCOREFUN scoreFACIT_AI
#' @template details1score
#'
#' @templateVar ITEMS1 'C6', 'GF5', 'BMT5', 'B1', 'GP2', 'O2', 'ACT11', 'O1',
#' @templateVar ITEMS2 'GP1', 'ACT10', 'BL2', 'CX6', 'AI1'
#' @template example1score_items2
#'
#'
#' @references FACIT-AI Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
scoreFACIT_AI <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("C6", "GF5", "BMT5", "B1", "GP2", "O2", "ACT11", "O1",
                "GP1", "ACT10", "BL2", "CX6", "AI1"),
    namesRev = c("B1", "GP2", "O2", "ACT11", "O1", "GP1", "ACT10", "BL2",
                 "CX6", "AI1"),
    nameSub = "FACIT_AI",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
