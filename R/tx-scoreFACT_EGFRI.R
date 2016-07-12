#' @title Score the FACT-EGFRI
#'
#' @description
#' Scores the Functional Assessment of Cancer Therapy - 
#' for patients treated with EGFR Inhibitors (FACT-EGFRI) from item responses.
#'
#' 
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACIT-EGFRI
#' @templateVar NAMESUB FACIT_EGFRI
#' @templateVar SCORENAME FACT EGFR Inhibitors
#' @templateVar SCOREFUN scoreFACT_EGFRI
#' @template details1score
#'
#' @templateVar ITEMS1 'ST4', 'ST5', 'ST6', 'ST7', 'ST9', 'ST32', 'ST22', 'ST17', 'ST24', 
#' @templateVar ITEMS2 'ST37', 'ST26', 'ST34', 'ST38', 'ST16', 'ST15', 'ST29', 'B5', 'ST11'
#' @template example1score_items2
#'
#'
#' @references FACT-EGFRI Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#'
#' @export
scoreFACT_EGFRI <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){
  
  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("ST4", "ST5", "ST6", "ST7", "ST9", "ST32", "ST22", 
                "ST17", "ST24", "ST37", "ST26", "ST34", "ST38", "ST16", "ST15", 
                "ST29", "B5", "ST11"),
    namesRev = c("ST4", "ST5", "ST6", "ST7", "ST9", "ST32", "ST22", "ST17", 
                 "ST24", "ST37", "ST26", "ST34", "ST38", "ST16", "ST15", "ST29", 
                 "B5", "ST11"),
    nameSub = "FACIT_EGFRI",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
