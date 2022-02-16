#' Get history astronomical information for a specific day
#'
#' @param key A string containing the API key
#' @param q A string containing the location, which can be US Zipcode, UK Postcode, Canada Postalcode, IP address, Latitude/Longitude (decimal degree) or city name.
#' @param dt A string containing the date for query, which should be within the last 7 days.
#'
#' @return A data frame containing the astronomical information for the day.
#' @export
#'
#' @examples
#' get_history_astro_information("YourAPIKeyHere","London","2022-02-12")
get_history_astro_information<- function(key,q,dt) {
  df <- data.frame()
  base_url <- "http://api.weatherapi.com/v1/history.json"
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- httr::GET(base_url, query = list(key=key,q=q,dt=dt))
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
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
  return(as.data.frame(parsed[[2]]$forecastday[[1]]$astro))
}
