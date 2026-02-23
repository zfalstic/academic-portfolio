library(tidyverse)
library(mosaic)

options(scipen = 99)

1 - pbinom(84,130,0.59)

qnorm(.64,520,110)
pnorm(559.4305,508,122)

xtabs(~college + electronics, data=flying) %>%
  prop.table %>%
  addmargins

xtabs(~talkative + gender, data=flying) %>%
  prop.table %>%
  addmargins

ggplot(dragons) + 
  geom_histogram(aes(x=scars))

dragons %>% 
  summarize(
    fav_stats(
      weight
    )
  )

dragons %>% 
  summarize(
    fav_stats(
      scars
    )
  )

schools %>% 
  summarize(
    fav_stats(
      ratio
    )
  )

pnorm(21, 19.64172, 1.89982) - pnorm(18, 19.64172, 1.89982)

ggplot(diwali) + 
  geom_boxplot(aes(x = zone, y = amount))

