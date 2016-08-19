#' @title Score the FACT/GOG-Ntx4
#'
#' @description
#' Scores the 4-item version of the Functional Assessment of Cancer
#' Therapy-Neurotoxicity (FACT/GOG-Ntx4) from item responses.
#'
#'
#' @template paramsFACTG
#'
#'
#' @templateVar MEASURE FACT/GOG-Ntx4
#' @templateVar NAMESUB NtxS4
#' @templateVar SCORENAME FACT/GOG-Ntx-4 subscale
#' @templateVar SCOREFUN scoreFACTGOG_Ntx4
#' @template details1score
#'
#' @templateVar ITEMS1 'Ntx1', 'Ntx2', 'Ntx3', 'Ntx4'
#' @template example1score_items1
#'
#'
#' @references FACT/GOG-Ntx4 Scoring Guidelines, available at
#'   \url{http://www.facit.org}
#'
#' Huang HQ, Brady MF, Cella D, Fleming G. Validation and reduction of
#' FACT/GOG-Ntx subscale for platinum/paclitaxel-induced neurologic symptoms: a
#' gynecologic oncology group study. \emph{Int J Gynecol Cancer}.
#' 2007;17(2):387-393.
#' @export
scoreFACTGOG_Ntx4 <- function(df, id = NULL, updateItems = FALSE,
                          keepNvalid = FALSE){

  df_scores <- scoreFACT_any(
    df = df,
    id = id,
    namesAC = c("Ntx1", "Ntx2", "Ntx3", "Ntx4"),
    namesRev = c("Ntx1", "Ntx2", "Ntx3", "Ntx4"),
    nameSub = "NtxS4",
    AConly = TRUE,
    updateItems = updateItems,
    keepNvalid = keepNvalid
  )
  return(df_scores)
}
