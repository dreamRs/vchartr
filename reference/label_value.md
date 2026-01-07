# Useful labeller functions

See
[`ggplot2::label_value()`](https://ggplot2.tidyverse.org/reference/labellers.html)
for details.

## Usage

``` r
label_value(labels, multi_line = TRUE)
```

## Arguments

- labels:

  Data frame of labels. Usually contains only one element, but faceting
  over multiple factors entails multiple label variables.

- multi_line:

  Whether to display the labels of multiple factors on separate lines.

## Value

Labels to be used in a facetted chart.
