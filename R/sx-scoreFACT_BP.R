#' @title Score the FACT-BP
#'
#' @description
#' Scores the Functional Assessment of Cancer Therapy - Bone Pain (FACT-BP)
#' from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACT-BP
#' @templateVar NAMESUB FACT_BP
#' @templateVar SCORENAME FACT Bone Pain
#' @templateVar SCOREFUN scoreFACT_BP
#' @template details1score
#'
#' @templateVar ITEMS1 'GF7', 'P2', 'BP1', 'BP2', 'BP3', 'BP4', 'BP5', 'BP6', 'BP7',
#' @templateVar ITEMS2 'BP8', 'BP9', 'BP10', 'BP11', 'BP12', 'BP13'
#' @template example1score_items2
#'
#'
#' @references FACT-BP Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
scoreFACT_BP <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("GF7", "P2", "BP1", "BP2", "BP3", "BP4", "BP5", "BP6",
                "BP7", "BP8", "BP9", "BP10", "BP11", "BP12", "BP13"),
    namesRev = c("P2", "BP1", "BP2", "BP3", "BP4", "BP5", "BP6", "BP7",
                 "BP8", "BP9", "BP10", "BP11", "BP12", "BP13"),
    nameSub = "FACT_BP",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
