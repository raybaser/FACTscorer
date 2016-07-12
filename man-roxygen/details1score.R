#' @details
#'   Given a data frame that includes all of the <%= MEASURE %>  items as
#'   variables, appropriately named, this function generates the <%= MEASURE %>
#'   scale score.  It is crucial that the item variables in the supplied data
#'   frame are named according to FACT conventions.  For example, the first item
#'   should be named GP1, the second GP2, and so on.  Please refer to the
#'   materials provided by \url{http://www.facit.org} for the particular
#'   questionnaire you are using. In particular, refer to the left margin of the
#'   official questionnaire (i.e., from facit.org) for the appropriate item
#'   variable names.
#'
#'   For more details on the \code{updateItems} and \code{keepNvalid} arguments,
#'   see the documentation entry for \code{\link{scoreFACTG}} and
#'   \code{\link{FACTscorer}}.
#'
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
#'
#' @return A data frame containing the following scale score is returned:
#'
#' \itemize{
#'   \item \strong{<%= NAMESUB %>} - <%= SCORENAME %>
#' }
#'
#' If a variable was given to the \code{id} argument, then that variable will
#' also be in the returned data frame. Additional, relatively unimportant,
#' variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid
#' = TRUE}.
#'
#' @seealso For additional details on the function arguments, see
#'   \code{\link{scoreFACTG}} and \code{\link{FACTscorer}}.  For brevity,
#'   examples are omitted below.  However, this function is very similar to the
#'   \code{\link{scoreFACTG7}} function.  See the documentation for
#'   \code{\link{scoreFACTG7}} for examples.  Alternatively, examples for
#'   \code{<%= SCOREFUN %>} can be accessed by running
#'   \code{example(<%= SCOREFUN %>)}.



