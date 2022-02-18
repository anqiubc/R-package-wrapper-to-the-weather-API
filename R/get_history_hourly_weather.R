#' Get history hourly weather information for a specific hour in a specific day
#'
#' @param q A string containing the location, which can be US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
#' @param dt A string containing the date for query, which should be within the last 7 days.
#' @param h An integer containing the hour for query, which be in the range of 0 to 23.
#'
#' @return A data frame containing the daily weather information for the hour in the day.
#' @export
#'
#' @examples
#' get_history_hourly_weather("London","2022-02-12",4)
get_history_hourly_weather<- function(q,dt,h) {
  # Define url and initialize df to store results
  df <- data.frame()
  base_url <- "http://api.weatherapi.com/v1/history.json"
  # Get responses
  resp <- httr::GET(base_url, query = list(key=api_key(),q=q,dt=dt))
  # Handle errors if the hour is invalid
  if (!is.numeric(h)||h>23||h<0||!is.integer(as.integer(h))) {
    stop("Please enter a valid hour (integer, 0-23)", call. = FALSE)
  }
  # Handle error if API did not return json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Parse response to json
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  # Handle error due to invalid parameters
  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "GitHub API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        parsed$error$message,
        parsed$error$code
      ),
      call. = FALSE
    )
  }
  # Return the dataframe result
  return(as.data.frame(parsed[[2]]$forecastday[[1]]$hour[[h+1]]))
}
