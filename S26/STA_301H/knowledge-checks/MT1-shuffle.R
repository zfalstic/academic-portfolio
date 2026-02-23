library(tidyverse)
library(mosaic)

xtabs(~color + spikes, data=dragons) %>%
  prop.table %>%
  addmargins

greenbuildings %>% 
  summarize(
    median(Rent))

dbinom(4, 15, 0.7) +
  dbinom(8, 15, 0.7) +
  dbinom(12, 15, 0.7) 

dragons_over60 = dragons %>% 
  filter(height > 60)

dragons %>% 
  summarize(fav_stats(height))

1 - pnorm(60, mean = 50.0505, sd = 7.045044)
