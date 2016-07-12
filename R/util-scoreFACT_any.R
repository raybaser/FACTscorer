
#' @title Master function to score most FACT/FACIT instruments
#'
#'
#' @details
#' This is the workhorse function called by most of the other functions in this
#' package.  It can score the majority of the instruments in the FACT/FACIT
#' family of questionnaires.  Specifically, it can score any instrument that
#' fits one of these two formats:
#' \enumerate{
#'   \item \strong{FACT-G + AC}: Measures comprised of the FACT-G (General)
#'   items plus a set of "Additional Concerns" (AC) items that produce a single
#'   subscale score.  Most of the FACT/FACIT instruments conform to this format,
#'   and follow a uniform scoring procedure that produces all of the FACT-G
#'   scores (PWB, SWB, EWB, FWB, and FACT-G Total Score), the AC subscale score
#'   (AC_SUB), the AC-specific Trial Outcome Index (TOI, PWB+FWB+AC_SUB), and the
#'   AC-specific Total Score (PWB+SWB+EWB+FWB+AC_SUB).
#'   \item \strong{AC Only}: Measures comprised of only "Additional Concerns"
#'   (AC) items (or any set of items) that produce a single score.  This is
#'   relevant for cases in which \strong{only} the AC items were administered
#'   from a more comprehensive instrument (e.g., one that originally included
#'   FACT-G + AC items).  This is also relevant for some of the symptom indexes
#'   and other single-score measures.  These AC-only and single-score measures
#'   can be scored by setting \code{AConly = TRUE}.
#'   }
#'
#'
#' @param namesAC A character vector of quoted variable names.
#' @param namesRev A character vector of quoted variable names (or a single
#'   quoted variable name) that should be reverse scored.  The variable names
#'   must be among those given to the \code{namesAC} argument.
#' @param nameSub (optional) A single quoted name that will become the name of
#'   the scored AC subscale.  If this argument is omitted, the default value
#'   will be used, \code{"AC_SUB"}.
#' @param nameTot (optional) A single quoted name that will form the root of the
#'   "_TOTAL" and "_TOI" score names.  For example, if \code{nameTot = "FACT_B"}
#'   then the names in the resulting data frame will be \code{"FACT_B_TOTAL"}
#'   and \code{"FACT_B_TOI"}.  If this argument is omitted, the default value
#'   will be used, \code{"FACT_AC"}.
#' @param AConly (optional) Logical, if omitted or set to \code{FALSE} (the
#'   default) then the function will expect \code{df} to contain the
#'   FACT-General items as well as the items given to \code{namesAC}.  If
#'   \code{TRUE}, then the function will only find the items given to
#'   \code{namesAC} in \code{df}, and will only score the subscale produced by
#'   those items.
#'
#' @inheritParams scoreFACTG
#'
#' @return A data frame with the following scale scores is returned:
#'
#' \itemize{
#'   \item \strong{PWB} - Physical Well-Being subscale
#'   \item \strong{SWB} - Social/Family Well-Being subscale
#'   \item \strong{EWB} - Emotional Well-Being subscale
#'   \item \strong{FWB} - Physical Well-Being subscale
#'   \item \strong{FACTG} - FACT-G Total Score (PWB+SWB+EWB+FWB)
#'   \item \strong{AC_SUB} - AC subscale score
#'   \item \strong{FACT_AC_TOTAL} - The AC-Specific Total Score (PWB+SWB+EWB+FWB+AC_SUB)
#'   \item \strong{FACT_AC_TOI} - The AC-Specific Trial Outcome Index (PWB+FWB+AC_SUB)
#' }
#'
#' If \code{AConly = TRUE}, the only scale score returned is \strong{AC_SUB}.
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
#' TRUE}.
#'
#' @export
#'
#' @examples
#' ## Create vectors of item names
#' FACT_B_names <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "P2")
#' FACT_B_rev   <- c("B1", "B2", "B3", "B5", "B6", "B7", "B8", "P2")
#' ## Make example data
#' exampleDat <- make_FACTdata(namesAC = FACT_B_names)
#'
#' ## Score FACT-G + AC items
#' scoredDat <- scoreFACT_any(df = exampleDat,
#'                namesAC = FACT_B_names,
#'                namesRev = FACT_B_rev,
#'                nameSub = "BCS",
#'                nameTot = "FACT_B")
#' scoredDat
#'
#' ## Score only AC items
#' scoredDat <- scoreFACT_any(df = exampleDat,
#'                namesAC = FACT_B_names,
#'                namesRev = FACT_B_rev,
#'                nameSub = "BCS",
#'                AConly = TRUE)
#' scoredDat
scoreFACT_any <- function(df,
                          id = NULL,
                          namesAC = NULL,
                          namesRev = NULL,
                          nameSub = "XX_SUB",
                          nameTot = "FACT_XX",
                          AConly = FALSE,
                          updateItems = FALSE,
                          keepNvalid = FALSE)  {

  ## Test whether id (if given) is in df.
  if (!is.null(id)) {
    if (!(id %in% names(df))) {
      stop("Cannot find your id variable name in your df.
           Make sure it is typed correctly, and in quotes.
           Or just omit the id argument, since it is optional.")
      break
    }
  }

  ## Require namesAC to be non-null
  if (is.null(namesAC)) {
    stop("Please give item names to the 'namesAC' argument.")
    break
  }
  ## Test whether namesAC or toupper(namesAC) is in df.
  if (!is.null(namesAC)) {
    if (!all(namesAC %in% names(df)) && !all(toupper(namesAC) %in% names(df))) {
      stop("At least 1 of the 'namesAC' variable names is not in your df.
           Make sure they are typed correctly, and each in quotes.")
      break
    }
  }

  ## Warn if no namesRev given
  if (is.null(namesRev)) {
    warning(paste(strwrap(
      "You did not give any names to 'namesRev'. Are you ABSOLUTELY SURE no
      items should be reverse scored?  Just checking.  Neglecting to reverse
      score items that need reversing is a common source of scoring errors.",
      initial = "HEY! ", indent = 0, exdent = 7, width = 70
      ), collapse = "\n")
    , immediate. = TRUE)
  }

  ## Prep the AC items, regardless of AConly value
  # dfAC <- df
  names(df) <- toupper(names(df))
  namesG <- c(paste0("GP", 1:7), paste0("GS", 1:7), paste0("GE", 1:6),
               paste0("GF", 1:7))
  namesG <- paste0(namesG, "_rc")
  namesAC <- toupper(namesAC)
  namesRev <- toupper(namesRev)
  AC_items <- df[namesAC]
  if (any(!(as.matrix(AC_items) %in% c(0:4, 8, 9, NA)))) {
    stop("At least 1 response is out of range (i.e., not 0-4, 8, 9, or NA)")
    break
  }
  makeMiss <- function(x) {
    x[x %in% c(8, 9)] <- NA
    return(x)
  }
  AC_items <- data.frame(lapply(AC_items, makeMiss))
  revHelper <- function(x) {
    return(4 - x)
  }
  AC_items[namesRev] <- lapply(AC_items[namesRev], revHelper)
  valid_N <- data.frame(lapply(AC_items, function(x) as.numeric(!is.na(x))))
  AC_N <- rowSums(valid_N[namesAC])

  ## score AC
  AC <- round(rowMeans(AC_items[namesAC], na.rm = TRUE)*length(namesAC), 3)
  AC[AC_N/length(namesAC) <= 0.5] <- NA

  # rename AC_items to format "ITEM_rc"
  names(AC_items) <- paste0(names(AC_items), "_rc")

  ## AConly == FALSE (default)
  if (AConly == FALSE) {
    dfG <- scoreFACTG(df, updateItems = updateItems, keepNvalid = TRUE)

    TOTAL_N <- dfG$PWB_N + dfG$SWB_N + dfG$EWB_N + dfG$FWB_N + AC_N
    TOTAL <- dfG$PWB + dfG$SWB + dfG$EWB + dfG$FWB + AC
    TOTAL[TOTAL_N/length(c(namesG, namesAC)) <= 0.8] <- NA
    TOI <- dfG$PWB + dfG$FWB + AC

    # make data frames with AC components
    dfAC_N <- data.frame(AC_N, TOTAL_N)
    dfAC_scores <- data.frame(AC, TOTAL, TOI)

    # assign names using the user input
    names(dfAC_N) <- c(paste0(nameSub, "_N"), paste0(nameTot, "_TOTAL_N"))
    names(dfAC_scores) <- c(nameSub, paste0(nameTot, "_TOTAL"), paste0(nameTot, "_TOI"))

    # make names indexing parts of FACT-G output (G items already in "namesG")
    gnames_scores <- c("PWB", "SWB", "EWB", "FWB", "FACTG")
    gnames_N <- c("PWB_N", "SWB_N", "EWB_N", "FWB_N", "FACTG_N")

    if (updateItems) {            # BOTH updateItems AND keepNvalid TRUE
      if (keepNvalid) {
        dfOut <- data.frame(df[id], dfG[namesG], AC_items, dfG[gnames_N],
                            dfAC_N, dfG[gnames_scores], dfAC_scores)
      }
      else {                      # updateItems TRUE, keepNvalid FALSE
        dfOut <- data.frame(df[id], dfG[namesG], AC_items,
                            dfG[gnames_scores], dfAC_scores)
      }
    }
    else {
      if (keepNvalid) {           # updateItems FALSE, keepNvalid TRUE
        dfOut <- data.frame(df[id], dfG[gnames_N], dfAC_N,
                            dfG[gnames_scores], dfAC_scores)
      }
      else {                      # BOTH updateItems AND keepNvalid FALSE
        dfOut <- data.frame(df[id], dfG[gnames_scores], dfAC_scores)
      }
    }
  }

    ## AConly == TRUE
    if (AConly == TRUE) {
      ## replace generic names with scale-specific names
      BCS_N <- AC_N
      BCS <- AC

      # make data frames with AC components
      dfAC_N <- data.frame(BCS_N)
      dfAC_scores <- data.frame(BCS)

      # assign names using the user input
      names(dfAC_N) <- paste0(nameSub, "_N")
      names(dfAC_scores) <- nameSub

      if (updateItems) {            # BOTH updateItems AND keepNvalid TRUE
        if (keepNvalid) {
          dfOut <- data.frame(df[id], AC_items, dfAC_N, dfAC_scores)
        }
        else {                      # updateItems TRUE, keepNvalid FALSE
          dfOut <- data.frame(df[id], AC_items, dfAC_scores)
        }
      }
      else {
        if (keepNvalid) {           # updateItems FALSE, keepNvalid TRUE
          dfOut <- data.frame(df[id], dfAC_N, dfAC_scores)
        }
        else {                      # BOTH updateItems AND keepNvalid FALSE
          dfOut <- data.frame(df[id], dfAC_scores)
        }
      }
    }
    return(dfOut)
  }




