pkgname <- "weatherapi"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('weatherapi')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("api_key")
### * api_key

flush(stderr()); flush(stdout())

### Name: api_key
### Title: Get or set API_KEY value
### Aliases: api_key

### ** Examples

# api_key() # To display API Key that was set in the .Renviron file
# api_key(force=TRUE) # To change the API key, see vignette for details



cleanEx()
nameEx("data_request")
### * data_request

flush(stderr()); flush(stdout())

### Name: data_request
### Title: get the astronomy data of specific date time and city from
###   weatherapi.com
### Aliases: data_request

### ** Examples

data_request(list(key="abc", q="London", dt="2021-01-01"))



cleanEx()
nameEx("get_astronomy")
### * get_astronomy

flush(stderr()); flush(stdout())

### Name: get_astronomy
### Title: A wrapper function to obtain the the astronomy data of a the
###   desired city and date time from the weatherapi.com.
### Aliases: get_astronomy

### ** Examples

get_astronomy("Beijing", "2022-01-10")



cleanEx()
nameEx("get_current_weather")
### * get_current_weather

flush(stderr()); flush(stdout())

### Name: get_current_weather
### Title: Get current weather information
### Aliases: get_current_weather

### ** Examples

get_current_weather("Kelowna")
get_current_weather(c("Kelowna", "Vancouver"), "no")



cleanEx()
nameEx("get_history_astro_information")
### * get_history_astro_information

flush(stderr()); flush(stdout())

### Name: get_history_astro_information
### Title: Get history astronomical information for a specific day
### Aliases: get_history_astro_information

### ** Examples

get_history_astro_information("London","2022-02-12")



cleanEx()
nameEx("get_history_daily_weather")
### * get_history_daily_weather

flush(stderr()); flush(stdout())

### Name: get_history_daily_weather
### Title: Get history weather information for a specific day
### Aliases: get_history_daily_weather

### ** Examples

get_history_daily_weather("London","2022-02-12")



cleanEx()
nameEx("get_history_hourly_weather")
### * get_history_hourly_weather

flush(stderr()); flush(stdout())

### Name: get_history_hourly_weather
### Title: Get history hourly weather information for a specific hour in a
###   specific day
### Aliases: get_history_hourly_weather

### ** Examples

get_history_hourly_weather("London","2022-02-12",4)



cleanEx()
nameEx("get_sports_events")
### * get_sports_events

flush(stderr()); flush(stdout())

### Name: get_sports_events
### Title: Get sports information
### Aliases: get_sports_events

### ** Examples

get_sports_events("London", "football")
get_sports_events(c("London", "Oxford"), "football")



cleanEx()
nameEx("get_time_zone")
### * get_time_zone

flush(stderr()); flush(stdout())

### Name: get_time_zone
### Title: Get time zone information
### Aliases: get_time_zone

### ** Examples

get_time_zone("Kelowna")
get_time_zone(c("Kelowna", "Vancouver"))



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
