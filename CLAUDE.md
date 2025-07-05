# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an R package called `urlexplorer` that provides tools for parsing and analyzing URL datasets. It extracts key components and identifies common patterns to help examine website architecture and identify SEO issues.

## Package Structure

- **R/**: Contains the main package functions organized by functionality:
  - `split.R`: Functions to decompose URLs into components (split_url, split_host, split_path, split_query)
  - `extract.R`: Functions to retrieve specific URL components (extract_scheme, extract_host, etc.)
  - `count.R`: Functions to count occurrences of URL components (count_hosts, count_paths, etc.)
  - `data.R`: Data documentation
  - `urlexplorer-package.R`: Package documentation and imports

- **data/**: Contains `websitepages.rda` - sample dataset for examples
- **data-raw/**: Contains scripts to generate package data
- **tests/testthat/**: Unit tests for the three main function families
- **man/**: Generated documentation files

## Key Dependencies

From DESCRIPTION file:
- Core dependencies: dplyr, rlang, stringr, tibble, tidyr, tidyselect, urltools, xml2
- Testing: testthat (>= 3.0.0)
- Requires R >= 2.10

## Development Commands

Since R is installed on Windows (not WSL), ask the user to run R commands on Windows:

### Testing
- `devtools::test()` - Run all tests
- `testthat::test_dir("tests/testthat")` - Run tests in specific directory

### Documentation
- `devtools::document()` - Generate documentation from roxygen comments
- `devtools::check()` - Run R CMD check

### Package Building
- `devtools::build()` - Build source package
- `devtools::install()` - Install package locally

## Function Architecture

The package follows a consistent three-verb pattern:
1. **split_*()**: Returns tibbles with multiple columns for URL components
2. **extract_*()**: Returns character vectors of specific components
3. **count_*()**: Returns frequency tables as tibbles

All functions accept character vectors as input and handle missing components gracefully with NA values.

## Sample Data

Package includes `websitepages` dataset with 1000 sample URLs for testing and examples. Load with `data(websitepages)`.