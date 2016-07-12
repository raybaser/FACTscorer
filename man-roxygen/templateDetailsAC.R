#' @details
#'   Given a data frame that includes all of the <%= MEASURE %> (Version
#'   4) items as variables, appropriately named, this function generates all of
#'   the <%= MEASURE %> scale scores.  It is crucial that the item variables in
#'   the supplied data frame are named according to FACT conventions.  For
#'   example, the first physical well-being item should be named GP1, the second
#'   GP2, and so on. Please refer to the materials provided by
#'   \url{http://www.facit.org} for the particular questionnaire you are using.
#'   In particular, refer to the left margin of the official questionnaire
#'   (i.e., from facit.org) for the appropriate item variable names.
#'
#'   This questionnaire consists of two components: (1) FACT-G items and (2)
#'   "Additional Concerns" items.  The FACT-G items (G for General) measure
#'   general aspects of QoL common to all cancer patients. The "Additional
#'   Concerns" items measure issues relevant for a specific cancer type,
#'   treatment, or symptom. These two questionnaire components are typically
#'   administered together. In some studies, however, ONLY the "Additional
#'   Concerns" items are administered. The \code{AConly} argument is provided to
#'   accommodate such cases, and should be set to \code{AConly = TRUE} if ONLY
#'   the "Additional Concerns" items were administered.
#'
#'   For more details on the \code{updateItems} and \code{keepNvalid} arguments,
#'   see the documentation entry for \code{\link{scoreFACTG}} and
#'   \code{\link{FACTscorer}}.
#'
#' @section Note:
#'   Keep in mind that this function (and R in general) is
#'   case-sensitive.
#'
#'   All items in \code{df} should be \code{numeric} (i.e., of type
#'   \code{integer} or \code{double}).
#'
#'   This function expects missing item responses to be coded as \code{NA},
#'   \code{8}, or \code{9}, and valid item responses to be coded as \code{0},
#'   \code{1}, \code{2}, \code{3}, or \code{4}.  Any other value for any of the
#'   items will result in an error message and no scores.
#'
#' @seealso This function is very similar to the \code{\link{scoreFACT_B}}
#'   function.  See the documentation for \code{\link{scoreFACT_B}} for more
#'   details on the arguments and for examples.  Also see the documentation
#'   entry for the \code{\link{FACTscorer}} package.  For brevity, examples are
#'   omitted below, but can be accessed by running
#'   \code{example(<%= SCOREFUN %>)}.

