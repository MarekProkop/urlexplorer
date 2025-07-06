# Input is always a character vector. All functions return a character vector of
# the same length as the input vector, containing the extracted component or
# value.

# Internal regex patterns for URL components
.url_scheme_pattern <- "^(https?)"
.url_userinfo_pattern <- "://([^@/]+)@"
.url_host_pattern <- "://(?:[^@/]+@)?([^:/]+)"
.url_port_pattern <- "://[^/]+:(\\d+)"
.url_path_pattern <- "://[^/]+(/[^?#]*)"
.url_query_pattern <- "\\?([^#]*)"
.url_fragment_pattern <- "#(.*)"

#' Extract the scheme from URL
#'
#' @param url A character vector of URLs.
#'
#' @return A character vector containing the scheme from each URL.
#' @export
#'
#' @examples
#' extract_scheme(c("http://example.com", "https://example.com"))
extract_scheme <- function(url) {
  # Fast direct scheme extraction using regex
  stringr::str_extract(url, .url_scheme_pattern, group = 1)
}

#' Extract userinfo from URL
#'
#' @param url A character vector of URLs.
#'
#' @return A character vector containing the userinfo from each URL, if present.
#' @export
#'
#' @examples
#' extract_userinfo(c("http://user:pass@example.com"))
extract_userinfo <- function(url) {
  # Fast direct userinfo extraction using regex
  stringr::str_extract(url, .url_userinfo_pattern, group = 1)
}

#' Extract the host from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the host from each URL.
#' @export
#' @examples
#' extract_host(c("https://example.com", "http://www.example.com"))
extract_host <- function(url) {
  # Fast direct host extraction using regex
  stringr::str_extract(url, .url_host_pattern, group = 1)
}

#' Extract the port number from URL
#'
#' @param url A character vector of URLs.
#'
#' @return A character vector containing the port number from each URL, if
#'   specified.
#' @export
#'
#' @examples
#' extract_port(c("http://example.com:8080"))
extract_port <- function(url) {
  # Fast direct port extraction using regex
  port_str <- stringr::str_extract(url, .url_port_pattern, group = 1)
  as.integer(port_str)
}

#' Extract the path from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the path from each URL.
#' @export
#' @examples
#' extract_path(c("http://example.com/", "http://example.com/path/to/resource"))
extract_path <- function(url) {
  # Fast direct path extraction using regex
  stringr::str_extract(url, .url_path_pattern, group = 1)
}

#' Extract the query from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the query string from each URL.
#' @export
#' @examples
#' extract_query(c(
#'   "http://example.com?query1=value1&query2=value2",
#'   "http://example.com?query1=value3"
#' ))
extract_query <- function(url) {
  # Fast direct query extraction using regex
  stringr::str_extract(url, .url_query_pattern, group = 1)
}

#' Extract the fragment from URL
#'
#' @param url A character vector of URLs.
#'
#' @return A character vector containing the fragment from each URL, if present.
#' @export
#'
#' @examples
#' extract_fragment(c("http://example.com/#sec1", "http://example.com/#sec2"))
extract_fragment <- function(url) {
  # Fast direct fragment extraction using regex
  stringr::str_extract(url, .url_fragment_pattern, group = 1)
}

#' Extract a specific segment from a path
#'
#' @param path A character vector of paths.
#' @param segment_index The index of the segment to extract.
#'
#' @return A character vector containing the specified segment from each path.
#' @export
#'
#' @examples
#' extract_path_segment(c("/path/to/resource", "/another/path/"), 2)
extract_path_segment <- function(path, segment_index) {
  # Fast direct path segment extraction without calling split_path()
  # Remove leading slash and split by slash
  clean_paths <- stringr::str_remove(path, "^/")
  segments_list <- stringr::str_split(clean_paths, "/", simplify = FALSE)
  
  # Extract the specific segment index
  sapply(segments_list, function(segments) {
    if (length(segments) >= segment_index && segments[segment_index] != "") {
      segments[segment_index]
    } else {
      NA_character_
    }
  })
}

#' Extract the value of a specified parameter from the query string
#'
#' @param query A character vector of query strings.
#' @param param_name The name of the parameter to extract values for.
#'
#' @return A character vector containing the value of the specified parameter
#'   from each query string.
#' @export
#'
#' @examples
#' extract_param_value(c("param1=val1&param2=val2", "param1=val3"), "param1")
extract_param_value <- function(query, param_name) {
  # Fast direct regex extraction (same pattern as count_param_values)
  param_pattern <- paste0("(?:^|&)", stringr::fixed(param_name), "=([^&]*)")
  stringr::str_extract(query, param_pattern, group = 1)
}

#' Extract file extension from URLs or paths
#'
#' This function parses each input URL or path and extracts the file extension,
#' if present. It is particularly useful for identifying the type of files
#' referenced in URLs.
#'
#' @param url A character vector of URLs or paths from which to extract file
#'   extensions.
#'
#' @return A character vector with the file extension for each URL or path.
#'   Extensions are returned without the dot (e.g., "jpg" instead of ".jpg"),
#'   and URLs or paths without extensions will return `NA`.
#' @export
#'
#' @examples
#' extract_file_extension(
#'   c(
#'     "http://example.com/image.jpg",
#'     "https://example.com/archive.zip",
#'     "http://example.com/"
#'   )
#' )
extract_file_extension <- function(url) {
  # For URLs, extract path first; for paths, use directly
  paths <- ifelse(
    stringr::str_detect(url, "^https?://"),
    extract_path(url),
    url
  )
  
  # Extract file extension (everything after the last dot in the filename)
  # Remove query and fragment parts first
  clean_paths <- stringr::str_remove(paths, "[?#].*$")
  stringr::str_extract(clean_paths, "\\.([^./]+)$", group = 1)
}
