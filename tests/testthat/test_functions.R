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
})
