## code to prepare `websitepages` dataset goes here

library(dplyr)
library(stringi)  # For generating random alphanumeric strings

# Helper function to generate random paths
generate_paths <- function(n) {
  base <- c("products", "about", "services", "blog", "help", "user")
  detail <- c("detail", "info", "data", "specs", "summary", "profile")
  ids <- stri_rand_strings(n, 5, pattern = "[0-9a-z]")

  paths <- vector("character", n)
  for (i in seq_len(n)) {
    depth <- sample(1:3, 1)  # Decide how many levels deep the path should go
    if (depth == 1) {
      paths[i] <- sample(base, 1)
    } else if (depth == 2) {
      paths[i] <- paste(sample(base, 1), sample(detail, 1), sep = "/")
    } else {
      paths[i] <- paste(sample(base, 1), sample(detail, 1), ids[i], sep = "/")
    }
  }
  return(paths)
}

# Generate random queries and fragments
generate_queries_and_fragments <- function(n) {
  parameters <- c("id", "type", "category", "session")
  values <- stri_rand_strings(n, 8, pattern = "[0-9a-zA-Z]")
  queries <- paste(sample(parameters, n, replace = TRUE), values, sep = "=")
  fragments <- paste("section", sample(c(1:10, NA), n, replace = TRUE), sep = "")

  # Randomly assign empty queries or fragments
  queries[sample(n, n/10)] <- ""  # 10% have no query
  fragments[sample(n, n/5)] <- "" # 20% have no fragment

  return(list(queries = queries, fragments = fragments))
}

# Simulate a typical website structure
set.seed(123)  # For reproducibility
n <- 1000
subdomains <- sample(c("www", "shop", "blog"), n, replace = TRUE, prob = c(0.6, 0.3, 0.1))
paths <- generate_paths(n)
query_frag <- generate_queries_and_fragments(n)

# Assemble the URLs
urls <- paste0("https://", subdomains, ".example.com/", paths,
  ifelse(query_frag$queries != "", paste0("?", query_frag$queries), ""),
  ifelse(query_frag$fragments != "", paste0("#", query_frag$fragments), ""))

# Create the data frame
websitepages <- tibble::tibble(page = urls)

# Print the first few URLs to check
head(websitepages)


usethis::use_data(websitepages, overwrite = TRUE)
