
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
titanic <- as.data.frame(Titanic)
vchart(titanic) %>%
  v_sankey(aes(
    lvl1 = Class,
    lvl2 = Sex,
    lvl3 = Age,
    lvl4 = Survived,
    value = Freq
  ))


# Only one level
titanic_class <- titanic %>%
  aggregate(data = ., Freq ~ Class + Survived, FUN = sum)

vchart(titanic_class) %>%
  v_sankey(aes(Survived, Class, value = Freq))



