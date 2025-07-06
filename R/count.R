# Input is always a character vector of URLs, and the result is always a tibble
# with the component or aspect being counted in the first column and its counts
# in the second column (named `n`).

#' Count different schemes used in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each scheme and its count.
#' @export
#'
#' @examples
#' count_schemes(c("http://example.com", "https://example.com"))
count_schemes <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(scheme = extract_scheme(url)) |>
    dplyr::count(.data$scheme, sort = sort, name = name)
}

#' Count occurrences of userinfo in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble listing userinfos and how often each occurs.
#' @export
#'
#' @examples
#' count_userinfos(c("http://user:pass@example.com", "http://example.com"))
count_userinfos <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(userinfo = extract_userinfo(url)) |>
    dplyr::count(.data$userinfo, sort = sort, name = name)
}

#' Count different hosts found in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each host and its count.
#' @export
#'
#' @examples
#' count_hosts(c("http://example.com", "http://www.example.com"))
count_hosts <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(host = extract_host(url)) |>
    dplyr::count(.data$host, sort = sort, name = name)
}

#' Count different port numbers used in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each port and how many times it occurs.
#' @export
#'
#' @examples
#' count_ports(c("http://example.com:8080", "http://example.com:80"))
count_ports <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(port = extract_port(url)) |>
    dplyr::count(.data$port, sort = sort, name = name)
}

#' Count different paths found in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each path and its count.
#' @export
#'
#' @examples
#' count_paths(c("http://example.com/index", "http://example.com/home"))
count_paths <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(path = extract_path(url)) |>
    dplyr::count(.data$path, sort = sort, name = name)
}

#' Count the occurrence of query strings in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each query string and how often it occurs.
#' @export
#'
#' @examples
#' count_queries(c("http://example.com?query1=value1", "http://example.com?query2=value2"))
count_queries <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(query = extract_query(url)) |>
    dplyr::count(.data$query, sort = sort, name = name)
}

#' Count fragments in URLs
#'
#' @param url A character vector of URLs.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each fragment and its count.
#' @export
#'
#' @examples
#' count_fragments(c("http://example.com#top", "http://example.com#bottom"))
count_fragments <- function(url, sort = FALSE, name = "n") {
  tibble::tibble(fragment = extract_fragment(url)) |>
    dplyr::count(.data$fragment, sort = sort, name = name)
}

#' Count occurrences of specific path segments at a given index
#'
#' @param path A character vector of paths.
#' @param segment_index Index of the segment to count.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each segment at the specified index and how often it occurs.
#' @export
#'
#' @examples
#' count_path_segments(c("/path/to/resource", "/path/to/shop"), 2)
count_path_segments <- function(path, segment_index, sort = FALSE, name = "n") {
  tibble::tibble(path_segment = extract_path_segment(path, segment_index)) |>
    dplyr::count(.data$path_segment, sort = sort, name = name)
}

#' Count different values for a specified parameter across query strings
#'
#' @param query A character vector of query strings.
#' @param param_name The name of the parameter whose values to count.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each value of the specified parameter and how often it occurs.
#' @export
#'
#' @examples
#' count_param_values(c("param1=value1&param2=value2", "param1=value3"), "param1")
count_param_values <- function(query, param_name, sort = FALSE, name = "n") {
  # Remove NA queries and empty strings
  clean_query <- query[!is.na(query) & query != ""]
  
  # Fast vectorized approach: extract values for specific parameter directly
  param_pattern <- paste0("(?:^|&)", stringr::fixed(param_name), "=([^&]*)")
  param_values <- stringr::str_extract(clean_query, param_pattern, group = 1)
  
  tibble::tibble(param_value = param_values) |>
    dplyr::count(.data$param_value, sort = sort, name = name)
}

#' Count different parameter names in query strings
#'
#' @param query A character vector of query strings.
#' @param sort Logical indicating whether to sort the output by count. Defaults
#'   to FALSE.
#' @param name The name of the column containing the counts. Defaults to 'n'.
#'
#' @return A tibble with each parameter name and how often it occurs.
#' @export
#'
#' @examples
#' count_param_names(c("param1=value1&param2=value2", "param3=value3"))
count_param_names <- function(query, sort = FALSE, name = "n") {
  # Remove NA queries and empty strings
  clean_query <- query[!is.na(query) & query != ""]
  
  # Fast vectorized approach: split parameters and extract names directly
  clean_query |>
    stringr::str_split(pattern = "&") |>
    unlist() |>
    stringr::str_split_i(pattern = "=", i = 1) |>
    (\(x) tibble::tibble(param_name = x))() |>
    dplyr::count(.data$param_name, sort = sort, name = name)
}
