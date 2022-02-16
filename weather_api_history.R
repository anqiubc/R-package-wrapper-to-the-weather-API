get_history_daily_weather<- function(key,q,dt) {
  df <- data.frame()
  base_url <- "http://api.weatherapi.com/v1/history.json"
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- httr::GET(base_url, query = list(key=key,q=q,dt=dt))
  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  if (http_error(resp)) {
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
  return(as.data.frame(parsed[[2]]$forecastday[[1]]$day))
}

get_history_astro_information<- function(key,q,dt) {
  df <- data.frame()
  base_url <- "http://api.weatherapi.com/v1/history.json"
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- httr::GET(base_url, query = list(key=key,q=q,dt=dt))
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  if (http_error(resp)) {
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

get_history_hourly_weather<- function(key,q,dt,h) {
  df <- data.frame()
  base_url <- "http://api.weatherapi.com/v1/history.json"
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- httr::GET(base_url, query = list(key=key,q=q,dt=dt))
  if (!is.numeric(h)||h>23||h<0||!is.integer(as.integer(h))) {
    stop("Please enter a valid hour (integer, 0-23)", call. = FALSE)
  }
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  if (http_error(resp)) {
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
  return(as.data.frame(parsed[[2]]$forecastday[[1]]$hour[[h+1]]))
}


#weather_api_history function
weather_api_history <- function(key,q,dt) {
  base_url <- "http://api.weatherapi.com/v1/history.json"
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- httr::GET(base_url, query = list(key=key,q=q,dt=dt))
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)
  if (http_error(resp)) {
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
  structure(
    list(
      location_data= parsed[[1]],
      daily_data = parsed[[2]]$forecastday[[1]]$day,
      astro_data= parsed[[2]]$forecastday[[1]]$astro,
      hourly_data=parsed[[2]]$forecastday[[1]]$hour,
      path = path,
      response = resp,
      class = "weather_api_history"
    )
  )
}

#use case:
res<-weather_api_history("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-12")
#(1)data
#location data
res$location_data
#daily temp summary
res$daily_data
#astro data
res$astro_data
#hourly data
length(res$hourly_data)#a list
res$hourly_data[[1]]
#(2)information
#path
res$path
#response
res$response
#class
res$class

get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-12")
get_history_astro_information("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-12")
get_history_hourly_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-12",0)
