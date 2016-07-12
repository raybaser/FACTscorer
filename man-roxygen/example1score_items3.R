#' @examples
#' ## FIRST creating a df with fake item data to score
#' itemNames <- c(<%= ITEMS1 %>
#'   <%= ITEMS2 %>
#'   <%= ITEMS3 %>)
#' exampleDat <- make_FACTdata(namesAC = itemNames, AConly = TRUE)
#'
#' ## NOW scoring the items in exampleDat
#'
#' ## Returns data frame with ONLY scale score
#' (scoredDat <- <%= SCOREFUN %>(exampleDat))
#'
#' ## Using the id argument (makes merging with original data more fool-proof):
#' (scoredDat <- <%= SCOREFUN %>(exampleDat, id = "ID"))
#'
#' ## Merge back with original data, exampleDat:
#' mergeDat <- merge(exampleDat, scoredDat, by = "ID")
#' names(mergeDat)
#'
#' ## Returns scale score, plus recoded items (updateItems = TRUE)
#' ## Also illustrates effect of setting keepNvalid = TRUE.
#' scoredDat <- <%= SCOREFUN %>(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
#' names(scoredDat)
#' ## Descriptives of scored scales
#' summary(scoredDat['<%= NAMESUB %>'])
