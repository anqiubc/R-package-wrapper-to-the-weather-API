#' Get history astronomical information for a specific day
#'
#' @param q A string containing the location, which can be US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
#' @param dt A string containing the date for query, which should be within the last 7 days.
#'
#' @return A data frame containing the astronomical information for the day.
#' @export
#'
#' @examples
#' get_history_astro_information("London","2022-02-12")
get_history_astro_information<- function(q,dt) {
  df <- data.frame()
  # Define url and initialize df to store results
  base_url <- "http://api.weatherapi.com/v1/history.json"
  # Get weather info via: url + api_key + location + aqi
  resp <- httr::GET(base_url, query = list(key=api_key(),q=q,dt=dt))
  # Handle error if API did not return json
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  # Parse response to json
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  # Handle error due to invalid api key or location
  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "GitHub API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$error$message,
        parsed$error$code
      ),
      call. = FALSE
    )
  }
  # Return the dataframe result
  return(as.data.frame(parsed[[2]]$forecastday[[1]]$astro))
}
