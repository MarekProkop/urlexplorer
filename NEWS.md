# urlexplorer 0.1.0

## Major improvements

* **Performance optimization**: Dramatically improved performance across all functions
  - `count_param_names()` now processes 500,000+ queries per second (1000x+ speedup)
  - `split_query()` completely rewritten with efficient vectorized operations
  - `extract_path_segment()` optimized with direct string operations
  - All extract functions now use direct regex patterns instead of split operations

* **Dependency reduction**: Removed external dependencies for better reliability
  - Removed `xml2` package dependency
  - Removed `urltools` package dependency  
  - Removed `purrr` package dependency
  - Removed `tidyselect` package dependency
  - All URL parsing now uses efficient `stringr`-based implementations

* **Code quality improvements**: 
  - Consistent regex patterns shared across functions
  - Standardized documentation and examples
  - Improved error handling and edge cases
  - All functions follow consistent input/output patterns

* **R version update**: Updated minimum R version to 4.1.0 to support native pipe `|>` and function shorthand `\()` syntax

## Bug fixes

* Fixed userinfo extraction in URLs containing @ symbols in paths
* Improved handling of malformed URLs and edge cases
* Fixed variable binding issues in `split_url()` function

## Package structure

* Added comprehensive performance tests to prevent regressions
* Improved package documentation and examples
* Added `.Rbuildignore` entries for development files