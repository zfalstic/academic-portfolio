library(tidyverse)
library(mosaic)

ggplot(hogwarts) + 
  geom_boxplot(aes(x = on_time, y = department))

hogwarts %>% 
  group_by(department) %>% 
  summarize(mean = mean(wage)) %>% 
  arrange(mean)

hogwarts %>% 
  mutate(total_wages = hours * wage) %>% 
  group_by(house) %>% 
  summarize(
    iqr = IQR(total_wages)
  )
