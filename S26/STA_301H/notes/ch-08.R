library(mosaic)
library(tidyverse)

dessert_simulation = do(10000) * nflip(100, prob = 0.52)

dessert_simulation = dessert_simulation %>%
  mutate(huckleberry_prop = nflip / 100)

ggplot(dessert_simulation) +
  geom_histogram(aes(x = huckleberry_prop), binwidth = 0.01)

dessert_simulation %>%
  summarize(std_err = sd(huckleberry_prop))