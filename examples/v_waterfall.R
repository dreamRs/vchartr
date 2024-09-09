
library(vchartr)

balance <- data.frame(
  desc = c("Starting Cash",
           "Sales", "Refunds", "Payouts", "Court Losses",
           "Court Wins", "Contracts", "End Cash"),
  amount = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800)
)

vchart(balance) %>% 
  v_waterfall(aes(x = desc, y = amount))


# With total values and formatting
data.frame(
  x = c("Feb.4", "Feb.11", "Feb.20", "Feb.25", "Mar.4", 
        "Mar.11", "Mar.19", "Mar.26", "Apr.1", "Apr.8",
        "Apr.15", "Apr.22", "Apr.29", "May.6", "total"),
  total = c(TRUE, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, TRUE),
  y = c(45L, -5L, 2L, -2L, 2L, 2L, -2L, 1L, 1L, 1L, 2L, 1L, -2L, -1L, NA)
) %>% 
  vchart() %>% 
  v_waterfall(
    aes(x = x, y = y, total = total),
    stackLabel = list(
      valueType = "absolute",
      formatMethod = JS("text => text + '%'")
    )
  ) %>% 
  v_specs_legend(visible = TRUE)
