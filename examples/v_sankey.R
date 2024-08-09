
library(vchartr)

# Basic Sankey Chart
vchart(energy_sankey) %>%
  v_sankey(aes(target, source, value = value))

# Some options
vchart(energy_sankey) %>%
  v_sankey(
    aes(target, source, value = value),
    nodeAlign = "left",
    nodeGap = 8,
    nodeWidth = 10,
    minNodeHeight = 4,
    link = list(
      state = list(
        hover = list(
          fillOpacity = 1
        )
      )
    )
  )


# With data as tree structure
vchart(as.data.frame(Titanic)) %>%
  v_sankey(aes(
    lvl1 = Class, lvl2 = Sex, lvl3 = Age, lvl4 = Survived,
    value = Freq
  ))
