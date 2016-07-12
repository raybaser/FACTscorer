#' FACTscorer
#'
#' Scores the FACT and FACIT family of QoL patient-reported outcome measures
#'
#' Provides functions to score the Functional Assessment of Cancer Therapy
#' (FACT) and Functional Assessment of Chronic Illness Therapy (FACIT)
#' patient-reported outcome (PRO) measures.  The questionnaires themselves can
#' be downloaded from www.FACIT.org.  For most of the FACIT questionnaires,
#' FACIT.org provides scoring syntax for use with commercial statistical
#' software (SAS and SPSS).  The FACTscorer R package is intented to serve as
#' a free, reliable alternative for those without access to SAS or SPSS.
#' Additionally, it will allow R users to both score and analyze the FACT and
#' FACIT scales in R, avoiding the time-consuming and and error-prone process
#' of transferring the data back-and-forth between statistical softwares.
#' Finally, use of the FACTscorer package will prevent many sources of scoring
#' error common when using SAS and/or SPSS syntax (e.g., copy-paste errors and
#' other accidental modifications to the syntax).
#'
#' @section Questionnaire Groups:
#' The FACT and FACIT questionnaires are grouped into a number of categories
#' according to their intended use.  To help you find the function you need to
#' score your questionnaire, all \code{FACTscorer} functions are listed below,
#' organized by questionnaire type.
#'
#' General, Disease-Specific,
#' Treatment-Specific, Symptom-Specific,
#'
#' \subsection{General Measures:}{
#'
#' RAY:  Look up source of packages with documentation of this sort.  Maybe
#' sjPlot, rapporter, etc.  Figure out best format to list the functions and
#' descriptions here.
#' }
#'
#' @section Missing/Invalid Item Answers:
#' This function handles missing/invalid item answers according to official
#' FACT/FACIT scoring guidelines.
#'
#' \subsection{Subscales:}{
#'    For a given \strong{subscale score} to be calculated, a respondent must
#'    have valid, non-missing answers to \strong{greater than 50\%} of the
#'    subscale items.  If only 50\% or fewer of the subscale items are answered,
#'    the respondent will be assigned a missing value (\code{NA}) for that
#'    subscale score.
#' }
#'
#'
#' \subsection{Total Scores:}{
#'    For a given \strong{Total Score} to be calculated, two conditions must be met:
#'    \enumerate{
#'      \item The respondent must have valid, non-missing subscale scores
#'      for \strong{all} of the subscales that are summed together to calculate
#'      the Total Score.
#'      \item The respondent must have valid, non-missing answers to
#'      \strong{greater than 80\%} of the items that contribute to the given Total
#'      Score.
#'    }
#'  \strong{Both} of these conditions must be met - otherwise, the respondent
#'  will be assigned a missing value (\code{NA}) for that Total Score.
#' }
#'
#'
#' @section Sections and Subsections:
#' Did this work with more than one word before the colon?
#' See below for example of a subsection
#'
#' \subsection{Exceptions}{
#'    Apart from the following special cases...
#' }
#'
#' @name FACTscorer
#' @docType package
#'
NULL

