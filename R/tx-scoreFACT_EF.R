#' @title Score the FACT-EF
#'
#' @description
#' Scores the Functional Assessment of Cancer Therapy -
#' for patients receiving Enteral Feeding (FACT-EF) from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACT-EF
#' @templateVar NAMESUB FACT_EF
#' @templateVar SCORENAME FACT Enteral Feeding Subscale
#' @templateVar SCOREFUN scoreFACT_EF
#' @template details1score
#'
#' @templateVar ITEMS1 'EF1', 'EF2', 'EF3', 'EF4', 'EF5', 'EF6', 'EF7', 'EF8',
#' @templateVar ITEMS2 'EF9', 'EF10', 'EF11', 'EF12', 'EF13', 'EF14', 'EF15',
#' @templateVar ITEMS3 'EF16', 'EF17', 'EF18', 'EF19', 'EF20'
#' @template example1score_items3
#'
#'
#' @references FACT-EF Scoring Guidelines, available at \url{http://www.facit.org}
#'
#'
#' @export
scoreFACT_EF <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("EF1", "EF2", "EF3", "EF4", "EF5", "EF6", "EF7", "EF8",
                "EF9", "EF10", "EF11", "EF12", "EF13", "EF14", "EF15", "EF16",
                "EF17", "EF18", "EF19", "EF20"),
    namesRev = c("EF2", "EF3", "EF4", "EF5", "EF6", "EF7", "EF9", "EF11",
                 "EF12", "EF13", "EF14", "EF15", "EF16", "EF17", "EF18"),
    nameSub = "FACT_EF",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
