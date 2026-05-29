library(mosaic)
library(tidyverse)

rflip(25)

patriots_sim = do(10000) * nflip(25)

ggplot(patriots_sim) + 
  geom_histogram(aes(x = nflip), binwidth = 1)

sum(patriots_sim >= 19)

