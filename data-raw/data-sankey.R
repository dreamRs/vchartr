
# source: https://www.visactor.io/vchart/demo/sankey-chart/basic-sankey

library(jsonlite)
library(data.table)


links <- fromJSON("data-raw/links.json")
setDT(links)
nodes <- fromJSON("data-raw/nodes.json")
setDT(nodes)
nodes[, nodeId := seq_len(.N) - 1]

energy_sankey <- merge(
  x = links,
  y = nodes[, list(source = nodeId, source_label = nodeName)],
  by = "source"
)
energy_sankey <- merge(
  x = energy_sankey,
  y = nodes[, list(target = nodeId, target_label = nodeName)],
  by = "target"
)
energy_sankey <- energy_sankey[, list(source = source_label, target = target_label, value)]


# mapdata <- as.data.frame(sankey_data)
# nodes <- data.frame(nodes = sort(unique(c(mapdata$source, mapdata$target))))
# nodes$nodes_id <- seq_len(nrow(nodes)) - 1
# links <- as.data.frame(mapdata)
# links$target <- nodes$nodes_id[match(links$target, nodes$nodes)]
# links$source <- nodes$nodes_id[match(links$source, nodes$nodes)]
# links


setDF(energy_sankey)
usethis::use_data(energy_sankey, overwrite = TRUE)



# Tests -------------------------------------------------------------------

vsankey(data, aes(target, source, value = value))

vsankey() %>%
  v_sankey_nodes(nodes_data, aes(name = nodeName)) %>%
  v_sankey_links(links_data, aes(target, source, value = value))

vsankey(list(nodes = nodes_data, links = links_data))

vchart(
  type = "sankey",
  data = list(
    list(
      values = list(
        list(
          nodes = create_values(nodes),
          links = create_values(links)
        )
      )
    )
  ),
  categoryField = "nodeName",
  valueField = "value",
  sourceField = "source",
  targetField = "target",
  label = list(
    visible = TRUE,
    style = list(fontSize = 10)
  ),
  node = list(
    state = list(
      hover = list(
        stroke = "#333333"
      ),
      selected = list(
        fill = "#dddddd",
        stroke = "#333333",
        lineWidth = 1,
        brighter = 1,
        fillOpacity = 1
      )
    )
  ),
  link = list(
    state = list(
      hover = list(
        fillOpacity = 1
      ),
      selected = list(
        fill = "#dddddd",
        stroke = "#333333",
        lineWidth = 1,
        brighter = 1,
        fillOpacity = 1
      )
    )
  )
)
