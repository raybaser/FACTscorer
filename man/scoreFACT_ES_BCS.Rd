% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sx-scoreFACT_ES_BCS.R
\name{scoreFACT_ES_BCS}
\alias{scoreFACT_ES_BCS}
\title{Score the FACT-ES-BCS}
\usage{
scoreFACT_ES_BCS(df, updateItems = FALSE, keepNvalid = FALSE)
}
\arguments{
\item{df}{A data frame with the FACT-ES items, appropriately-named.}

\item{updateItems}{Logical, if \code{TRUE} any original item that is
reverse coded for scoring will be replaced by its reverse coded version
in the returned data frame, and any values of 8 or 9 will be replaced
with NA.  The default, \code{FALSE}, returns the original items
unmodified.}

\item{keepNvalid}{Logical, if \code{TRUE} the function
returns an additional variable for each of the returned scale scores
containing the number of valid, non-missing responses from each
respondent to the items on the given scale.  If \code{FALSE} (the
default), these variables are omitted from the returned data frame.}
}
\value{
The original data frame is returned (optionally with modified
items if \code{updateItems = TRUE}) with new variables corresponding to
the scored scales. If \code{keepNvalid = TRUE}, for each scored scale an
additional variable is returned that contains the number of valid
responses each respondent made to the items making up the given scale.
These optional variables have names of the format \code{SCALENAME_N}.
The following scale scores are returned:

\describe{
\item{PWB}{Physical Well-Being subscale}
\item{SWB}{Social/Family Well-Being subscale}
\item{EWB}{Emotional Well-Being subscale}
\item{FWB}{Physical Well-Being subscale}
\item{FACTG}{FACT-G Total Score (i.e., PWB+SWB+EWB+FWB)}
\item{ESS_19}{19-item Endocrine Symptom subscale}
\item{ESS_23}{23-item Endocrine Symptom subscale}
\item{BCS}{Breast Cancer subscale}
\item{FACT_ES_TOTAL}{FACT-ES Total Score (i.e., PWB+SWB+EWB+FWB+ESS_19+ESS_23+BCS)}
\item{FACT_ES_TOI}{FACT-ES Trial Outcome Index (e.g., PWB+FWB+ESS_19+ESS_23+BCS)}
}
}
\description{
Generates all of the scores of the Functional Assessment of Cancer Therapy -
Endocrine Symptom with Breast Cancer Subscale (FACT-ES-BCS, v4)
from item responses.
}
\details{
Given a data frame that includes all of the FACT-ES-BCS (Version 4) items as
variables, appropriately named, this function generates all of the FACT-ES
scale scores.  It is crucial that the item variables in the supplied data
frame are named according to FACT conventions.  For example, the first
physical well-being item should be named GP1, the second GP2, and so on.
Please refer to the materials provided by \url{http://www.facit.org} for the
particular questionnaire you are using.  In particular, refer to the left
margin of the official questionnaire (i.e., from facit.org) for the
appropriate item variable names.
}
\section{Note}{

Keep in mind that this function (and R in general) is case-sensitive.

All variables should be in numeric or integer format.

This scoring function expects missing item responses to be coded as NA,
8, or 9, and valid item responses to be coded as 0, 1, 2, 3, or 4.  Any
other value for any of the items will result in an error message and no
scores.

Some item variables are reverse coded for the purpose of generating the
scale scores.  The official (e.g., from \url{http://www.facit.org}) SAS
and SPSS scoring algorithms for this questionnaire automatically replace
the original items with their reverse-coded versions.  This can be
confusing if you accidentally run the algorithm more than once on your
data.  As its default, \code{scoreFACT_ES} DOES NOT replace any of your
original item variables with the reverse coded versions.  However, for
consistentcy with the behavior of the other versions on
\url{http://www.facit.org}, the \code{updateItems} argument is
provided.  If set to \code{TRUE}, any item that is supposed to be
reverse coded will be replaced with its reversed version in the data
frame returned by \code{scoreFACT_ES}.
}

\examples{
## Setting up item names for fake data
G_names <- c(paste0('GP', 1:7),
             paste0('GS', 1:7),
             paste0('GE', 1:6),
             paste0('GF', 1:7))
AC_names1 <- c('ES1', 'ES2', 'ES3', 'ES4', 'ES5', 'ES6', 'ES7', 'ES8', 'ES9', 'ES10',
               'An9', 'O2', 'C5', 'An10', 'Tax1', 'ES11', 'ES12', 'ES13', 'BRM1')
AC_names2 <- c('ES1', 'ES2', 'ES3', 'ES4', 'ES5', 'ES6', 'ES7', 'ES8', 'ES9', 'ES10',
               'An9', 'O2', 'C5', 'An10', 'Tax1', 'ES11', 'ES12', 'ES13', 'BRM1',
               'GP1', 'GP2', 'GE4', 'GF5')
AC_names3 <- c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9')
AC_names <- c(AC_names1, AC_names2, AC_names3)
itemNames <- c(G_names, AC_names)
## Generating random item responses for 8 fake respondents
set.seed(6375309)
exampleDat <- t(replicate(8, sample(0:4, size = length(itemNames), replace = TRUE)))
## Making half of respondents missing about 10\% of items,
## half missing about 50\%.
miss10 <- t(replicate(4, sample(c(0, 9), prob = c(0.9, 0.1),
    size = length(itemNames), replace = TRUE)))
miss50 <- t(replicate(4, sample(c(0, 9), prob = c(0.5, 0.5),
    size = length(itemNames), replace = TRUE)))
missMtx <- rbind(miss10, miss50)
## Using 9 as the code for missing responses
exampleDat[missMtx == 9] <- 9
exampleDat <- as.data.frame(cbind(ID = paste0('ID', 1:8),
    as.data.frame(exampleDat)))
names(exampleDat) <- c('ID', itemNames)

## Returns data frame with scale scores and with original items untouched
scoredDat <- scoreFACT_ES_BCS(exampleDat)
names(scoredDat)
scoredDat
## Returns data frame with scale scores, with the appropriate items
## reverse scored, and with item values of 8 and 9 replaced with NA.
## Also illustrates the effect of setting keepNvalid = TRUE.
scoredDat <- scoreFACT_ES_BCS(exampleDat, updateItems = TRUE, keepNvalid = TRUE)
names(scoredDat)
## Descriptives of scored scales
summary(scoredDat[, c('PWB', 'SWB', 'EWB', 'FWB', 'FACTG',
                      'ESS_19', 'ESS_23', 'BCS', 'FACT_ES_TOTAL', 'FACT_B_TOI')])
}
\references{
FACT-ES Scoring Guidelines, available at \url{http://www.facit.org}
}
