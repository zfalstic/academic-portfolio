   #### Introduction to RStudio ####
# Let's start with exploring the interface...

   #### Scripts (Lesson 1.4) ####
# We ALWAYS prefer to use a SCRIPT instead of typing into the console.
# File > Open to bring in an existing script. 
# File > New to start a new script (then Save As). 

  #### Objects (Lesson 1.3) ####
seven = sqrt(49)
pi = 3.1415926535
# now we can use these objects for computation
pi + seven   
  
# we're only doing arithmetic here, so not immediately clear how useful
# objects can be...we'll see more examples soon

 
  #### Libraries, aka Packages (Lesson 1.6) ####
# we'll routinely use the tidyverse and mosaic packages in STA 301H
install.packages("tidyverse")   # INSTALL libraries only once
library(tidyverse)              # LOAD libraries at start of every session
install.packages("mosaic")
library(mosaic)

   #### Importing data (Lesson 2.4) ####
# The fight_songs.csv file contains a data frame with information on 65 fight 
# songs from schools in Power Five conferences (c. 2019) plus Notre Dame
   
  # 1) Go to the Environment tab in RStudio's top-right panel.
  # 2) Click the Import Dataset button. You'll see a pop-up menu.
  # 3) Choose the first option: From Text (base)....
  # 4) Navigate to where you saved fight_songs.csv downloaded from Canvas
  # 5) Find the file, click Open. Follow the prompts.

   
# it's a good idea to start by visualizing the data frame in the console
glimpse(fight_songs)   # this is a tidyverse function --- if you get an error 
                       # running glimpse(), go back to line 23 

    # note that the glimpse() function TRANSPOSES our row/column data frame
    # structure, improving readability of variable names. But, don't forget
    # that rows of a data frame represent individual CASES (here, songs) 
    # and columns represent VARIABLES (here, characteristics of songs)

# head() is another function to view data frame contents in console, 
# but not as effectively for a long data frame with many columns:
head(fight_songs)     

  #### Fight Songs analysis ####
    # - import a data set
    # - decide what questions you want to ask of the data
    # - write a script that answers those questions 
    # - use the "pipe" operator %>% to link together functions and objects
    # - "Run" the script to see the results in the console/plot window.

# QUESTION 1: What is the typical duration for college fight songs? 
# The duration variable gives song length in seconds. 
# Let's calculate some summary statistics (more next class). 
# Enter code, then click Run button at top right of script
fight_songs %>% 
    summarize(avg = mean(duration),
              med = median(duration)) 

                ### RStudio's Number 1 Keyboard Shortcut              ###
                ###                                                   ###
                ### click together    CTRL + ENTER (Windows)          ###
                ###             or    Command + ENTER (Mac)           ###
                ###                                                   ###
                ###  instead of using Run button at top of script     ###
                ###                                                   ###
                ### more keyboard shortcuts? Click: Alt + Shift + K   ###

# Visualize the distribution of song lengths with a histogram:
fight_songs %>% 
  ggplot(aes(x=duration)) +
  geom_histogram(fill = '#bf5700', 
                 color = 'white') +
  labs(title='Duration of 65 college fight songs',
         x = "song length in seconds",
         y = "") +
  scale_x_continuous(breaks = seq(20, 175, 15)) +   
  theme_classic()              # get excited for plots on Day 4! 


# QUESTION 2: What proportion of songs actually contain the word "fight"? 
# Let's make a contingency table (more on Day 6) using the 'fight' variable:
100 * xtabs(~fight, data=fight_songs) %>% 
  prop.table() %>% 
  round(2)                    
                     # 68% of songs in this sample contain the word "fight"

# QUESTION 3: Which school's fight song uses the word "fight" most frequently? 
# Let's use data wrangling! (Day 8) and the variable called 'number_fights'
fight_songs %>% 
  select(school, number_fights) %>% 
  arrange(desc(number_fights))  %>% 
  head(10)
