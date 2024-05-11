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
  xml2::url_parse(url) |>
    tibble::as_tibble() |>
    dplyr::rename(host = "server", userinfo = "user") |>
    dplyr::mutate(dplyr::across(dplyr::where(is.character), ~ dplyr::na_if(., "")))
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
#' @return A tibble with one row per path and columns for each segment separated
#'   by '/'.
#' @export
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
#' @return A tibble with one row per query string and columns for each
#'   parameter, column names as parameter names.
#' @export
#' @examples
#' split_query(c("param1=value1&param2=value2"))
split_query <- function(query) {
  paste0("?", query) |>
    urltools::param_get() |>
    tibble::as_tibble()
}
