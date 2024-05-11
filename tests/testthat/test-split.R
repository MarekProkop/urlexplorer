
# split_url() tests -------------------------------------------------------

# Test that the function returns a tibble with correctly parsed URL

test_that("split_url() returns a tibble with correctly parsed URL", {
  url <- "https://example.com:8080/path?query=arg&key=value#fragment"
  result <- split_url(url)
  expected <- tibble::tibble(
    scheme = "https",
    host = "example.com",
    port = 8080,
    userinfo = NA_character_,
    path = "/path",
    query = "query=arg&key=value",
    fragment = "fragment"
  )
  expect_equal(result, expected)
})

# Test handling of URLs with missing components
test_that("split_url() handles URLs with missing components", {
  url <- "https://example.com"
  result <- split_url(url)
  expected <- tibble::tibble(
    scheme = "https",
    host = "example.com",
    port = NA_integer_,
    userinfo = NA_character_,
    path = NA_character_,
    query = NA_character_,
    fragment = NA_character_
  )
  expect_equal(result, expected)
})

# Test handling of special characters in URLs
test_that("split_url() handles special characters", {
  url <- "https://example.com/path%20one?query=value%20two#frag%20three"
  result <- split_url(url)
  expected <- tibble::tibble(
    scheme = "https",
    host = "example.com",
    port = NA_integer_,
    userinfo = NA_character_,
    path = "/path one",
    query = "query=value%20two",
    fragment = "frag three"
  )
  expect_equal(result, expected)
})

# Test handling of malformed URLs
test_that("split_url() handles malformed URLs", {
  url <- "http:///example.com"
  result <- split_url(url)
  expected <- tibble::tibble(
    scheme = "http",
    host = NA_character_,
    port = -1,
    userinfo = NA_character_,
    path = "/example.com",
    query = NA_character_,
    fragment = NA_character_
  )
  expect_equal(result, expected)
})


# split_host() tests ------------------------------------------------------

# Test that the function returns a tibble with correctly split host

test_that("split_host() returns a tibble with correctly split host", {
  host <- c("subdomain.example.com")
  result <- split_host(host)
  expected <- tibble::tibble(
    tld = "com",
    domain = "example",
    subdomain_1 = "subdomain"
  )
  expect_equal(result, expected)
})

# Test handling of multiple hosts

test_that("split_host() handles multiple hosts", {
  host <- c("subdomain2.subdomain1.example.com", "example.com")
  result <- split_host(host)
  expected <- tibble::tibble(
    tld = c("com", "com"),
    domain = c("example", "example"),
    subdomain_1 = c("subdomain1", NA_character_),
    subdomain_2 = c("subdomain2", NA_character_)
  )
  expect_equal(result, expected)
})


# split_path() tests ------------------------------------------------------

# Test that the function returns a tibble with correctly split path

test_that("split_path() returns a tibble with correctly split path", {
  path <- c("/path/to/resource")
  result <- split_path(path)
  expected <- tibble::tibble(
    path_1 = "path",
    path_2 = "to",
    path_3 = "resource"
  )
  expect_equal(result, expected)
})

# Test handling of multiple paths

test_that("split_path() handles multiple paths", {
  path <- c("/path/to/resource", "/another/path.html")
  result <- split_path(path)
  expected <- tibble::tibble(
    path_1 = c("path", "another"),
    path_2 = c("to", "path.html"),
    path_3 = c("resource", NA_character_)
  )
  expect_equal(result, expected)
})


# split_query() tests -----------------------------------------------------

# Test that the function returns a tibble with correctly split query

test_that("split_query() returns a tibble with correctly split query", {
  query <- c("key1=value1&key2=value2")
  result <- split_query(query)
  expected <- tibble::tibble(
    key1 = "value1",
    key2 = "value2"
  )
  expect_equal(result, expected)
})

# Test handling of multiple queries

test_that("split_query() handles multiple queries", {
  query <- c("key1=value1&key2=value2", "key3=value3&key1=value4", "key1=value5")
  result <- split_query(query)
  expected <- tibble::tibble(
    key1 = c("value1", "value4", "value5"),
    key2 = c("value2", NA_character_, NA_character_),
    key3 = c(NA_character_, "value3", NA_character_)
  )
  expect_equal(result, expected)
})
