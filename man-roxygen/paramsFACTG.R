#' @param df A data frame with the questionnaire items, appropriately-named.
#'
#' @param id (optional) The quoted name of a variable in \code{df} with a unique
#'   value for each row of \code{df}. If an \code{id} variable is provided
#'   here, it will also be included with the scale scores in the output data
#'   frame. This can facilitate accurate merging of the scale scores back into
#'   the input \code{df}.
#'
#' @param updateItems (optional) Logical, if \code{TRUE} then updated versions
#'   of the items (i.e., re-coded for score calculation) will be returned in the
#'   output data frame with the scale scores. The default, \code{FALSE}, does
#'   not save any updated versions of the items in the resulting data frame.
#'   Most users will want to omit this argument or, equivalently, set it to
#'   \code{FALSE}.
#'
#' @param keepNvalid (optional) Logical, if \code{TRUE} then the output data
#'   frame will have additional variables containing the number of valid,
#'   non-missing responses from each respondent to the items on a given scale
#'   (see Details). If \code{FALSE} (the default), these variables will not be
#'   in the returned data frame. Most users will want to omit this argument
#'   or, equivalently, set it to \code{FALSE}.
