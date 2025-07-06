# Performance tests to ensure functions scale properly with large datasets

test_that("count_param_names() performance on large datasets", {
  skip_on_cran()
  
  # Create test dataset
  test_queries <- rep(c(
    "param1=value1&param2=value2&param3=value3",
    "param1=valueA&param4=valueB", 
    "param5=valueC&param1=valueD&param6=valueE",
    "param2=valueF&param7=valueG"
  ), 1000)  # 4000 queries
  
  # Benchmark current implementation
  start_time <- Sys.time()
  result <- count_param_names(test_queries)
  end_time <- Sys.time()
  
  # Realistic benchmark with safety margin (current: ~0.008s, allow up to 0.1s)
  elapsed_time <- as.numeric(end_time - start_time, units = "secs")
  expect_lt(elapsed_time, 0.1, 
            label = paste("count_param_names() took", round(elapsed_time, 3), "seconds - should be <0.1s"))
  
  # Should return correct structure
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("param_name", "n"))
  expect_true(nrow(result) > 0)
})

test_that("split_url() performance on large datasets", {
  skip_on_cran()
  
  # Create test dataset
  test_urls <- rep(c(
    "https://example.com/path?param1=value1&param2=value2#fragment",
    "http://subdomain.example.org:8080/longer/path/here?query=test",
    "https://another-domain.com/api/v1/endpoint?key=secret&format=json"
  ), 2000)  # 6000 URLs
  
  # Benchmark current implementation
  start_time <- Sys.time()
  result <- split_url(test_urls)
  end_time <- Sys.time()
  
  # Realistic benchmark with safety margin (current: ~0.073s, allow up to 0.5s)
  elapsed_time <- as.numeric(end_time - start_time, units = "secs")
  expect_lt(elapsed_time, 0.5,
            label = paste("split_url() took", round(elapsed_time, 3), "seconds - should be <0.5s"))
  
  # Should return correct structure
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 6000)
  expect_named(result, c("scheme", "host", "port", "userinfo", "path", "query", "fragment"))
})

test_that("count_hosts() performance on large datasets", {
  skip_on_cran()
  
  # Create test dataset with varied hosts
  test_urls <- rep(c(
    "https://example.com/page1",
    "https://www.example.com/page2", 
    "https://subdomain.example.org/page3",
    "http://another-site.net/page4",
    "https://blog.example.com/page5"
  ), 1500)  # 7500 URLs
  
  # Benchmark current implementation  
  start_time <- Sys.time()
  result <- count_hosts(test_urls)
  end_time <- Sys.time()
  
  # Realistic benchmark with safety margin (current: ~0.084s, allow up to 0.5s)
  elapsed_time <- as.numeric(end_time - start_time, units = "secs")
  expect_lt(elapsed_time, 0.5,
            label = paste("count_hosts() took", round(elapsed_time, 3), "seconds - should be <0.5s"))
  
  # Should return correct structure
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("host", "n"))
  expect_equal(nrow(result), 5)  # 5 unique hosts
})

test_that("count_param_values() performance on large datasets", {
  skip_on_cran()
  
  # Create test dataset
  test_queries <- rep(c(
    "category=electronics&brand=apple&price=high",
    "category=books&author=smith&genre=fiction",
    "category=electronics&brand=samsung&color=black", 
    "category=clothing&size=large&color=blue"
  ), 2000)  # 8000 queries
  
  # Benchmark current implementation
  start_time <- Sys.time()
  result <- count_param_values(test_queries, "category")
  end_time <- Sys.time()
  
  # Realistic benchmark with safety margin (current: ~0.005s, allow up to 0.05s)
  elapsed_time <- as.numeric(end_time - start_time, units = "secs")
  expect_lt(elapsed_time, 0.05,
            label = paste("count_param_values() took", round(elapsed_time, 3), "seconds - should be <0.05s"))
  
  # Should return correct structure
  expect_s3_class(result, "tbl_df")
  expect_named(result, c("param_value", "n"))
  expect_equal(nrow(result), 3)  # electronics, books, clothing
})