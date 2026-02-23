## Libraries
library(mosaic)
library(tidyverse)

## Scientific Notation Fix
options(scipen=99)

## risk.csv
ggplot(risk) + 
  geom_histogram(aes(x=income,y=..density..), binwidth=10000) + 
  facet_wrap(~cheated) +
  labs(title="Income Density Distribution based on Cheating",
       x="Income (USD)",
       y="Density")

risk %>% 
  group_by(cheated) %>% 
  summarize(median(income))

ggplot(risk) + 
  geom_histogram(aes(x=age,y=..density..), binwidth=5) +
  facet_wrap(~skydiving) +
  labs(title="Age Density Distribution based on Skydiving",
       x="Age (years)",
       y="Density")

xtabs(~skydiving, data=risk) %>% 
  prop.table %>% 
  round(3)

xtabs(~gamble + education, data=risk) %>% 
  prop.table %>% 
  addmargins() %>% 
  round(2)

ggplot(risk, aes(y=education, fill=gamble)) + 
  geom_bar(position="fill") +
  labs(title="Distribution of Gambling based on Education",
       x="Proportion of Gambling",
       y="Education")

## candies.csv
ggplot(candies) +
  geom_point(aes(x=Price, y=Win)) +
  labs(title="Price Percentile vs Win Percentage",
       x="Price Percentile",
       y="Win Percentage")

xtabs(~Nougat + Caramel, data=candies) %>% 
  prop.table %>% 
  addmargins() %>% 
  round(4)

ggplot(candies, aes(x=Fruit)) +
  geom_bar() +
  facet_wrap(~Chocolate) +
  labs(title="Distribution of Chocolate under Fruity Conditions",
       x="Fruitiness",
       y="Count")

## superbowl.csv
superbowl %>% 
  summarize(mean_likes=mean(likes),
            sd_likes=sd(likes),
            mean_dislikes=mean(dislikes),
            sd_dislikes=sd(dislikes))

ggplot(superbowl, aes(y=brand, fill=animals)) +
  geom_bar() +
  labs(title="Advertisements per Brand by Animal Appearance",
       x="Count",
       y="Brand")

ggplot(superbowl, aes(x=funny)) +
  geom_bar() +
  labs(title="Advertisements for Funny vs NOT Funny",
       x="Funny",
       y="Count")

xtabs(~funny, data=superbowl) %>% 
  prop.table %>% 
  round(2)

superbowl %>%
  group_by(brand) %>%
  summarize(avg_views = mean(views)) %>%
  arrange(desc(avg_views)) %>%
  head(4)

brands = superbowl %>%
  filter(brand=='Budweiser' | brand=='Coca-Cola' | brand=='Doritos' | brand=='NFL') %>%
  group_by(year, brand) %>%
  summarize(median = median(likes))

ggplot(brands) +
  geom_line(aes(x=year, y=median)) +
  facet_wrap(~brand) +
  labs(title="Median Views From 2000-2020 By Brand",
       x="Year",
       y="Median Views")

## minecraft_foods.csv
ggplot(minecraft_foods, aes(x=type, y=hunger)) +
  geom_boxplot() +
  labs(title="Distribution of Hunger Regneration by Food Type",
       x="Food Type",
       y="Hunger Restored")
