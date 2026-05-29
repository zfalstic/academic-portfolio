library(tidyverse)
library(mosaic)
library(moderndive)

# 1 Dicker the kicker

sim_kick = do(100000) * nflip(n = 83, prob = 0.84)

ggplot(sim_kick) + 
  geom_histogram(aes(x = nflip), binwidth = 1, fill='#0080C6', color='#FFC20E') + 
  labs(
    title = 'Simulated Field Goals Made in 83 Attempts Under Null Hypothesis: p = 0.84',
    x = 'Number of Field Goals Made',
    y = 'Count'
  )

sum(sim_kick >= 77)
sum(sim_kick >= 77) / 100000

confint(sim_kick, level = 0.95)

# 2 Animal shelter wrangling

shelter %>% 
  group_by(month) %>% 
  filter(animal_type == 'WILDLIFE') %>% 
  count() %>% 
  arrange(n)

shelter %>% 
  group_by(animal_type, animal_origin) %>% 
  count() %>% 
  arrange(desc(n))

breeds = shelter %>%
  group_by(animal_breed) %>%
  summarize(animals = n(),
            adoption_rate = sum(outcome_type == 'ADOPTION') / animals)

breeds %>% 
  filter(animals >= 25) %>% 
  arrange(desc(adoption_rate))

shelter = shelter %>% 
  mutate(dog = ifelse(animal_type == 'DOG', 'dog', 'not_dog'),
         cat = ifelse(animal_type == 'CAT', 'cat', 'not_cat'),
         stray = ifelse(intake_type == 'STRAY', 'stray', 'other_intake'),
         surrendered = ifelse(intake_type == 'OWNER SURRENDER', 'surrendered', 'other_intake'))

shelter %>% 
  count()

shelter %>% 
  filter(dog == 'not_dog') %>% 
  count()

not_dog_proportion = 8776 / 34819

shelter %>% 
  filter(cat == 'cat' | dog == 'dog') %>% 
  count()

cat_or_dog_proportion = 33761 / 34819

xtabs(~dog + stray, data = shelter) %>% 
  prop.table(margin = 2) %>% 
  round(3)

xtabs(~cat, data = shelter) %>% 
  prop.table() %>% 
  round(3)

xtabs(~cat + surrendered, data = shelter) %>% 
  prop.table(margin = 2) %>% 
  round(3)

ggplot(shelter, aes(x = surrendered, fill = cat)) + 
  geom_bar(position = 'fill') +
  labs(
    title = 'Proportion of Cats vs. Other Animals by Intake Type',
    x = 'Intake Type',
    y = 'Proportion'
  )

# 3 Scooby Doo

ggplot(scooby) + 
  geom_histogram(aes(x = rating, fill = scrappy), binwidth = 0.1) +
  scale_fill_manual(
    values = c('#79af30', '#8e6345')
  ) +
  labs(
    title = 'Distribution of IMDb Ratings by Scrappy Status',
    x = 'IMDB Rating',
    y = 'Count'
  )

t.test(rating ~ scrappy, data = scooby)

lm_scooby = lm(rating ~ scrappy, data = scooby)
get_regression_table(lm_scooby, conf.level = 0.95, digits = 3)

# 4 Circuit board skips

lm_ATT = lm(skips ~ solder + size + solder:size, data = ATT)
get_regression_table(lm_ATT, conf.level = 0.95, digits=3)

ggplot(lm_ATT) +
  geom_histogram(aes(x = skips)) +
  facet_grid(size ~ solder) +
  labs(
    title = 'Distribution of Solder Skips by Solder Thickness and Opening Size',
    x = 'Number of Skips',
    y = 'Count'
  )
