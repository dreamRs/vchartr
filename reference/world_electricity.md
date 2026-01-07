# World low carbon & fossil electricity generation 2014 - 2023

This dataset represents world's electricity generation from low-carbon
sources and fossil fuels over the period 2014 - 2023.

## Usage

``` r
world_electricity
```

## Format

A data frame with 70 observations and 4 variables:

- `year` : Year

- `source` : Either :

  - `Low carbon` : Electricity generation from low-carbon sources -
    Low-carbon sources correspond to renewables and nuclear power, that
    produce significantly less greenhouse-gas emissions than fossil
    fuels.

  - `Renewables` : Electricity generation from renewables

  - `Nuclear` : Electricity generation from nuclear

  - `Fossil` : Electricity generation from fossil fuels (oil + gas +
    coal)

  - `Oil` : Electricity generation from fossil fuels

  - `Gas` : Electricity generation from fossil fuels

  - `Coal` : Electricity generation from fossil fuels

- `generation` : Electricity generation in terawatt-hours.

- `type` : Type of source : total or detail.

## Source

[Our World In Data](https://github.com/owid/energy-data)
