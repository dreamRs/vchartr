
library(vchartr)

# Venn diagram with 2 sets
data.frame(
  sets = c("A", "B", "A,B"),
  value = c(5, 10, 4)
) %>% 
  vchart() %>% 
  v_venn(aes(sets = sets, value = value))

# with more sets 
data.frame(
  sets = c("A", "B", "C", "A,B", "A,C", "B,C", "A,B,C"),
  value = c(8, 10, 12, 4, 4, 4, 2)
) %>% 
  vchart() %>% 
  v_venn(aes(sets = sets, value = value))


# More complex example
set.seed(20190708)
genes <- paste("gene",1:1000,sep="")
genes <- list(
  A = sample(genes,300), 
  B = sample(genes,525), 
  C = sample(genes,440),
  D = sample(genes,350)
)

vchart(stack(genes)) %>% 
  v_venn(aes(category = ind, values = values))

