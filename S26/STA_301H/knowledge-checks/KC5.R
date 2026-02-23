library(tidyverse)
library(mosaic)

xtabs(~spikes + color, data=dragons) %>% 
  prop.table() %>% 
  addmargins()
