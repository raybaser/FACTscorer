# Give message about big change from v0.1.0 to v0.2.0

.onAttach <- function(...) {
  packageStartupMessage(
      paste(strwrap(
        "Starting with FACTscorer version 0.2.0, this function no longer
        modifies your input df (previously, it returned your input df
        with the calculated scores appended as new variables).  Instead,
        it now returns a NEW df containing the scores and other
        requested output.  If desired, you can merge this new df with your
        original input df in a separate step.",
        initial = "NOTE: ", indent = 0, exdent = 6, width = 70
      ), collapse = "\n")
  )
}

