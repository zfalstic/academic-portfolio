library(mosaic)
library(tidyverse)
library(moderndive)

height_model = lm(height ~ weight + color, data = dragons)
get_regression_table(height_model)
get_regression_summaries(height_model)

grocery = grocery %>% 
  mutate(income10k = income / 10000)
price_model = lm(price ~ income10k + product, data = grocery)
get_regression_table(price_model)
