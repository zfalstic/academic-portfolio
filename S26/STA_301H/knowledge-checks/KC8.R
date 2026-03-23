library(mosaic)
library(tidyverse)

scooby %>% 
  summarize(avg_rating = mean(rating),
            avg_engagement = mean(engagement))

scooby_settings = scooby %>% 
  filter(rating > 7.375142 & motive == "Smuggling") %>% 
  group_by(setting) %>% 
  select(setting)

ggplot(scooby_settings, aes(x = setting)) +
  geom_bar()

scooby_motives = scooby %>% 
  filter(engagement > 86.85199 & setting == "Jungle") %>% 
  group_by(motive) %>% 
  select(motive)

ggplot(scooby_motives, aes(x = motive)) +
  geom_bar()

ads %>% 
  group_by(brand) %>% 
  summarize(median_likes = median(likes)) %>% 
  arrange(desc(median_likes))

ads %>% 
  group_by(brand) %>% 
  summarize(mean_likes = mean(likes)) %>% 
  arrange(desc(mean_likes))

ads %>% 
  filter(danger == "TRUE") %>% 
  summarize(sd_likes = sd(likes))

disney_films %>% 
  group_by(genre) %>% 
  summarize(median_adjust = median(adjusted_gross)) %>% 
  arrange(desc(median_adjust))

disney_films %>% 
  group_by(genre) %>% 
  summarize(mean_total = mean(total_gross)) %>% 
  arrange(desc(mean_total))

scooby %>% 
  summarize(avg_engage = mean(engagement))

scooby %>% 
  filter(engagement > 86.85199 & motive == "Treasure") %>% 
  group_by(setting) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

scooby %>% 
  summarize(median_rating = median(rating))

scooby %>% 
  filter(rating > 7.4 & setting == "Island") %>% 
  group_by(motive) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

ads %>% 
  group_by(year) %>% 
  summarize(median_views = median(views)) %>% 
  arrange(desc(median_views))

ads %>% 
  group_by(brand) %>% 
  summarize(mean_likes = mean(likes)) %>% 
  arrange(desc(mean_likes))

ads %>% 
  filter(celebrity == "TRUE") %>% 
  summarize(sd_likes = sd(likes))

disney_films %>% 
  group_by(genre) %>% 
  summarize(median_total = median(total_gross)) %>% 
  arrange(desc(median_total))

disney_films %>% 
  group_by(genre) %>% 
  summarize(median_adjusted = median(adjusted_gross)) %>% 
  arrange(desc(median_adjusted))
