#' Get sports information
#'
#' Get a list of all upcoming sports events in a location
#'
#' @param location A vector of location
#' @param sport A string of sport type ("football","cricket","golf")
#' @return A data frame of upcoming sports events in a location (see vignette for details)
#' @examples
#' get_sports_events("London", "football")
#' get_sports_events(c("London", "Oxford"), "football")
#' @export
get_sports_events <- function(location, sport) {
  # Define url and initialize df to store result
  url <- "http://api.weatherapi.com/v1/sports.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    # Get sports events via: url + api_key + location
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i]))
    # Handle error if API did not return a json
    if (httr::http_type(resp) != "application/json") {
      stop("API did not return json", call. = FALSE)
    }
    # Parse response to json
    resp_json <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"))
    # Handle error due to incorrect api key or location
    if (httr::http_error(resp)) {
      stop(
        sprintf(
          "API request failed, status code: [%s]\nRefer to vignette for more details",
          httr::status_code(resp)
        ),
        call. = FALSE
      )
    }
    # Check if sport is either one of football, cricket, or golf
    sport <- tolower(sport)
    `%!in%` <- Negate(`%in%`)
    if(sport %!in% c("football","cricket", "golf")) {
      stop('Sport must be either "football","cricket", or "golf"', call. = FALSE)
    } else if(sport == "football") {
      index <- 1
    } else if(sport == "cricket") {
      index <- 2
    } else if(sport == "golf") {
      index <- 3
    }
    # Bind result to dataframe
    df <- rbind(df, as.data.frame(resp_json[index]))
  }
  # Return the dataframe result sorted by location
  return(df)
}
