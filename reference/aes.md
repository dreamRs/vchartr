# Construct aesthetic mappings

See [`ggplot2::aes()`](https://ggplot2.tidyverse.org/reference/aes.html)
for details.

## Usage

``` r
aes(x, y, ...)
```

## Arguments

- x, y, ...:

  \<[`data-masking`](https://rlang.r-lib.org/reference/topic-data-mask.html)\>
  List of name-value pairs in the form `aesthetic = variable` describing
  which variables in the layer data should be mapped to which aesthetics
  used by the paired geom/stat. The expression `variable` is evaluated
  within the layer data, so there is no need to refer to the original
  dataset (i.e., use `ggplot(df, aes(variable))` instead of
  `ggplot(df, aes(df$variable))`). The names for x and y aesthetics are
  typically omitted because they are so common; all other aesthetics
  must be named.

## Value

A list with class `uneval`. Components of the list are either quosures
or constants.
