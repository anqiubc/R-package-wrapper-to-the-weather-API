test_that("successful data_request should return json as response", {
  expect_equal(httr::http_type(data_request(list(key=api_key(),
                                 q="Beijing",
                                 dt="2022/01/01"))), "application/json")
  expect_equal(httr::http_type(data_request(list(key=api_key(),
                                 q="Shanghai",
                                 dt="2022/01/01"))), "application/json")
  expect_equal(httr::http_type(data_request(list(key=api_key(),
                                 q="Beijing",
                                 dt="2021/06/06"))), "application/json")
})

test_that("invalid data type for city paremeter of get_astronomy should raise error", {
  expect_error(get_astronomy(1, "2021-01-01"))
  expect_error(get_astronomy(list(1), "2022-01-01"))
  expect_error(get_astronomy(data.frame(1), "2021-01-01"))
})

test_that("invalid data type for date paremeter of get_astronomy should raise error", {
  expect_error(get_astronomy("Beijing", 2021))
  expect_error(get_astronomy("Shanghai", 11))
  expect_error(get_astronomy("London", 30))
})


test_that("incorrectly value for date paremeter of get_astronomy should raise error", {
  expect_error(get_astronomy("Beijing", "abcd"))
  expect_error(get_astronomy("Shanghai", "aa/02/2021"))
  expect_error(get_astronomy("London", "Feb 2022"))
})


test_that("incorrectly formatted date paremeter of get_astronomy should raise error", {
  expect_error(get_astronomy("Beijing", "2021/01/01"))
  expect_error(get_astronomy("Shanghai", "01/02/2021"))
  expect_error(get_astronomy("London", "Feb 01 2022"))
})


test_that("the output of get_astronomy is of the type data.frame", {
  expect_s3_class(get_astronomy("Beijing", "2021-01-01"), "data.frame")
  expect_s3_class(get_astronomy("Shanghai", "2022-01-01"), "data.frame")
  expect_s3_class(get_astronomy("London", "2021-02-01"), "data.frame")
})


test_that("the output of get_astronomy contain only one row", {
  expect_equal(nrow(get_astronomy("Beijing", "2021-01-01")), 1)
  expect_equal(nrow(get_astronomy("Shanghai", "2022-01-01")), 1)
})

test_that("the output of get_astronomy has right column names", {
  expect_named(get_astronomy("Beijing", "2021-01-01"),
               c("city", "region", "country", "lat", "lon", "sunrise", "sunset", "moonrise",
                                                         "moonset", "moon_phase", "moon_illumination", "date"))
  expect_named(get_astronomy("Shanghai", "2022-01-01"),
               c("city", "region", "country", "lat", "lon", "sunrise", "sunset", "moonrise",
                                                          "moonset", "moon_phase", "moon_illumination", "date"))
})


test_that("get_history_astro_information returns a dataframe", {
  expect_s3_class(get_history_astro_information("London","2022-02-15"), "data.frame")
})
test_that("get_history_astro_information returns error if location is not found", {
  expect_error(get_history_astro_information("123","2022-02-15"))
})
test_that("get_history_astro_information returns error if date is not valid", {
  expect_error(get_history_astro_information("London","2022-02-05"))
})
test_that("get_history_astro_information returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_current_weather("Kelowna"))
  expect_error(get_current_weather(c("Kelowna", "Vancouver")))
  expect_error(get_current_weather(c("Kelowna", "Vancouver"), "no"))
  Sys.setenv(API_KEY = key)
})


test_that("get_history_daily_weather returns a dataframe", {
  expect_s3_class(get_history_daily_weather("London","2022-02-15"), "data.frame")
})
test_that("get_history_daily_weather returns error if location is not found", {
  expect_error(get_history_daily_weather("123","2022-02-15"))
})
test_that("get_history_daily_weather returns error if date is not valid", {
  expect_error(get_history_daily_weather("London","2022-02-05"))
})
test_that("get_history_daily_weather returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_current_weather("Kelowna"))
  expect_error(get_current_weather(c("Kelowna", "Vancouver")))
  expect_error(get_current_weather(c("Kelowna", "Vancouver"), "no"))
  Sys.setenv(API_KEY = key)
})

