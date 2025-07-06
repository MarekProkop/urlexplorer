
# extract_scheme() tests --------------------------------------------------

# Test that the function returns a character vector with the scheme

test_that("extract_scheme() returns a character vector with the scheme", {
  url <- c("http://example.com", "https://example.com")
  result <- extract_scheme(url)
  expected <- c("http", "https")
  expect_equal(result, expected)
})


# extract_userinfo() tests ------------------------------------------------

# Test that the function returns a character vector with the userinfo

test_that("extract_userinfo() returns a character vector with the userinfo", {
  url <- c("http://user@example.com")
  result <- extract_userinfo(url)
  expected <- c("user")
  expect_equal(result, expected)
})


# extract_host() tests ----------------------------------------------------

# Test that the function returns a character vector with the host

test_that("extract_host() returns a character vector with the host", {
  url <- c(
    "https://example.com", "http://www.example.com",
    "https://www.example.com/The-Smart-Factory-@-Wichita.jpg"
  )
  result <- extract_host(url)
  expected <- c("example.com", "www.example.com", "www.example.com")
  expect_equal(result, expected)
})


# extract_port() tests ----------------------------------------------------

# Test that the function returns a character vector with the port

test_that("extract_port() returns a character vector with the port", {
  url <- c("http://example.com:8080")
  result <- extract_port(url)
  expected <- c(8080)
  expect_equal(result, expected)
})


# extract_path() tests ----------------------------------------------------

# Test that the function returns a character vector with the path

test_that("extract_path() returns a character vector with the path", {
  url <- c("http://example.com/", "http://example.com/path/to/resource")
  result <- extract_path(url)
  expected <- c("/", "/path/to/resource")
  expect_equal(result, expected)
})


# extract_query() tests ---------------------------------------------------

# Test that the function returns a character vector with the query

test_that("extract_query() returns a character vector with the query", {
  url <- c("http://example.com/?query=arg")
  result <- extract_query(url)
  expected <- c("query=arg")
  expect_equal(result, expected)
})

# extract_fragment() tests ------------------------------------------------

# Test that the function returns a character vector with the fragment

test_that("extract_fragment() returns a character vector with the fragment", {
  url <- c("http://example.com/#frag")
  result <- extract_fragment(url)
  expected <- c("frag")
  expect_equal(result, expected)
})

# extract_path_segment() tests --------------------------------------------

# Test that the function returns a character vector with the path segment

test_that("extract_path_segment() returns a character vector with the path segment", {
  path <- c(
    "/path/to/resource",
    "/another/path/to/resource",
    "/empty//segment",
    "/",
    "/path",
    "/path/"
  )
  result <- extract_path_segment(path, 2)
  expected <- c("to", "path", NA, NA, NA, NA)
  expect_equal(result, expected)
})


# extract_param_value() tests -----------------------------------------

# Test that the function returns a character vector with the parameter value

test_that("extract_param_value() returns a character vector with the parameter value", {
  query <- c(
    "query1=value1&query2=value2",
    "query1=value3",
    "query2=value4",
    "query1=",
    NA_character_
  )
  result <- extract_param_value(query, "query1")
  expected <- c("value1", "value3", NA, "", NA)
  expect_equal(result, expected)
})


# extract_file_extension() tests ------------------------------------------

# Test that the function returns a character vector with the file extension from
# URLs

test_that("extract_file_extension() returns a character vector with the file extension from URLs", {
  url <- c(
    "http://example.com/file.html",
    "http://example.com/path/to/file.html?query=arg",
    "http://example.com/file.html#frag",
    "http://example.com/path/",
    "http://example.com/file",
    "http://example.com/"
  )
  result <- extract_file_extension(url)
  expected <- c("html", "html", "html", NA, NA, NA)
  expect_equal(result, expected)
})

# Test that the function returns a character vector with the file extension from
# paths

test_that("extract_file_extension() returns a character vector with the file extension from paths", {
  path <- c(
    "/path/to/file.html",
    "/path/to/file.html?query=arg",
    "/path/to/file.html#frag",
    "/path/to/",
    "/path/to/file",
    "/"
  )
  result <- extract_file_extension(path)
  expected <- c("html", "html", "html", NA, NA, NA)
  expect_equal(result, expected)
})
