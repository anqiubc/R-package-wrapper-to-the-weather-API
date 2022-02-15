#' Get current weather information
#'
#' Get the current real-time weather and air-quality information
#'
#' @param location A vector of location
#' @param air_quality A string of "yes" or "no" to show air quality
#'   information. Default is show air quality information ("yes").
#' @return A data frame of current weather information
#' @examples
#' get_current_weather("Kelowna")
#' get_current_weather(c("Kelowna", "Vancouver"), "no")
#' @export
get_current_weather <- function(location, air_quality = "yes") {
  url <- "http://api.weatherapi.com/v1/current.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i], aqi = air_quality))
    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }

    resp_json <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))
    if (httr::http_error(resp)) {
      stop(
        sprintf(
          "API request failed, status code: [%s]\nRefer to API error codes <%s>",
          status_code(resp),
          "https://www.weatherapi.com/docs/"
        ),
        call. = FALSE
      )
    }

    df <- rbind(df, as.data.frame(resp_json))
  }
  return(df)
}
