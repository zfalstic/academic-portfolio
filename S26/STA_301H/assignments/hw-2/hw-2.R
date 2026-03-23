library(tidyverse)
library(mosaic)

options(scipen=99)

# 1 Wrangling the Tate Collection

tate_modern %>% 
  group_by(artist) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>% 
  head(10)

tate_modern %>% 
  filter(gender == "Female") %>% 
  group_by(acquisition_year) %>% 
  count(acquisition_year) %>% 
  ggplot() +
    geom_line(aes(x=acquisition_year, y=n)) +
    labs(
      title="Count of artworks by female artists over time",
      x="Acquisition Year",
      y="Count"
    )

tate_modern_1950 = tate_modern %>% 
  mutate(post1950 = ifelse(creation_year > 1950, yes = 1, no = 0))

tate_modern_1950 %>% 
  filter(width < 400) %>% 
  ggplot() +
    geom_histogram(aes(x=width)) +
    facet_wrap(~post1950) +
    labs(
      title="Distribution of Width by Before 1950 (0) and After 1950 (1)",
      x="Width",
      y="Count"
    )

tate_modern %>% 
  group_by(medium) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>% 
  head(5)

tate_modern %>% 
  group_by(medium) %>% 
  summarize(median_height = median(height)) %>% 
  arrange(desc(median_height)) %>% 
  head(5)

tate_modern %>% 
  group_by(medium) %>% 
  summarize(sd_height = sd(height)) %>% 
  arrange(desc(sd_height)) %>% 
  head(5)

# 2 The Bechdel Test

movies %>% 
  ggplot() +
    geom_histogram(aes(x=votes)) +
    facet_wrap(~test, nrow=2) +
    labs(
      title="Distribution of Votes by Bechdel Test Result",
      x="Votes",
      y="Count"
    )

movies %>% 
  group_by(test) %>% 
  summarize(votes_mean = mean(votes))

meandiffboot_movies = do(5000) * diffmean(votes ~ test, data=mosaic::resample(movies))
confint(meandiffboot_movies, level = 0.95) %>%
  mutate(lower = round(lower, -3),
         upper = round(upper, -3))

movies %>% 
  summarize(q75_imdb = quantile(imdb, 0.75))

movies %>% 
  filter(imdb >= 7.4) %>% 
  arrange(desc(international)) %>% 
  select(title, director, year) %>% 
  head(10)

movies %>% 
  summarize(avg_budget = mean(budget))

movies %>% 
  filter(budget < 57.38022) %>% 
  arrange(desc(domestic)) %>% 
  select(title, director, year) %>% 
  head(10)

# 3 The Graphics of Grammar

grammar = grammar %>%
  mutate(care_comma = factor(care_comma,
                             levels = c("Not at all", "Not much", "Some", "A lot")))

grammar %>% 
  ggplot() +
    geom_bar(aes(y=care_comma, fill=prefer_comma), position="fill") +
    labs(
      title = "Oxford Comma Preference by How Much Respondents Care About the Comma",
      x = "Proportion",
      y = "How Much Do You Care About the Comma?"
    )

grammar = grammar %>%
  mutate(region = fct_infreq(region))

grammar %>% 
  ggplot() +
    geom_bar(aes(y=region, fill=important)) +
    labs(
      title = "Importance of Grammar by U.S. Region",
      x = "Number of Respondents",
      y = "Region"
    )

propdiffboot_grammar = do(5000) * diffprop(data_noun ~ prefer_comma, success="Plural", data=mosaic::resample(grammar))
confint(propdiffboot_grammar, level = 0.95)

ggplot(propdiffboot_grammar) +
  geom_histogram(aes(x=diffprop))

grammar %>% 
  ggplot() +
    geom_bar(aes(x=data_noun)) +
    facet_wrap(~prefer_comma) +
    labs(
      title = "Noun Usage (Singular vs Plural) by Oxford Comma Preference",
      x = "Noun Type",
      y = "Count"
    )

# 4

ERCOT %>% 
  ggplot() +
    geom_point(aes(x=temperature, y=power)) +
    geom_smooth(aes(x=temperature, y=power), method='lm') +
    labs(
      title = "ERCOT Power Consumption Increases versus Temperature",
      x = "Temperature (°F)",
      y = "Power (MW)"
    )

slopeboot_ERCOT = do(5000)*lm(power ~ temperature, data=mosaic::resample(ERCOT))
confint(slopeboot_ERCOT, level=0.95)
