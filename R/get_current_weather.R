#' Get current weather information
#'
#' Get the current real-time weather and air-quality information
#'
#' @param location A vector of location
#' @param air_quality A string of "yes" or "no" to show air quality
#'   information. Default is show air quality information ("yes").
#' @return A data frame of current weather information (see vignette for details)
#' @examples
#' get_current_weather("Kelowna")
#' get_current_weather(c("Kelowna", "Vancouver"), "no")
#' @export
get_current_weather <- function(location, air_quality = "yes") {
  # Define url and initialize df to store results
  url <- "http://api.weatherapi.com/v1/current.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    # Get weather info via: url + api_key + location + aqi
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i], aqi = air_quality))
    # Handle error if API did not return json
    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }
    # Parse response to json
    resp_json <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))
    # Handle error due to invalid api key or location
    if (httr::http_error(resp)) {
      stop(
        sprintf(
          "API request failed, status code: [%s]\nRefer to vignette for more details",
          httr::status_code(resp)
        ),
        call. = FALSE
      )
    }
    # Bind each location result as a row in a dataframe
    df <- rbind(df, as.data.frame(resp_json))
  }
  # Return the dataframe result
  return(df)
}
