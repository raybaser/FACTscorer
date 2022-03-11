FACTscorer R Package
================

-   [FACTscorer Summary](#factscorer-summary)
-   [Installation](#installation)
-   [Expected Input Data Format](#expected-input-data-format)
-   [Examples](#examples)
    -   [Scoring the FACT-G](#scoring-the-fact-g)
    -   [Scoring the FACT-B (Breast
        Cancer)](#scoring-the-fact-b-breast-cancer)
    -   [Scoring only “Additional Concerns” items from the
        FACT-B](#scoring-only-additional-concerns-items-from-the-fact-b)

<!-- README.md is generated from README.Rmd. Please edit that file -->

## FACTscorer Summary

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/FACTscorer)](https://CRAN.R-project.org/package=FACTscorer)
<!-- badges: end -->

`FACTscorer` contains functions to score most of the patient-reported
outcome (PRO) measures from the Functional Assessment of Cancer Therapy
(FACT) and Functional Assessment of Chronic Illness Therapy (FACIT)
family of PRO measures. The questionnaires themselves can be downloaded
from the [FACIT website](https://www.facit.org/). For most of the
FACT/FACIT questionnaires, the [FACIT website](https://www.facit.org/)
provides scoring syntax for use with commercial statistical software
(SAS and SPSS). The `FACTscorer` R package is intended to serve as a
free, reliable alternative for those without access to SAS or SPSS.
Additionally, it enables R users to both score and analyze the FACT and
FACIT scales in R, avoiding the time-consuming and error-prone process
of transferring data back-and-forth between statistical software.
Finally, use of the `FACTscorer` package will prevent many sources of
scoring error common when using SAS and/or SPSS syntax (e.g., copy-paste
errors and other accidental modifications to the syntax).

## Installation

You can install the development version of `FACTscorer` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("raybaser/FACTscorer")
```

## Expected Input Data Format

-   **All `FACTscorer` functions expect the FACT/FACIT items to be named
    according to FACT/FACIT conventions.** For example, for the FACT-G,
    the first physical well-being item should be named GP1, the second
    GP2, and so on. Please refer to the materials provided on the [FACIT
    website](https://www.facit.org/) for the particular questionnaire
    you are using. In particular, refer to the left margin of the
    official questionnaire (i.e., from the [FACIT
    website](https://www.facit.org/)) for the appropriate item variable
    names.

-   All items on the questionnaire you are trying to score must be
    included as variables (**appropriately named**, see above) in your
    data frame.

-   All item variables must be numeric or integer class (not character
    or factor) and be whole numbers ranging from 0 to 4.

    -   For consistency with the SAS and SPSS scoring syntax on the
        [FACIT website](https://www.facit.org/), item values of `8` and
        `9` are allowed but will be recoded as system missing (i.e.,
        `NA`) before scoring.

## Examples

### Scoring the FACT-G

This example shows how to score the FACT-G (Functional Assessment of
Cancer Therapy - General) using the `scoreFACTG` function.

Given a data frame that includes all 27 of the FACT-G items as
variables, **appropriately named and formatted**, this function
generates all of the FACT-G scale scores.

``` r
library(FACTscorer)
#> NOTE: Starting with FACTscorer version 0.2.0, this function no longer
#>       modifies your input df (previously, it returned your input df
#>       with the calculated scores appended as new variables).
#>       Instead, it now returns a NEW df containing the scores and
#>       other requested output.  If desired, you can merge this new df
#>       with your original input df in a separate step.

# Use `make_FACTdata()` function to create a small data frame with fake FACT-G
# item data to score.  
##  - Each respondent will have roughly 10% of the items missing to illustrate the
##    scoring function properly prorates the scores for missing items.  
##  - See ?make_FACTdata for more info on the arguments, if desired.

df_factg <- make_FACTdata(N = 8, pmiss1 = .10, pmiss2 = .10)

# Score the FACT-G items using the `scoreFACTG` function
# All FACT-G scale scores will be output to a new data frame named `df_factg_scores`
df_factg_scores <- scoreFACTG(df_factg)
df_factg_scores
#>      PWB    SWB  EWB  FWB  FACTG
#> 1 10.500 10.000  6.0 21.0 47.500
#> 2 10.000 13.000  6.0 14.0 43.000
#> 3 11.667  9.333 14.4 14.0 49.400
#> 4 13.000  7.000 19.0 17.5 56.500
#> 5 12.000 15.000 16.0 13.0 56.000
#> 6 13.000 16.800  9.0 15.4 54.200
#> 7 11.667  9.800 10.8 14.0 46.267
#> 8 21.000 13.000  8.0 11.0 53.000

# There are several ways you can merge the scores back into your original data
# frame.  For example:
df_factg <- cbind(df_factg, df_factg_scores)
df_factg
#>    ID GP1 GP2 GP3 GP4 GP5 GP6 GP7 GS1 GS2 GS3 GS4 GS5 GS6 GS7 GE1 GE2 GE3 GE4 GE5 GE6 GF1 GF2 GF3 GF4 GF5 GF6 GF7    PWB    SWB  EWB  FWB  FACTG
#> 1 ID1   9   2   2   3   3   3   2   3   1   0   3   1   0   2   0   0   2   4   4   4   9   9   4   3   1   4   3 10.500 10.000  6.0 21.0 47.500
#> 2 ID2   3   2   4   1   3   4   1   2   3   2   0   4   0   2   4   0   4   1   3   2   0   9   3   0   4   2   3 10.000 13.000  6.0 14.0 43.000
#> 3 ID3   4   3   1   9   3   0   3   3   0   0   9   3   0   2   9   4   1   3   4   0   1   3   3   3   3   0   1 11.667  9.333 14.4 14.0 49.400
#> 4 ID4   0   4   3   4   2   0   2   0   0   2   9   1   1   2   2   4   0   2   1   0   2   4   9   0   2   3   4 13.000  7.000 19.0 17.5 56.500
#> 5 ID5   4   2   4   2   0   1   3   1   0   3   3   2   3   3   1   4   0   3   4   0   3   4   2   0   1   1   2 12.000 15.000 16.0 13.0 56.000
#> 6 ID6   2   3   1   2   4   3   0   9   3   2   2   3   9   2   1   3   4   2   3   4   0   9   3   9   4   2   2 13.000 16.800  9.0 15.4 54.200
#> 7 ID7   3   3   3   3   0   2   9   1   9   3   0   2   1   9   1   9   0   3   3   4   2   0   1   4   2   4   1 11.667  9.800 10.8 14.0 46.267
#> 8 ID8   1   2   1   3   0   0   0   4   3   3   1   0   1   1   4   2   4   1   2   3   0   2   1   1   4   1   2 21.000 13.000  8.0 11.0 53.000
```

### Scoring the FACT-B (Breast Cancer)

This example shows how to score one of the cancer-specific measures in
the FACT family, the FACT-B (Functional Assessment of Cancer Therapy -
Breast). The FACT-B can be scored using the `scoreFACT_B` function.

Given a data frame that includes all of the FACT-B items as variables,
**appropriately named and formatted**, the `scoreFACT_B` function
generates all of the FACT-B scale scores.

**NOTE**: The FACT-B contains all of the FACT-G (General) items, plus 10
items that assess “Additional Concerns” specific to breast cancer
patients. Those 10 items are used to calculate the Breast Cancer
Subscale (BCS).

``` r
library(FACTscorer)

# Use `make_FACTdata()` function to create a small data frame with fake FACT-B
# item data to score.  
## - The `namesAC` argument takes a character vector containing the names of  
##   the 10 "Additional Concerns" (AC) items. 
df_factb <- make_FACTdata(N = 8, pmiss1 = 0.10, pmiss2 = 0.10,
  namesAC = c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'P2'))

# Score the FACT-B items using the `scoreFACT_B` function
# All FACT-B scale scores will be output to a new data frame named `df_factb_scores`
df_factb_scores <- scoreFACT_B(df_factb)
df_factb_scores
#>      PWB    SWB  EWB    FWB  FACTG    BCS FACT_B_TOTAL FACT_B_TOI
#> 1  9.333  8.167  6.0 21.000 44.500 12.857       57.357     43.190
#> 2 11.667  9.000  7.0  9.000 36.667 24.000       60.667     44.667
#> 3 14.000 15.000 12.0 11.000 52.000 10.000       62.000     35.000
#> 4 18.000 15.167 12.0  9.333 54.500 13.750       68.250     41.083
#> 5  9.000 14.000 12.0 10.500 45.500 17.000       62.500     36.500
#> 6 13.000 10.500 11.0 11.667 46.167 15.000       61.167     39.667
#> 7 12.600 11.667  7.2 16.333 47.800 13.000       60.800     41.933
#> 8 28.000 19.600 10.0 14.000 71.600 24.444       96.044     66.444

# There are several ways you can merge the scores back into your original data
# frame.  For example:
df_factb <- cbind(df_factb, df_factb_scores)
```

### Scoring only “Additional Concerns” items from the FACT-B

-   The **full** FACT-B contains all 27 of the FACT-G (General) items,
    plus 10 items that assess “Additional Concerns” specific to breast
    cancer patients. Those 10 “Additional Concerns” (AC) items are used
    to calculate the Breast Cancer Subscale (BCS).

-   Although not generally recommended by the FACIT organization,
    sometimes researchers might omit the FACT-G items and include only
    the breast cancer-specific “Additional Concerns” items in their
    study.

-   Functions in the `FACTscorer` package can be told to score only the
    “Additional Concerns” items using the argument, `AConly = TRUE`. In
    the case of the FACT-B, using the `scoreFACT-B` fucntion with
    `AConly = TRUE` will score only the Breast Cancer Subscale (BCS).

-   Although the example below uses the FACT-B as an example, this
    applies to all of the FACT/FACIT questionnaires that include the
    general FACT-G items plus more specific “Additional Concerns” items.

``` r
library(FACTscorer)

# Use `make_FACTdata()` function to create a small data frame with fake FACT-B
# item data to score.  
##  - The `namesAC` argument takes a character vector containing the names of  
##    the 10 "Additional Concerns" (AC) items.  
##  - Setting `AConly = TRUE` will generate data for the AC items and omit the FACT-G
##    items.  
df_bcs <- make_FACTdata(N = 8, pmiss1 = 0.10, pmiss2 = 0.10, AConly = TRUE,
  namesAC = c('B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8', 'B9', 'P2'))

# Use the `scoreFACT_B` function with `AConly = TRUE` to score only the "Additional Concerns" items.  
# The data frame `df_bcs_scores` will contain only the Breast Cancer Subscale (BCS) scores.
df_bcs_scores <- scoreFACT_B(df_bcs, AConly = TRUE)
df_bcs_scores
#>      BCS
#> 1 18.889
#> 2 24.000
#> 3 12.000
#> 4 22.000
#> 5 20.000
#> 6 24.000
#> 7 16.000
#> 8 18.889

# There are several ways you can merge the scores back into your original data
# frame.  For example:
df_bcs <- cbind(df_bcs, df_bcs_scores)
```
