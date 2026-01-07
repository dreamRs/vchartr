# charts

``` r
library(vchartr)
```

## Bar Chart

Create bar charts with
[`v_bar()`](https://dreamrs.github.io/vchartr/reference/v_bar.md):

``` r
electricity_mix %>% 
  subset(country %in% c("France", "South Korea")) %>% 
  vchart() %>% 
  v_bar(aes(country, generation, fill = source)) %>%
  v_scale_color_manual(c(
    "oil" = "#80549f",
    "coal" = "#a68832",
    "solar" = "#d66b0d",
    "gas" = "#f20809",
    "wind" = "#72cbb7",
    "hydro" = "#2672b0",
    "nuclear" = "#e4a701"
  ))
```

## Line Chart

Create line charts with
[`v_line()`](https://dreamrs.github.io/vchartr/reference/v_line.md):

``` r
vchart(eco2mix) %>% 
  v_line(aes(date, solar)) %>% 
  v_specs_datazoom()
```

## Area Chart

Create area charts with
[`v_area()`](https://dreamrs.github.io/vchartr/reference/v_area.md):

``` r
vchart(eco2mix_long) %>%
  v_area(aes(date, production, fill = source), stack = TRUE) %>% 
  v_scale_y_continuous(min = -2000)
```

Create area range charts with
[`v_area()`](https://dreamrs.github.io/vchartr/reference/v_area.md) and
providing `ymin` and `ymax` aesthetics:

``` r
vchart(temperatures, aes(date)) %>%
  v_area(aes(ymin = low, ymax = high))
```

## Pie Chart

Create pie or donut charts with
[`v_pie()`](https://dreamrs.github.io/vchartr/reference/v_pie.md):

``` r
subset(world_electricity, year == 2023 & type == "total") %>%
  vchart() %>% 
  v_pie(aes(x = source, y = generation))
```

## Histogram Chart

Create histograms with
[`v_hist()`](https://dreamrs.github.io/vchartr/reference/v_hist.md):

``` r
vchart(palmerpenguins::penguins) %>%
  v_hist(
    aes(flipper_length_mm),
    bar = list(
      style = list(
        stroke = "white",
        line_width = 1,
        fill = "forestgreen"
      )
    )
  )
#> Warning: Removed 2 rows containing non-finite outside the scale range
#> (`stat_bin()`).
```

## Scatter Chart

Create scatter charts with
[`v_scatter()`](https://dreamrs.github.io/vchartr/reference/v_scatter.md):

``` r
vchart(palmerpenguins::penguins) %>%
  v_scatter(
    aes(x = flipper_length_mm, y = body_mass_g, color = species)
  )
```

## Smooth Chart

Create smooth charts with
[`v_smooth()`](https://dreamrs.github.io/vchartr/reference/v_smooth.md):

``` r
vchart(palmerpenguins::penguins) %>%
  v_smooth(
    aes(x = flipper_length_mm, y = body_mass_g, color = species)
  )
#> `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
#> Warning: Removed 2 rows containing non-finite outside the scale range
#> (`stat_smooth()`).
```

## Boxplot

Create boxplots with
\`[`v_boxplot()`](https://dreamrs.github.io/vchartr/reference/v_boxplot.md):

``` r
vchart(palmerpenguins::penguins) %>%
  v_boxplot(
    aes(x = species, y = body_mass_g)
  )
#> Warning: Removed 2 rows containing non-finite outside the scale range
#> (`stat_boxplot()`).
#> Removed 2 rows containing non-finite outside the scale range
#> (`stat_boxplot()`).
```

## Jittered points

Create jittered points chart with
[`v_jitter()`](https://dreamrs.github.io/vchartr/reference/v_jitter.md):

``` r
vchart(palmerpenguins::penguins) %>%  
  v_jitter(aes(species, bill_length_mm))
```

## Heatmap

Create heatmaps with
[`v_heatmap()`](https://dreamrs.github.io/vchartr/reference/v_heatmap.md):

``` r
vchart(co2_emissions) %>%
  v_heatmap(aes(x = year, y = country, fill = co2_per_capita))
```

## Treemap

Create treemaps with
[`v_treemap()`](https://dreamrs.github.io/vchartr/reference/v_treemap.md):

``` r
vchart(countries_gdp) %>%
  v_treemap(
    aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD),
    label = list(visible = TRUE),
    nonLeaf = list(visible = TRUE),
    nonLeafLabel = list(visible = TRUE, position = "top")
  )
```

## Circlepacking

Create circlepacking charts with
[`v_circlepacking()`](https://dreamrs.github.io/vchartr/reference/v_circlepacking.md):

``` r
vchart(countries_gdp) %>%
  v_circlepacking(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
  )
```

## Sankey Chart

Create sankey charts with
[`v_sankey()`](https://dreamrs.github.io/vchartr/reference/v_sankey.md):

``` r
vchart(energy_sankey) %>%
  v_sankey(aes(target, source, value = value))
```

## WordCloud

Create wordclouds with
[`v_wordcloud()`](https://dreamrs.github.io/vchartr/reference/v_wordcloud.md):

``` r
vchart(top_cran_downloads) %>%
  v_wordcloud(aes(word = package, count = count, color = package))
```

## Venn Diagram

Create venn diagrams with `v_venn`:

``` r
data.frame(
  sets = c("A", "B", "C", "A,B", "A,C", "B,C", "A,B,C"),
  value = c(8, 10, 12, 4, 4, 4, 2)
) %>% 
  vchart() %>% 
  v_venn(aes(sets = sets, value = value))
```

## Waterfall Chart

Create waterfall charts with `v_waterfall`:

``` r
data.frame(
  desc = c("Starting Cash",
           "Sales", "Refunds", "Payouts", "Court Losses",
           "Court Wins", "Contracts", "End Cash"),
  amount = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800)
) %>% 
  vchart() %>% 
  v_waterfall(aes(x = desc, y = amount))
```

## Sunburst Chart

Create sunburst charts with `v_sunburst`:

``` r
vchart(countries_gdp) %>%
  v_sunburst(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
    gap = 10,
    labelAutoVisible = list(
      enable = TRUE
    ),
    labelLayout = list(
      align = "center",
      rotate = "radial"
    )
  )
```
