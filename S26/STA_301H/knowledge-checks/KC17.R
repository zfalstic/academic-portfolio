library(tidyverse)
library(mosaic)

cars_model = lm(city ~ powertrain + category, data=cars)

coef(cars_model) %>% 
  round(1)

cars_model2 = lm(city ~ category, data=cars)

coef(cars_model2) %>% 
  round(1)

cars_EV = cars %>% 
  filter(powertrain == "EV")
