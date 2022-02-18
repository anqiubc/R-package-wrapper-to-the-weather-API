# Reference: I learnt most of those from https://httr.r-lib.org/articles/api-packages.html


#' get the astronomy data of specific date time and city from weatherapi.com
#'
#' @param query A list contain information of city, date, and api_key, represented by q, dt, key, repectively.
#'
#' @return The http get response containing astronomy information.
#' @examples
#' data_request(list(key="abc", q="London", dt="2021-01-01"))
#' @export
data_request <- function(query) {
  url <- "http://api.weatherapi.com/v1/astronomy.json"
  httr::GET(url, query = query)
}

#' A wrapper function to obtain the the astronomy data of a the desired city and date time from the weatherapi.com.
#'
#' @param city A string indicating city (e.g., "London", "Beijing").
#' @param date A string of the form yyyy-mm-dd indicating date (e.g., "2022-02-10").
#'
#' @return A dataframe with the columns `sunrise`, `sunset`, `moonrise`, `moonset`, `moon_phase`, and `moon_illumination`.
#' @examples
#' get_astronomy("Beijing", "2022-01-10")
#' @export
get_astronomy <- function(city, date) {

  # Process and validate here the parameter `city`, which affects the function parameter in the API
  if (!is.character(city))
    stop("city has to be a character string")

  # Process and validate here the parameter `date`, which affects the function parameter in the API
  if (!is.character(date)) {
    stop("date has to be a character string")
  }else if (is.na(as.Date(date, format = "%Y-%m-%d"))){
    stop("invaild date format detected")
  }

  # Requesting the data
  query <- list()
  query$key <- api_key()
  query$q <- city
  query$dt <- date

  res <- data_request(query)

  # Check if the response type is json, if not, raise an error.
  if (httr::http_type(res) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # parse the response
  parsed_res <- jsonlite::fromJSON(content(res, "text", encoding = "UTF-8"),
                                   simplifyVector = FALSE)

  # Check if the request was successful, if not, raise an error
  if (httr::http_error(res)) {
    stop(
      sprintf(
        "Weather Astronomy API request failed [%s]\n%s\n<%s>",
        status_code(res),
        parsed_res$message,
        parsed_res$documentation_url
      ),
      call. = FALSE
    )
  }

  # Create dataframe to hold the response data
  result <- data.frame(parsed_res)
  result <- tidyverse::subset(result, select = -c(location.tz_id, location.localtime_epoch, location.localtime))
  colnames(result) <- c("city", "region", "country", "lat", "lon", "sunrise", "sunset", "moonrise",
                        "moonset", "moon_phase", "moon_illumination")
  result$date <- date
  result
}

