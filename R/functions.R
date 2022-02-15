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



#' Get time zone information
#'
#' Get the local time-zone information for a location
#'
#' @param location A vector of location
#' @return A data frame of local time-zone information
#' @examples
#' get_time_zone("Kelowna")
#' get_time_zone(c("Kelowna", "Vancouver"))
#' @export
get_time_zone <- function(location) {
  url <- "http://api.weatherapi.com/v1/timezone.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i]))
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



#' Get sports information
#'
#' Get a list of all upcoming sports events in a location
#'
#' @param location A vector of location
#' @param sport A string of sport type ("football","cricket","golf")
#' @return A data frame of upcoming sports events in a location
#' @examples
#' get_sports_events("London", "football")
#' get_sports_events(c("London", "Oxford"), "football")
#' @export
get_sports_events <- function(location, sport) {
  url <- "http://api.weatherapi.com/v1/sports.json"
  df <- data.frame()

  for (i in 1:length(location)) {
    resp <- httr::GET(url, query = list(key = api_key(), q = location[i]))
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
    df <- rbind(df, cbind(`location` = location, as.data.frame(resp_json[index])))
  }
  return(df[order(df$location),])
}



