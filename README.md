# vchartr

> R Htmlwidget for [VChart](https://github.com/VisActor/VChart) : VChart is a charting component library in VisActor visualization system.. See the [online documentation](https://www.visactor.io/vchart) for examples.

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->


## Installation

You can install the development version of vchartr from [GitHub](https://github.com/dreamRs/vchartr) with:

```r
# install.packages("remotes")
remotes::install_github("dreamRs/vchartr")
```

## Examples

A scatter plot with [palmerpenguins](https://allisonhorst.github.io/palmerpenguins/) dataset and inspired from the documentation:

![](man/figures/scatterplot.png)

```r
library(vchartr)
library(palmerpenguins)
vchart(penguins) %>% 
  v_scatter(
    aes(
      x = bill_length_mm,
      y = bill_depth_mm,
      color = species, 
      shape = species
    )
  ) %>%
  v_smooth(
    aes(
      x = bill_length_mm,
      y = bill_depth_mm,
      color = species
    ),
    method = "lm",
    se = FALSE
  ) %>% 
  v_scale_x_continuous(
    name = "Bill length (mm)"
  ) %>% 
  v_scale_y_continuous(
    name = "Bill depth (mm)"
  ) %>% 
  v_labs(
    title = "Penguin bill dimensions",
    subtitle = "Bill length and depth for Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER"
  ) %>% 
  v_specs_legend(
    orient = "top",
    position = "start",
    layout = "vertical",
    layoutType = "absolute",
    right = 0,
    bottom = 40,
    title = list(
      visible = TRUE,
      text = "Penguin species"
    )
  )
```

