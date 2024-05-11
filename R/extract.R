#' Extract the scheme from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the scheme from each URL.
#' @export
#' @examples
#' extract_scheme(c("http://example.com", "https://example.com"))
extract_scheme <- function(url) {
  split_url(url)$scheme
}

#' Extract userinfo from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the userinfo from each URL, if present.
#' @export
#' @examples
#' extract_userinfo(c("user:pass@example.com"))
extract_userinfo <- function(url) {
  split_url(url)$userinfo
}

#' Extract the host from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the host from each URL.
#' @export
#' @examples
#' extract_host(c("https://example.com", "http://www.example.com"))
extract_host <- function(url) {
  split_url(url)$host
}

#' Extract the port number from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the port number from each URL, if
#'   specified.
#' @export
#' @examples
#' extract_port(c("http://example.com:8080"))
extract_port <- function(url) {
  split_url(url)$port
}

#' Extract the path from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the path from each URL.
#' @export
#' @examples
#' extract_path(c("http://example.com/", "http://example.com/path/to/resource"))
extract_path <- function(url) {
  split_url(url)$path
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
  split_url(url)$query
}

#' Extract the fragment from URL
#'
#' @param url A character vector of URLs.
#' @return A character vector containing the fragment from each URL, if present.
#' @export
#' @examples
#' extract_fragment(c("http://example.com/#sec1", "http://example.com/#sec2"))
extract_fragment <- function(url) {
  split_url(url)$fragment
}

#' Extract a specific segment from a path
#'
#' @param path A character vector of paths.
#' @param segment_index The index of the segment to extract.
#' @return A character vector containing the specified segment from each path.
#' @export
#' @examples
#' extract_path_segment(c("/path/to/resource", "/another/path/"), 2)
extract_path_segment <- function(path, segment_index) {
  split_path(path)[[segment_index]]
}

#' Extract the value of a specified parameter from the query string
#'
#' @param query A character vector of query strings.
#' @param param_name The name of the parameter to extract values for.
#' @return A character vector containing the value of the specified parameter
#'   from each query string.
#' @export
#' @examples
#' extract_param_value(c("param1=val1&param2=val2", "param1=val3"), "param1")
extract_param_value <- function(query, param_name) {
  split_query(query)[[param_name]]
}

#' Extract file extension from URLs or paths
#'
#' This function parses each input URL or path and extracts the file extension,
#' if present. It is particularly useful for identifying the type of files
#' referenced in URLs.
#'
#' @param url A character vector of URLs or paths from which to extract file
#'   extensions.
#' @return A character vector with the file extension for each URL or path.
#'   Extensions are returned without the dot (e.g., "jpg" instead of ".jpg"),
#'   and URLs or paths without extensions will return `NA`.
#' @export
#' @examples
#' extract_file_extension(
#'   c(
#'     "http://example.com/image.jpg",
#'     "https://example.com/archive.zip",
#'     "http://example.com/"
#'   )
#' )
extract_file_extension <- function(url) {
  stringr::str_extract(extract_path(url), "\\.([^.]+)$", group = 1)
}
