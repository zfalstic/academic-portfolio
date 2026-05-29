library(tidyverse)
library(mosaic)
library(moderndive)

options(scipen=99)

kickoff_sim = do(100000)*nflip(272, 0.043)

sum(kickoff_sim <= 6)
5009/100000

xtabs(~prefer_comma + data_noun, data = grammar) %>% 
  prop.table(margin = 1) %>% 
  round(2)

xtabs(~data_noun + prefer_comma, data = grammar) %>% 
  prop.table(margin = 2) %>% 
  round(3)

xtabs(~data_noun + prefer_comma, data = grammar) %>% 
  round(3) %>% 
  addmargins

xtabs(~region + prefer_comma, data = grammar) %>% 
  round(3) %>% 
  addmargins

t.test(age ~ important, data = grammar)

ggplot(ski) +
  geom_histogram(aes(x = highest))


capacity_model = lm(capacity ~ price, data = ski)
coef(capacity_model) %>% 
  round(3)

get_regression_table(capacity_model)

price_model = lm(price ~ highest, data = ski)
get_regression_table(price_model)
get_regression_summaries(price_model)

ski_boot = do(5000) * lm(price ~ highest, 
                         data= resample(ski)) 
confint(ski_boot)

cinema %>% 
  group_by(genre) %>% 
  summarize(m = median(metascore)) %>% 
  arrange(desc(m)) %>% 
  head(5)

cinema %>% 
  summarize(mean(votes))

cinema %>% 
  filter(votes < 120012) %>% 
  group_by(director) %>% 
  count() %>% 
  arrange(desc(n))

duration_model = lm(duration ~ bpm + conference, data = fight_songs)
get_regression_table(duration_model)
get_regression_summaries(duration_model)

prop(colors ~ spelling, data = fight_songs, success = "No")
prop.test(colors ~ spelling, data = fight_songs, success = "Yes")

fight_songs %>% 
  group_by(conference) %>% 
  summarize(IQR(bpm), median(bpm), quantile(bpm, 0.25))

salary_model = lm(salary ~ experience + city + south + city:south, data = workforce)
get_regression_table(salary_model)
