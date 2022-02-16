#' Get or set API_KEY value
#'
#' This package will need a Weather API key residing in the environment
#' variable `API_KEY`. Set it in the `.Renviron` file in the home directory.
#'
#' @md
#' @param force A boolean to force set new API key for current environment
#' @return A vector containing the API key
#' @export
api_key <- function(force = FALSE) {
  env <- Sys.getenv("API_KEY")
  if (!identical(env, "") && !force) {
    return(env)
  }

  if (!interactive()) {
    stop("Please set env var API_KEY to your Weather API key",
      call. = FALSE
    )
  }

  message("Couldn't find env var API_KEY See ?api_key for more details.")
  message("Please enter your API key:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("Weather API key entry failed", call. = FALSE)
  }

  message("Updating API_KEY env var")
  Sys.setenv(API_KEY = pat)

  pat
}
# Reference: omdbapi package by Bob Rudis <https://github.com/hrbrmstr/omdbapi>
