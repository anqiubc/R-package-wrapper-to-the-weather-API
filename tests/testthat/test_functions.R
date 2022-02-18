test_that("get_history_astro_information returns a dataframe", {
  expect_s3_class(get_history_astro_information("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-15"), "data.frame")
})
test_that("get_history_astro_information returns error if API key is not valid", {
  expect_error(get_history_astro_information("APIKEY","London","2022-02-15"))
})
test_that("get_history_astro_information returns error if location is not found", {
  expect_error(get_history_astro_information("1b9ca6d6b4914dfa8d5231606221402","123","2022-02-15"))
})
test_that("get_history_astro_information returns error if date is not valid", {
  expect_error(get_history_astro_information("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-05"))
})


test_that("get_history_daily_weather returns a dataframe", {
  expect_s3_class(get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-15"), "data.frame")
})
test_that("get_history_daily_weather returns error if API key is not valid", {
  expect_error(get_history_daily_weather("APIKEY","London","2022-02-15"))
})
test_that("get_history_daily_weather returns error if location is not found", {
  expect_error(get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","123","2022-02-15"))
})
test_that("get_history_daily_weather returns error if date is not valid", {
  expect_error(get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-05"))
})


test_that("get_history_hourly_weather returns a dataframe", {
  expect_s3_class(get_history_hourly_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-15",23), "data.frame")
})
test_that("get_history_hourly_weather returns error if API key is not valid", {
  expect_error(get_history_hourly_weather("APIKEY","London","2022-02-15",4))
})
test_that("get_history_hourly_weather returns error if location is not found", {
  expect_error(get_history_hourly_weather("1b9ca6d6b4914dfa8d5231606221402","123","2022-02-15",23))
})
test_that("get_history_daily_weather returns error if date is not valid", {
  expect_error(get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-05",23))
})
test_that("get_history_daily_weather returns error if time is not valid", {
  expect_error(get_history_daily_weather("1b9ca6d6b4914dfa8d5231606221402","London","2022-02-15",24))

  
test_that("get_current_weather returns a dataframe", {
  expect_s3_class(get_current_weather("Kelowna"), "data.frame")
  expect_s3_class(get_current_weather(c("Kelowna", "Vancouver")), "data.frame")
  expect_s3_class(get_current_weather(c("Kelowna", "Vancouver"), "no"), "data.frame")
})

  
test_that("get_current_weather returns correct location", {
  expect_identical(get_current_weather("Kelowna")[[1]], "Kelowna")
  expect_identical(get_current_weather("Kelowna")[[2]], "British Columbia")
  expect_identical(get_current_weather("Kelowna")[[3]], "Canada")
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

  
test_that("get_time_zone returns correct location", {
  expect_identical(get_time_zone("Kelowna")[[1]], "Kelowna")
  expect_identical(get_time_zone("Kelowna")[[2]], "British Columbia")
  expect_identical(get_time_zone("Kelowna")[[3]], "Canada")
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