library(devtools)
library(httr)
library(jsonlite)

#Set a user agent
ua <- user_agent("https://github.com/anqiubc")
ua
#weather_api_history function
weather_api_history <- function(key,q,dt) {
  base_url <- "http://api.weatherapi.com/v1/history.json?"
  full_url<-POST(base_url, query = list(key=key,q=q,dt=dt),encode = "raw")
  path<-paste0("key=",key,"&q=",q,"&dt=",dt)
  resp <- GET(full_url)
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(content(resp, as = "text", encoding = "UTF-8"), simplifyVector = FALSE)
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
res<-weather_api_history("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-08")

#use case:

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


