test_that("successful data_request should return json as response", {
  expect_equal(http_type(data_request(list(key="9d56997213e54667a41172101221602",
                                 q="Beijing",
                                 dt="2022/01/01"))), "application/json")
  expect_equal(http_type(data_request(list(key="9d56997213e54667a41172101221602",
                                 q="Shanghai",
                                 dt="2022/01/01"))), "application/json")
  expect_equal(http_type(data_request(list(key="9d56997213e54667a41172101221602",
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

