# Quote faceting variables

See
[`ggplot2::vars()`](https://ggplot2.tidyverse.org/reference/vars.html)
for details.

## Usage

``` r
vars(...)
```

## Arguments

- ...:

  \<[`data-masking`](https://rlang.r-lib.org/reference/topic-data-mask.html)\>
  Variables or expressions automatically quoted. These are evaluated in
  the context of the data to form faceting groups. Can be named (the
  names are passed to a
  [labeller](https://ggplot2.tidyverse.org/reference/labellers.html)).

## Value

A list with class `uneval`. Components of the list are either quosures
or constants.
