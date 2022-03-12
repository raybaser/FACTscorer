#' @title Score the FACIT-Fatigue
#'
#' @description
#' Scores the Functional Assessment of Chronic Illness Therapy-Fatigue
#' (FACIT-Fatigue) from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACIT-Fatigue
#' @templateVar NAMESUB FACIT_Fatigue
#' @templateVar SCORENAME FACIT Fatigue
#' @templateVar SCOREFUN scoreFACIT_Fatigue
#' @template details1score
#'
#' @templateVar ITEMS1 'HI7', 'HI12', 'An1', 'An2', 'An3', 'An4', 'An5', 'An7', 'An8',
#' @templateVar ITEMS2 'An12', 'An14', 'An15', 'An16'
#' @template example1score_items2
#'
#'
#' @references FACIT-Fatigue Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
scoreFACIT_Fatigue <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("HI7", "HI12", "An1", "An2", "An3", "An4",
                "An5", "An7", "An8", "An12", "An14", "An15", "An16"),
    namesRev = c("HI7", "HI12", "An1", "An2", "An3", "An4", "An8",
                 "An12", "An14", "An15", "An16"),
    nameSub = "FACIT_Fatigue",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
