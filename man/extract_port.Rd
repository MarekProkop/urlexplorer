% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract.R
\name{extract_port}
\alias{extract_port}
\title{Extract the port number from URL}
\usage{
extract_port(url)
}
\arguments{
\item{url}{A character vector of URLs.}
}
\value{
A character vector containing the port number from each URL, if
specified.
}
\description{
Extract the port number from URL
}
\examples{
extract_port(c("http://example.com:8080"))
}
