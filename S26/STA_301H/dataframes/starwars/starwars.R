      ### Star Wars summaries ###
      ### Day 3 / Lesson 5    ###
library(tidyverse)  # Need refresher on libraries? Lesson 1.6
library(mosaic)     
      
# Import Dataset >> starwars.csv
glimpse(starwars)    # get an error? be sure to load the tidyverse (line 3)

      ### summary statistics with summarize() ###
#### MEASURES of CENTER (the 'typical' value) -- Lesson 5.1 ####
starwars %>% 
   summarize(mean(height)) %>% 
   round(0)               # round to the nearest centimeter
 
## multiple summaries
starwars %>% 
   summarise(avg = mean(height),   # mean
             md = median(height))  # median
   
   #### MEASURES of VARIATION -- Lesson 5.2 ####
starwars %>% 
   summarize(SD_height = sd(height),     # standard deviation
             iqr_height = IQR(height))   # interquartile range

 #### MULTIPLE SUMMARY STATISTICS with summarize() ####
starwars %>% 
   summarize(mean = mean(height),                # mean
             std_dev = sd(height),               # standard deviation
             median = median(height),            # median 
             q1 = quantile(height, 0.25),        # 1st quartile, 25th percentile
             q3 = quantile(height, 0.75),        # 3rd quartile, 75th percentile
             IQR = q3-q1,                        # interquartile range
             range = max(height)-min(height),    # max-min
             pct10 = quantile(height, 0.1),      # 10th percentile
             pct90 = quantile(height, 0.9)) %>%  # 90th percentile
   round(0)


      #### Summary Shorcuts -- Lesson 6.3 ####
# load mosaic library (see Line 5) for shortcut functions
mean(~height, data=starwars)
sd(~height, data=starwars)
median(~height, data=starwars)
IQR(~height, data=starwars)
max(~height, data=starwars)
min(~height, data=starwars)
quantile(~height, data=starwars, prob = c(0.25, 0.75))

# SUPER USEFUL mosaic function: favstats() for collection of summaries
favstats(~height, data=starwars)
favstats(height ~ human, data=starwars)  # numerical summaries by group

      #### OUTLIERS ####
# describe the distribution of the mass variable
favstats(~mass, data=starwars) %>% 
   round(0)              

# visualize the distribution of the mass variable
ggplot(starwars) +         
   geom_histogram(aes(x=mass))   # see anything unusual out on Tatooine?

# visualize mass distribution without the large outlier
starwars %>%  
   filter(mass < 1000) %>%     # data wrangling function (Day 8)
ggplot(aes(x=mass)) +        
   geom_histogram(fill='#ad7d37', 
                  color='black', 
                  binwidth = 10) +
   labs(title = "Weighing in on the Star Wars canon",
        y = 'number of characters',
        x="mass in kilograms") +
   scale_x_continuous(breaks = seq(0,180,20)) + 
      theme_light() +
   theme(axis.text = element_text(size = 12), 
         axis.title = element_text(size = 14),
         plot.title = element_text(size = 20))

# the distribution certainly looks different without the outlier! 
# Depending on our objectives for analysis we MIGHT want to 
# remove the extreme value before calculations. We could still report
# the existence of the outlier. 

      #### Z-SCORES -- Lesson 5.4 ####
# to implement the z-score formula we need summary statistics
# create objects (Lesson 1.3) for mean/sd using mosaic shortcut functions 
avg = mean(~mass, data=starwars)  # 98.16 kg
stdev = sd(~mass, data=starwars)   # 170.81 kg

# Jabba the Hut weighs 1358 kilograms. What is the corresponding z-score?   
jabba = 1358

# z-score formula   z = (X-mean)/SD
(jabba - avg)/stdev
      # Jabba the Hutt's weight is 7.4 standard deviations above the mean!

# another approach: use summarize() then hard-code z-score formula
starwars %>% summarize(mean(mass),
                       sd(mass),
                       max(mass))
(1358-98)/171   # using R as a calculator (Lesson 1.2)                                    

# soon we will learn an additional approach (using data wrangling) to 
# calculate an entire column of z-scores (i.e., for each case)