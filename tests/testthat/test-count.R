
# count_schemes() tests ---------------------------------------------------

# Test that the function returns a tibble with correctly counted schemes

test_that("count_schemes() returns a tibble with correctly counted schemes", {
  url <- c(
    "https://example.com/", "http://example.com/", "https://example.com/a"
  )
  result <- count_schemes(url)
  expected <- tibble::tibble(
    scheme = c("http", "https"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_schemes() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "https://example.com/", "http://example.com/", "https://example.com/a"
  )
  result <- count_schemes(url, sort = TRUE)
  expected <- tibble::tibble(
    scheme = c("https", "http"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_schemes() returns a tibble with the correct column name", {
  url <- c(
    "https://example.com/", "http://example.com/", "https://example.com/a"
  )
  result <- count_schemes(url, name = "count")
  expected <- tibble::tibble(
    scheme = c("http", "https"),
    count = c(1, 2)
  )
  expect_equal(result, expected)
})

# count_userinfos() tests -------------------------------------------------

# Test that the function returns a tibble with correctly counted userinfos

test_that("count_userinfos() returns a tibble with correctly counted userinfos", {
  url <- c(
    "https://user1@example.com/", "http://user2@example.com/",
    "https://user1@example.com/a"
  )
  result <- count_userinfos(url)
  expected <- tibble::tibble(
    userinfo = c("user1", "user2"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})


# count_hosts() tests -----------------------------------------------------

# Test that the function returns a tibble with correctly counted hosts

test_that("count_hosts() returns a tibble with correctly counted hosts", {
  url <- c(
    "http://www.example.com/", "http://example.com/", "http://www.example.com/a"
  )
  result <- count_hosts(url)
  expected <- tibble::tibble(
    host = c("example.com", "www.example.com"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_hosts() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "http://www.example.com/", "http://example.com/", "http://www.example.com/a"
  )
  result <- count_hosts(url, sort = TRUE)
  expected <- tibble::tibble(
    host = c("www.example.com", "example.com"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# count_ports() tests -----------------------------------------------------

# Test that the function returns a tibble with correctly counted ports

test_that("count_ports() returns a tibble with correctly counted ports", {
  url <- c(
    "http://example.com:8080/", "http://example.com:80/", "http://example.com/a"
  )
  result <- count_ports(url)
  expected <- tibble::tibble(
    port = c(80, 8080, NA),
    n = c(1, 1, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_ports() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "http://example.com:8080/", "http://example.com:8080/", "http://example.com/a"
  )
  result <- count_ports(url, sort = TRUE)
  expected <- tibble::tibble(
    port = c(8080, NA),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# count_paths() tests -----------------------------------------------------

# Test that the function returns a tibble with correctly counted paths

test_that("count_paths() returns a tibble with correctly counted paths", {
  url <- c(
    "http://example.com/b", "http://example.com/a", "http://example.com/b"
  )
  result <- count_paths(url)
  expected <- tibble::tibble(
    path = c("/a", "/b"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_paths() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "http://example.com/b", "http://example.com/a", "http://example.com/b"
  )
  result <- count_paths(url, sort = TRUE)
  expected <- tibble::tibble(
    path = c("/b", "/a"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_paths() returns a tibble with the correct column name", {
  url <- c(
    "http://example.com/b", "http://example.com/a", "http://example.com/b"
  )
  result <- count_paths(url, name = "count")
  expected <- tibble::tibble(
    path = c("/a", "/b"),
    count = c(1, 2)
  )
  expect_equal(result, expected)
})


# count_queries() tests ---------------------------------------------------

# Test that the function returns a tibble with correctly counted queries

test_that("count_queries() returns a tibble with correctly counted queries", {
  url <- c(
    "http://example.com/?b=1", "http://example.com/?a=1", "http://example.com/?b=1"
  )
  result <- count_queries(url)
  expected <- tibble::tibble(
    query = c("a=1", "b=1"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_queries() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "http://example.com/?b=1", "http://example.com/?b=1", "http://example.com/?a=1"
  )
  result <- count_queries(url, sort = TRUE)
  expected <- tibble::tibble(
    query = c("b=1", "a=1"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_queries() returns a tibble with the correct column name", {
  url <- c(
    "http://example.com/?b=1", "http://example.com/?a=1", "http://example.com/?b=1"
  )
  result <- count_queries(url, name = "count")
  expected <- tibble::tibble(
    query = c("a=1", "b=1"),
    count = c(1, 2)
  )
  expect_equal(result, expected)
})


# count_fragments() tests -------------------------------------------------

# Test that the function returns a tibble with correctly counted fragments

test_that("count_fragments() returns a tibble with correctly counted fragments", {
  url <- c(
    "http://example.com/#b", "http://example.com/#a", "http://example.com/#b"
  )
  result <- count_fragments(url)
  expected <- tibble::tibble(
    fragment = c("a", "b"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_fragments() returns a tibble sorted by desc(n) when sort = TRUE", {
  url <- c(
    "http://example.com/#b", "http://example.com/#b", "http://example.com/#a"
  )
  result <- count_fragments(url, sort = TRUE)
  expected <- tibble::tibble(
    fragment = c("b", "a"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_fragments() returns a tibble with the correct column name", {
  url <- c(
    "http://example.com/#b", "http://example.com/#a", "http://example.com/#b"
  )
  result <- count_fragments(url, name = "count")
  expected <- tibble::tibble(
    fragment = c("a", "b"),
    count = c(1, 2)
  )
  expect_equal(result, expected)
})


# count_path_segments() tests ----------------------------------------------

# Test that the function returns a tibble with correctly counted path segments

test_that("count_path_segments() returns a tibble with correctly counted path segments", {
  path <- c(
    "/path/to/resource", "/path/to/resource/", "/another/path", "/empty/", "/"
  )
  result <- count_path_segments(path, 2)
  expected <- tibble::tibble(
    path_segment = c("path", "to", NA),
    n = c(1, 2, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_path_segments() returns a tibble sorted by desc(n) when sort = TRUE", {
  path <- c(
    "/path/to/resource", "/path/to/resource/", "/another/path", "/empty/", "/"
  )
  result <- count_path_segments(path, 2, sort = TRUE)
  expected <- tibble::tibble(
    path_segment = c("to", NA, "path"),
    n = c(2, 2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_path_segments() returns a tibble with the correct column name", {
  path <- c(
    "/path/to/resource", "/path/to/resource/", "/another/path", "/empty/", "/"
  )
  result <- count_path_segments(path, 2, name = "count")
  expected <- tibble::tibble(
    path_segment = c("path", "to", NA),
    count = c(1, 2, 2)
  )
  expect_equal(result, expected)
})


# count_param_values() tests ----------------------------------------------

# Test that the function returns a tibble with correctly counted param values

test_that("count_param_values() returns a tibble with correctly counted param values", {
  query <- c(
    "a=1&b=2", "a=1&b=3", "a=1&b=3"
  )
  result <- count_param_values(query, "b")
  expected <- tibble::tibble(
    param_value = c("2", "3"),
    n = c(1, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_param_values() returns a tibble sorted by desc(n) when sort = TRUE", {
  query <- c(
    "a=1&b=2", "a=1&b=3", "a=1&b=3"
  )
  result <- count_param_values(query, "b", sort = TRUE)
  expected <- tibble::tibble(
    param_value = c("3", "2"),
    n = c(2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_param_values() returns a tibble with the correct column name", {
  query <- c(
    "a=1&b=2", "a=1&b=3", "a=1&b=3"
  )
  result <- count_param_values(query, "b", name = "count")
  expected <- tibble::tibble(
    param_value = c("2", "3"),
    count = c(1, 2)
  )
  expect_equal(result, expected)
})


# count_param_names() tests -----------------------------------------------

# Test that the function returns a tibble with correctly counted param names

test_that("count_param_names() returns a tibble with correctly counted param names", {
  query <- c("a=1&b=2", "b=3&c=4", "b=5&c=6")
  result <- count_param_names(query)
  expected <- tibble::tibble(
    param_name = c("a", "b", "c"),
    n = c(1, 3, 2)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble sorted by desc(n) when sort = TRUE

test_that("count_param_names() returns a tibble sorted by desc(n) when sort = TRUE", {
  query <- c("a=1&b=2", "b=3&c=4", "b=5&c=6")
  result <- count_param_names(query, sort = TRUE)
  expected <- tibble::tibble(
    param_name = c("b", "c", "a"),
    n = c(3, 2, 1)
  )
  expect_equal(result, expected)
})

# Test that the function returns a tibble with the correct column name

test_that("count_param_names() returns a tibble with the correct column name", {
  query <- c("a=1&b=2", "b=3&c=4", "b=5&c=6")
  result <- count_param_names(query, name = "count")
  expected <- tibble::tibble(
    param_name = c("a", "b", "c"),
    count = c(1, 3, 2)
  )
  expect_equal(result, expected)
})
