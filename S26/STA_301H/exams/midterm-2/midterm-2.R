library(tidyverse)
library(mosaic)
library(moderndive)

options(scipen = 77)

xtabs(~advanced + argentina, data = FIFA) %>% 
  prop.table(margin = 2) %>% 
  round(2)

t.test(height ~ human, data = starwars)

TS %>% 
  summarize(mean(energy))

TS %>% 
  filter(energy < 0.5744921) %>% 
  group_by(key) %>% 
  count() %>% 
  arrange(n)

prop.test(Indifferent ~ Eating, data = squirrels, success = "indifferent")
prop(Indifferent ~ Eating, data = squirrels, success = "indifferent")

office %>% 
  filter(season == 4, votes == 4000) %>% 
  count()

office %>% 
  filter(season == 4, rating == 9.3) %>% 
  count()

ggplot(buildings) +
  geom_histogram(aes(x = market_rent))

rent_model = lm(rent ~ stories + green + amenities + green:amenities, data = buildings)
get_regression_table(rent_model)

revenue_model = lm(revenue ~ green + renovated + green:renovated, data = buildings)
get_regression_table(revenue_model)

medal_sim = do(100000)*nflip(196, 0.1111975)
ggplot(medal_sim) + 
  geom_histogram(aes(x = nflip), binwidth = 1)

sum(medal_sim >= 30)

diwali %>% 
  group_by(category, zone) %>% 
  summarize(m = mean(amount)) %>% 
  arrange(m)

diwali %>% 
  group_by(occupation) %>% 
  count()

boot_height = do(5000) * median(~height, data = mosaic::resample(starwars))
confint(boot_height, level = 0.95)
