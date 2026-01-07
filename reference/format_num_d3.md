# Format numbers with D3

Format numbers with D3

## Usage

``` r
format_num_d3(format, prefix = "", suffix = "", locale = "en-US")
```

## Arguments

- format:

  Format for numbers, currency, percentage, e.g. `".0\%"` for rounded
  percentage. See online documentation :
  <https://github.com/d3/d3-format>.

- prefix:

  Character string to append before formatted value.

- suffix:

  Character string to append after formatted value.

- locale:

  Localization to use, for example `"fr-FR"` for french, see possible
  values here: <https://github.com/d3/d3-format/tree/master/locale>.

## Value

a `JS` function.

## Examples

``` r
library(vchartr)
```
