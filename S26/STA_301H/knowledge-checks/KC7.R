library(tidyverse)
library(mosaic)

pnorm(11,8.6,2.5) - pnorm(7,8.6,2.5)
qnorm(0.25,70,10)
qnorm(0.93,500,100)
pnorm(60,70,10)
dragons %>% 
  summarize(
    fav_stats(height)
  )
1 - pnorm(60,50.0505,7.045)
pnorm(56,60,15) * pbinom(2,39,0.08)
