
<!-- README.md is generated from README.Rmd. Please edit that file -->

# urlexplorer

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/urlexplorer)](https://CRAN.R-project.org/package=urlexplorer)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/urlexplorer)](https://cran.r-project.org/package=urlexplorer)
<!-- badges: end -->

The goal of urlexplorer is to assist you with structural analysis and
pattern discovery within datasets of URLs. It provides tools for parsing
URLs into their constituent components and analyzing these components to
uncover insights into web site architecture and search engine
optimizations (SEO).

## Installation

You can install urlexplorer from
[CRAN](https://cran.r-project.org/package=urlexplorer) with:

``` r
install.packages("urlexplorer")
```

You can also install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("MarekProkop/urlexplorer")
```

## Functions

`urlexplorer` provides a toolkit for URL analysis structured around
three verbs: **split**, **extract**, and **count**.

### Split

These functions decompose a URL into its constituent components. Input
is a character vector, and each function returns a tibble with a number
of rows equal to the length of the input vector. Each column corresponds
to a component of the input.

- `split_url(url)`: Splits a URL into scheme, host, path, query, and
  fragment.
- `split_host(host)`: Separates the host into subdomains, domain, and
  top-level domain.
- `split_path(path)`: Divides the path into its individual segments.
- `split_query(query)`: Splits the query string into its parameters,
  with each parameter as a column.

### Extract

These functions are designed to retrieve specific components from a URL.
Input is always a character vector, and the output is a character vector
of the extracted component, matching the length of the input vector. If
any component is missing, the function returns `NA`.

- `extract_scheme(url)`: Extracts the URL scheme.
- `extract_userinfo(url)`: Retrieves userinfo component of the URL.
- `extract_host(url)`: Pulls the host component from the URL.
- `extract_port(url)`: Gets the port number from the URL.
- `extract_path(url)`: Extracts the path component.
- `extract_query(url)`: Retrieves the entire query string.
- `extract_fragment(url)`: Extracts the fragment portion of the URL.
- `extract_path_segment(path, segment_index)`: Extracts a specific
  segment of the path.
- `extract_param_value(query, param_name)`: Retrieves the value of a
  specified query parameter.
- `extract_file_extension(url)`: Extracts the file extension from the
  URL path.

### Count

These functions count occurrences of various URL components or
attributes, useful for quantitative analysis. Input is a character
vector, and the output is a tibble listing each component or attribute
with its count.

- `count_schemes(url)`: Counts the different schemes used in URLs.
- `count_userinfos(url)`: Tally of userinfo components.
- `count_hosts(url)`: Quantifies frequency of different hosts.
- `count_ports(url)`: Counts different port numbers used.
- `count_paths(url)`: Measures the occurrence of various paths.
- `count_queries(url)`: Counts the queries across URLs.
- `count_fragments(url)`: Tallies the fragments used in URLs.
- `count_path_segments(path, segment_index)`: Counts specific path
  segments.
- `count_param_names(query)`: Counts different parameter names in query
  strings.
- `count_param_values(query, param_name)`: Counts occurrences of values
  for a specific parameter.

## Examples

This is a basic examples which shows you how to solve a common problem.

### Declare libraries and sample data

``` r
library(urlexplorer)
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.5
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.5.2     ✔ tibble    3.3.0
#> ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
#> ✔ purrr     1.0.4     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
# Sample dataset included in the package

data(websitepages)
websitepages |> 
  slice_head(n = 10)
#> # A tibble: 10 × 1
#>    page                                                              
#>    <chr>                                                             
#>  1 https://www.example.com/blog?id=V6BsL494#section5                 
#>  2 https://shop.example.com/blog/specs?category=THXwLX1b             
#>  3 https://www.example.com/about?type=KP1bDjel#section4              
#>  4 https://shop.example.com/about/specs?id=Hu7DmR4e                  
#>  5 https://blog.example.com/services?type=9ndM1kiI#section1          
#>  6 https://www.example.com/services?category=cMlqq15a#section3       
#>  7 https://www.example.com/blog/detail/8jg4m?type=Rp1MrjwE           
#>  8 https://shop.example.com/products?category=uZUVQUO6#sectionNA     
#>  9 https://www.example.com/products/detail?id=qQGCCMfq#section7      
#> 10 https://www.example.com/services/data/2e0vz?type=CHQUkXxQ#section3
```

### Split URLs into components

``` r
websitepages$page |> 
  split_url() |> 
  slice_head(n = 10)
#> # A tibble: 10 × 7
#>    scheme host              port userinfo path                 query    fragment
#>    <chr>  <chr>            <int> <chr>    <chr>                <chr>    <chr>   
#>  1 https  www.example.com     NA <NA>     /blog                id=V6Bs… section5
#>  2 https  shop.example.com    NA <NA>     /blog/specs          categor… <NA>    
#>  3 https  www.example.com     NA <NA>     /about               type=KP… section4
#>  4 https  shop.example.com    NA <NA>     /about/specs         id=Hu7D… <NA>    
#>  5 https  blog.example.com    NA <NA>     /services            type=9n… section1
#>  6 https  www.example.com     NA <NA>     /services            categor… section3
#>  7 https  www.example.com     NA <NA>     /blog/detail/8jg4m   type=Rp… <NA>    
#>  8 https  shop.example.com    NA <NA>     /products            categor… section…
#>  9 https  www.example.com     NA <NA>     /products/detail     id=qQGC… section7
#> 10 https  www.example.com     NA <NA>     /services/data/2e0vz type=CH… section3
```

### Split hosts into subdomains, domain, and top-level domain

``` r
websitepages$page |> 
  extract_host() |>
  split_host() |> 
  slice_head(n = 10)
#> # A tibble: 10 × 3
#>    tld   domain  subdomain_1
#>    <chr> <chr>   <chr>      
#>  1 com   example www        
#>  2 com   example shop       
#>  3 com   example www        
#>  4 com   example shop       
#>  5 com   example blog       
#>  6 com   example www        
#>  7 com   example www        
#>  8 com   example shop       
#>  9 com   example www        
#> 10 com   example www
```

### Split paths into segments

``` r
websitepages$page |> 
  extract_path() |>
  split_path() |> 
  slice_head(n = 10)
#> # A tibble: 10 × 3
#>    path_1   path_2 path_3
#>    <chr>    <chr>  <chr> 
#>  1 blog     <NA>   <NA>  
#>  2 blog     specs  <NA>  
#>  3 about    <NA>   <NA>  
#>  4 about    specs  <NA>  
#>  5 services <NA>   <NA>  
#>  6 services <NA>   <NA>  
#>  7 blog     detail 8jg4m 
#>  8 products <NA>   <NA>  
#>  9 products detail <NA>  
#> 10 services data   2e0vz
```

### Get a frequency table of hosts

``` r
websitepages$page |> 
  count_hosts(sort = TRUE)
#> # A tibble: 3 × 2
#>   host                 n
#>   <chr>            <int>
#> 1 www.example.com    607
#> 2 shop.example.com   301
#> 3 blog.example.com    92
```

### Filter by host and count path segments

Identify the most common path 1st segments for a specific host.

``` r
websitepages |>
  filter(extract_host(page) == "www.example.com") |>
  pull(page) |>
  extract_path() |>
  count_path_segments(segment_index = 1) |> 
  slice_max(order_by = n, n = 5)
#> # A tibble: 5 × 2
#>   path_segment     n
#>   <chr>        <int>
#> 1 products       124
#> 2 help           108
#> 3 blog           100
#> 4 about           95
#> 5 user            91
```

### Frequency table of parametter names

#### Create a simple frequency table of query parameters

``` r
websitepages$page |>
  extract_query() |>
  count_param_names(sort = TRUE)
#> # A tibble: 4 × 2
#>   param_name     n
#>   <chr>      <int>
#> 1 category     235
#> 2 type         228
#> 3 session      219
#> 4 id           218
```

#### Add sample values for each parameter

A little bit more complex example: extract query parameters, count the
frequency of each parameter name, and provide a sample of values for
each parameter.

``` r
websitepages$page |>
  extract_query() |>
  split_query() |>
  pivot_longer(dplyr::everything()) |>
  drop_na(value) |>
  summarise(
    n = n(),
    values = unique(value) |>
      paste(collapse = ", ") |>
      str_trunc(40),
    .by = name
  ) |>
  arrange(desc(n))
#> # A tibble: 4 × 3
#>   name         n values                                  
#>   <chr>    <int> <chr>                                   
#> 1 category   235 THXwLX1b, cMlqq15a, uZUVQUO6, xS4RSMP...
#> 2 type       228 KP1bDjel, 9ndM1kiI, Rp1MrjwE, CHQUkXx...
#> 3 session    219 V3jghEMV, 1vzBsZqs, N1m1YcOd, Zm3vTmU...
#> 4 id         218 V6BsL494, Hu7DmR4e, qQGCCMfq, jLeGCg5...
```
