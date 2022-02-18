#' Get or set API_KEY value
#'
#' This package will need a Weather API key residing in the environment
#' variable `API_KEY`. Set it in the `.Renviron` file in the home directory.
#' See vignette for more details on how to set up the API key.
#'
#' @md
#' @param force A boolean to force set new API key for current environment.
#' To force set a new API key set it to TRUE, the default value is FALSE.
#' @return A vector containing the API key
#' @examples
#' # api_key() # To display API Key that was set in the .Renviron file
#' # api_key(force=TRUE) # To change the API key, see vignette for details
#' @export
api_key <- function(force = FALSE) {
  # Get API key from system environment
  env <- Sys.getenv("API_KEY")
  # Return API key If the API_KEY in system env is not empty & force = FALSE
  if (!identical(env, "") && !force) {
    return(env)
  }
  # Ask user for API key in the console
  if (!interactive()) {
    stop("Please set env var API_KEY to your Weather API key",
      call. = FALSE
    )
  }
  message("Couldn't find env var API_KEY See ?api_key for more details.")
  message("Please enter your API key:")
  pat <- readline(": ")
  # Handle error if user enter an empty API key
  if (identical(pat, "")) {
    stop("Weather API key entry failed", call. = FALSE)
  }
  # Update API key to system environment
  message("Updating API_KEY env var")
  Sys.setenv(API_KEY = pat)
  # Return the API key
  pat
}
# Reference: omdbapi package by Bob Rudis <https://github.com/hrbrmstr/omdbapi>
