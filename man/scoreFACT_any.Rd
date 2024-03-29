% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util-scoreFACT_any.R
\name{scoreFACT_any}
\alias{scoreFACT_any}
\title{Master function to score most FACT/FACIT instruments}
\usage{
scoreFACT_any(
  df,
  id = NULL,
  namesAC = NULL,
  namesRev = NULL,
  nameSub = "XX_SUB",
  nameTot = "FACT_XX",
  AConly = FALSE,
  updateItems = FALSE,
  keepNvalid = FALSE
)
}
\arguments{
\item{df}{A data frame with the questionnaire items, appropriately-named.}

\item{id}{(optional) The quoted name of a variable in \code{df} with a unique
value for each row of \code{df}. If an \code{id} variable is provided
here, it will also be included with the scale scores in the output data
frame. This can facilitate accurate merging of the scale scores back into
the input \code{df}.}

\item{namesAC}{A character vector of quoted variable names.}

\item{namesRev}{A character vector of quoted variable names (or a single
quoted variable name) that should be reverse scored.  The variable names
must be among those given to the \code{namesAC} argument.}

\item{nameSub}{(optional) A single quoted name that will become the name of
the scored AC subscale.  If this argument is omitted, the default value
will be used, \code{"AC_SUB"}.}

\item{nameTot}{(optional) A single quoted name that will form the root of the
"_TOTAL" and "_TOI" score names.  For example, if \code{nameTot = "FACT_B"}
then the names in the resulting data frame will be \code{"FACT_B_TOTAL"}
and \code{"FACT_B_TOI"}.  If this argument is omitted, the default value
will be used, \code{"FACT_AC"}.}

\item{AConly}{(optional) Logical, if omitted or set to \code{FALSE} (the
default) then the function will expect \code{df} to contain the
FACT-General items as well as the items given to \code{namesAC}.  If
\code{TRUE}, then the function will only find the items given to
\code{namesAC} in \code{df}, and will only score the subscale produced by
those items.}

\item{updateItems}{(optional) Logical, if \code{TRUE} then updated versions
of the items (i.e., re-coded for score calculation) will be returned in the
output data frame with the scale scores. The default, \code{FALSE}, does
not save any updated versions of the items in the resulting data frame.
Most users will want to omit this argument or, equivalently, set it to
\code{FALSE}.}

\item{keepNvalid}{(optional) Logical, if \code{TRUE} then the output data
frame will have additional variables containing the number of valid,
non-missing responses from each respondent to the items on a given scale
(see Details). If \code{FALSE} (the default), these variables will not be
in the returned data frame. Most users will want to omit this argument
or, equivalently, set it to \code{FALSE}.}
}
\value{
A data frame with the following scale scores is returned:

\itemize{
\item \strong{PWB} - Physical Well-Being subscale
\item \strong{SWB} - Social/Family Well-Being subscale
\item \strong{EWB} - Emotional Well-Being subscale
\item \strong{FWB} - Physical Well-Being subscale
\item \strong{FACTG} - FACT-G Total Score (PWB+SWB+EWB+FWB)
\item \strong{AC_SUB} - AC subscale score
\item \strong{FACT_AC_TOTAL} - The AC-Specific Total Score (PWB+SWB+EWB+FWB+AC_SUB)
\item \strong{FACT_AC_TOI} - The AC-Specific Trial Outcome Index (PWB+FWB+AC_SUB)
}

If \code{AConly = TRUE}, the only scale score returned is \strong{AC_SUB}.

If a variable was given to the \code{id} argument, then that variable will
also be in the returned data frame. Additional, relatively unimportant,
variables will be returned if \code{updateItems = TRUE} or \code{keepNvalid =
TRUE}.
}
\description{
Master function to score most FACT/FACIT instruments
}
\details{
This is the workhorse function called by most of the other functions in this
package.  It can score the majority of the instruments in the FACT/FACIT
family of questionnaires.  Specifically, it can score any instrument that
fits one of these two formats:
\enumerate{
\item \strong{FACT-G + AC}: Measures comprised of the FACT-G (General)
items plus a set of "Additional Concerns" (AC) items that produce a single
subscale score.  Most of the FACT/FACIT instruments conform to this format,
and follow a uniform scoring procedure that produces all of the FACT-G
scores (PWB, SWB, EWB, FWB, and FACT-G Total Score), the AC subscale score
(AC_SUB), the AC-specific Trial Outcome Index (TOI, PWB+FWB+AC_SUB), and the
AC-specific Total Score (PWB+SWB+EWB+FWB+AC_SUB).
\item \strong{AC Only}: Measures comprised of only "Additional Concerns"
(AC) items (or any set of items) that produce a single score.  This is
relevant for cases in which \strong{only} the AC items were administered
from a more comprehensive instrument (e.g., one that originally included
FACT-G + AC items).  This is also relevant for some of the symptom indexes
and other single-score measures.  These AC-only and single-score measures
can be scored by setting \code{AConly = TRUE}.
}
}
\examples{
## Create vectors of item names
FACT_B_names <- c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "P2")
FACT_B_rev   <- c("B1", "B2", "B3", "B5", "B6", "B7", "B8", "P2")
## Make example data
exampleDat <- make_FACTdata(namesAC = FACT_B_names)

## Score FACT-G + AC items
scoredDat <- scoreFACT_any(df = exampleDat,
               namesAC = FACT_B_names,
               namesRev = FACT_B_rev,
               nameSub = "BCS",
               nameTot = "FACT_B")
scoredDat

## Score only AC items
scoredDat <- scoreFACT_any(df = exampleDat,
               namesAC = FACT_B_names,
               namesRev = FACT_B_rev,
               nameSub = "BCS",
               AConly = TRUE)
scoredDat
}
