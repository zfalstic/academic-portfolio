library(tidyverse)
library(mosaic)

options(scipen = 99)

1 - pbinom(0, 4, 0.4)

ggplot(squirrels) + 
  geom_histogram(aes(x=Latitude))

xtabs(~Age + Location, data=squirrels) %>%
  prop.table %>%
  addmargins

dbinom(4, 10, 0.7) + dbinom(5, 10, 0.7)



pnorm(3, 0.9, 4.4, lower.tail = FALSE)
