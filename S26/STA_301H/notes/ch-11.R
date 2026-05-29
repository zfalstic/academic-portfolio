library(mosaic)
library(tidyverse)

ggplot(fedex_sim) + 
  geom_histogram(aes(x = weight), binwidth = 0.5)

favstats(~weight, data = fedex_sim)

sim_n60 = do(5000) * mean(~weight, data = sample_n(fedex_sim, 60))

ggplot(sim_n60) + 
  geom_histogram(aes(x = mean), binwidth = 0.1)
