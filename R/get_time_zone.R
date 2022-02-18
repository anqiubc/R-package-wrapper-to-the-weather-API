#' Get time zone information
#'
#' Get the local time-zone information for a location
#'
#' @param location A vector of location
#' @return A data frame of local time-zone information (see vignette for details)
#' @examples
#' get_time_zone("Kelowna")
#' get_time_zone(c("Kelowna", "Vancouver"))
#' @export
get_time_zone <- function(location) {
  # Define url and initialize df to store result
  url <- "http://api.weatherapi.com/v1/timezone.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    # Get timezone via: url + api_key + location
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i]))
    # Handle error if API did not return a json
    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }
    # Parse response into json
    resp_json <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))
    # Handle error due to incorrect API key or location
    if (httr::http_error(resp)) {
      stop(
        sprintf(
          "API request failed, status code: [%s]\nRefer to vignette for more details",
          httr::status_code(resp)
        ),
        call. = FALSE
      )
    }
    # Bind each location result to a new row in dataframe
    df <- rbind(df, as.data.frame(resp_json))
  }
  # Return the dataframe
  return(df)
}
