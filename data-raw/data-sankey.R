

# Energy data -------------------------------------------------------------

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





as.data.frame(Titanic) %>%
  aggregate(data = ., Freq ~ Class + Survived, FUN = sum)



