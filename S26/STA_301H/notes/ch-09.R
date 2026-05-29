library(mosaic)
library(tidyverse)

ggplot(NHANES_sleep) + 
  geom_histogram(aes(x = SleepHrsNight), binwidth=1)

mean(~SleepHrsNight, data=NHANES_sleep)

boot_sleep = do(10000)*mean(~SleepHrsNight, data=mosaic::resample(NHANES_sleep))

ggplot(boot_sleep) + 
  geom_histogram(aes(x=mean))

confint(boot_sleep, level = 0.95)

NHANES_sleep = NHANES_sleep %>%
  mutate(DepressedAny = ifelse(Depressed != "None", yes = TRUE, no = FALSE))

prop(~DepressedAny, data = NHANES_sleep)

boot_depression = do(10000) * prop(
  ~DepressedAny,
  data = mosaic::resample(NHANES_sleep)
)

ggplot(boot_depression) + 
  geom_histogram(aes(x = prop_TRUE))

confint(boot_depression, level = 0.95)

mean(SleepHrsNight ~ Gender, data=NHANES_sleep)

boot_sleep_gender = do(10000) * diffmean(
  SleepHrsNight ~ Gender, 
  data = mosaic::resample(NHANES_sleep)
)

ggplot(boot_sleep_gender) + 
  geom_histogram(aes(x=diffmean))

confint(boot_sleep_gender, level = 0.95)

prop(Smoke100 ~ DepressedAny, data=NHANES_sleep)

diffprop(Smoke100 ~ DepressedAny, data=NHANES_sleep)

boot_smoke_depression = do(10000) * diffprop(
  Smoke100 ~ DepressedAny, 
  data = mosaic::resample(NHANES_sleep)
)

ggplot(boot_smoke_depression) + 
  geom_histogram(aes(x = diffprop))

confint(boot_smoke_depression, level = 0.95)

ggplot(NHANES_sleep) + 
  geom_jitter(aes(x=Age, y=SleepHrsNight), alpha=0.1)

lm_sleep_age = lm(SleepHrsNight ~ Age, data = NHANES_sleep)
coef(lm_sleep_age)

boot_sleep_age = do(10000) * lm(
  SleepHrsNight ~ Age, 
  data = mosaic::resample(NHANES_sleep)
)

confint(boot_sleep_age, level = 0.95)

ggplot(NHANES_sleep) + 
  geom_jitter(aes(x = Age, y = SleepHrsNight), alpha = 0.1) + 
  geom_smooth(aes(x = Age, y = SleepHrsNight), method = 'lm')