test_that("get_history_hourly_weather returns a dataframe", {
  expect_s3_class(get_history_hourly_weather("London","2022-02-15",23), "data.frame")
})
test_that("get_history_hourly_weather returns error if location is not found", {
  expect_error(get_history_hourly_weather("123","2022-02-15",23))
})
test_that("get_history_daily_weather returns error if date is not valid", {
  expect_error(get_history_daily_weather("London","2022-02-05",23))
})
test_that("get_history_daily_weather returns error if time is not valid", {
  expect_error(get_history_daily_weather("London","2022-02-15",24))
})
test_that("get_history_hourly_weather returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_current_weather("Kelowna"))
  expect_error(get_current_weather(c("Kelowna", "Vancouver")))
  expect_error(get_current_weather(c("Kelowna", "Vancouver"), "no"))
  Sys.setenv(API_KEY = key)
})

test_that("get_current_weather returns a dataframe", {
  expect_s3_class(get_current_weather("Kelowna"), "data.frame")
  expect_s3_class(get_current_weather(c("Kelowna", "Vancouver")), "data.frame")
  expect_s3_class(get_current_weather(c("Kelowna", "Vancouver"), "no"), "data.frame")
})




test_that("get_current_weather returns error if location is not found", {
  expect_error(get_current_weather(123))
  expect_error(get_current_weather("Keyboard"))
  expect_error(get_current_weather(c(123,"Keyboard")))
})


test_that("get_current_weather returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_current_weather("Kelowna"))
  expect_error(get_current_weather(c("Kelowna", "Vancouver")))
  expect_error(get_current_weather(c("Kelowna", "Vancouver"), "no"))
  Sys.setenv(API_KEY = key)
})


test_that("get_time_zone returns a dataframe", {
  expect_s3_class(get_time_zone("Kelowna"), "data.frame")
  expect_s3_class(get_time_zone(c("Kelowna", "Vancouver")), "data.frame")
  expect_s3_class(get_time_zone(c("Kelowna", "Vancouver", "Toronto")), "data.frame")
})




test_that("get_time_zone returns error if location is not found", {
  expect_error(get_time_zone(123))
  expect_error(get_time_zone("Keyboard"))
  expect_error(get_time_zone(c(123,"Keyboard")))
})


test_that("get_time_zone returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_time_zone("Kelowna"))
  expect_error(get_time_zone(c("Kelowna", "Vancouver")))
  expect_error(get_time_zone(c("Kelowna", "Vancouver"), "no"))
  Sys.setenv(API_KEY = key)
})


test_that("get_sports_events returns a dataframe", {
  expect_s3_class(get_sports_events("London", "football"), "data.frame")
  expect_s3_class(get_sports_events("Oxford", "football"), "data.frame")
  expect_s3_class(get_sports_events(c("London", "Oxford"), "football"), "data.frame")
})


test_that("get_sports_events returns error if location is not found", {
  expect_error(get_sports_events(123, "football"))
  expect_error(get_sports_events("Keyboard", "football"))
  expect_error(get_sports_events(c(123,"Keyboard"),"football"))
})


test_that("get_sports_events returns error if sport is not found", {
  expect_error(get_sports_events("London", "soccer"))
  expect_error(get_sports_events("London", "hockey"))
  expect_error(get_sports_events("London", "badminton"))
})


test_that("get_sports_events returns error if API key invalid", {
  key<-Sys.getenv("API_KEY")
  Sys.setenv(API_KEY = "ABC123")
  expect_error(get_sports_events("London", "football"))
  expect_error(get_sports_events(c("London", "Oxford"), "football"))
  expect_error(get_sports_events(c("London", "Oxford", "Kent"), "football"))
  Sys.setenv(API_KEY = key)
})
