library(vchartr)
library(ggplot2)

# Use vars() to supply faceting variables:
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(class))

# Control the number of rows and columns with nrow and ncol
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(class), ncol = 3)

# You can facet by multiple variables
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(cyl, drv))

# Use the `labeller` option to control how labels are printed:
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(cyl, drv), labeller = label_both)

# To change the order in which the panels appear, change the levels
# of the underlying factor.
mpg$class2 <- reorder(mpg$class, mpg$displ)
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(class2), ncol = 3)

# By default, the same scales are used for all panels. You can allow
# scales to vary across the panels with the `scales` argument.
vchart(mpg) %>% 
  v_scatter(aes(displ, hwy)) %>% 
  v_facet_wrap(vars(class), scales = "free")
