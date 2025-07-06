# Input is always a character vector. All functions return a tibble with a
# number of rows equal to the length of the input vector, and each column
# corresponds to a component of the input.

#' Split URL into its constituent parts
#'
#' @param url A character vector of URLs to be split.
#'
#' @return A tibble with one row per URL and columns for each component: scheme,
#'   host, port, userinfo, path, query, and fragment.
#' @export
#'
#' @examples
#' split_url(c("https://example.com/path?query=arg#frag"))
split_url <- function(url) {
  # URL regex pattern to extract all components
  # Pattern: scheme://[userinfo@]host[:port][/path][?query][#fragment]
  # More careful userinfo pattern to avoid matching @ in paths
  url_pattern <- "^(https?://)(?:([^@/]+)@)?([^:/]+)(?::(\\d+))?(/[^?#]*)?(?:\\?([^#]*))?(?:#(.*))?$"
  
  # Extract components using stringr
  components <- stringr::str_match(url, url_pattern)
  
  tibble::tibble(
    scheme = stringr::str_remove(components[, 2], "://"),
    host = components[, 4],
    port = as.integer(components[, 5]),
    userinfo = components[, 3],
    path = components[, 6],
    query = components[, 7],
    fragment = components[, 8]
  ) |>
    dplyr::mutate(
      # URL decode path and fragment for common encoded characters
      path = ifelse(!is.na(.data$path), URLdecode(.data$path), .data$path),
      fragment = ifelse(!is.na(.data$fragment), URLdecode(.data$fragment), .data$fragment),
      dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(., ""))
    )
}

#' Split host into subdomains and domain
#'
#' @param host A character vector of hostnames to be split.
#'
#' @return A tibble with one row per hostname and columns for top-level domain,
#'   domain and subdomains. Columns are created as many as the number of hosts'
#'   components and are named as tld, domain, subdomain_1, subdomain_2, etc.
#' @export
#'
#' @examples
#' split_host(c("subdomain.example.com"))
#' split_host(c("subdomain2.subdomain1.example.com", "example.com"))
split_host <- function(host) {
  result <- tibble::tibble(host = host) |>
    tidyr::separate_wider_delim(
      host, ".", names_sep = "_", too_few = "align_end"
    ) |>
    rev()
  names(result) <- c(
    "tld", "domain", paste0("subdomain_", seq_len(ncol(result) - 2))
  )
  result
}

#' Split path into segments
#'
#' @param path A character vector of paths to be split.
#'
#' @return A tibble with one row per path and columns for each segment separated
#'   by '/'.
#' @export
#'
#' @examples
#' split_path(c("/path/to/resource"))
split_path <- function(path) {
  tibble::tibble(path = stringr::str_remove(path, "^/")) |>
    tidyr::separate_wider_delim(path, "/", names_sep = "_", too_few = "align_start") |>
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(., "")))
}

#' Split query into parameters
#'
#' @param query A character vector of query strings to be split.
#'
#' @return A tibble with one row per query string and columns for each
#'   parameter, column names as parameter names.
#' @export
#'
#' @examples
#' split_query(c("param1=value1&param2=value2"))
split_query <- function(query) {
  # Handle NA and empty queries
  if (all(is.na(query) | query == "")) {
    return(tibble::tibble(.rows = length(query)))
  }
  
  # Clean query strings
  query_clean <- stringr::str_remove(query, "^\\?")  # Remove leading ? if present
  query_clean[is.na(query)] <- NA_character_  # Preserve NAs
  
  # Get all unique parameter names efficiently
  all_param_names <- query_clean[!is.na(query_clean) & query_clean != ""] |>
    stringr::str_split("&") |>
    unlist() |>
    stringr::str_extract("^[^=]+") |>
    (\(x) x[!is.na(x)])() |>
    unique() |>
    sort()
  
  # Create result tibble with one row per query
  result <- tibble::tibble(.rows = length(query))
  
  # Extract values for each parameter using vectorized operations
  for (param_name in all_param_names) {
    param_pattern <- paste0("(?:^|&)", stringr::fixed(param_name), "=([^&]*)")
    result[[param_name]] <- stringr::str_extract(query_clean, param_pattern, group = 1)
  }
  
  result
}
