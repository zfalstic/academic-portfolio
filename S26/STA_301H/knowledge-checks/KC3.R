library(tidyverse)
library(mosaic)

xtabs(~bonnaroo + outsidelands, data=aclfest) %>% 
  prop.table %>% 
  addmargins %>% 
  round(3)
