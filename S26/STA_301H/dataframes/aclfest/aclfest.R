      ### Calculating probabilities from data ###
      ### Lesson 3 / Day 6                    ###
library(tidyverse)
library(mosaic)

# Use the Import Dataset button to import aclfest.csv
glimpse(aclfest)

   #### Calculating probabilities from data ####
### What is the probability that a randomly selected band played Lollapalooza?
# Use the xtabs() function to cross-tabulate the data in terms of the
# lollapalooza variable (1 signifies "true" or "yes" and 0 "false" or "no")
xtabs(~lollapalooza, data=aclfest)

   # Using R as calculator with console results from xtabs():
   # P(lollapalooza) = 438/(800 + 438) = 35%

# RStudio will also help us to turn those counts into proportions,
# using the prop.table() function along with xtabs(). 
# Recall that the pipe operator (%>%) allows us to combine multiple 
# operations in a single pipeline. 
xtabs(~lollapalooza, data=aclfest) %>%
  prop.table()

### What is P(played ACL, played Lollapalooza)?
# Cross tabulate the data by BOTH festivals by using 
# TWO variables in xtabs()):
xtabs(~acl + lollapalooza, data=aclfest)  

# from results in the console:
77/(77 + 719 + 361 + 81)  # = 6%
# How many bands meet both criteria? lolla=1 and acl=1
  # 77 bands of the total 1238 played both festivals  

# Pipe the table of counts into prop.table() for joint probabilities: 
xtabs(~acl + lollapalooza, data=aclfest) %>%
  prop.table() %>% 
  round(2)
                # P(ACL = 1, lollapalooza = 1) is about 6%

# multiply entire xtabs() pipeline by 100 to show table in percentage units
100 * xtabs(~acl + lollapalooza, data=aclfest) %>%
  prop.table() %>% 
  round(2)


   #### Conditional Probabilities ####
# What is P(ACL = 1 | Lollapalooza = 1)?
xtabs(~acl + lollapalooza, data=aclfest)

# Looks like 361 + 77 = 438 bands played Lollapalooza
# Of these, 77 played ACL.
# So P(ACL = 1 | Loll = 1) = 77/438 = 18%

# We can add an optional specification to prop.table() to calculate
# conditional probabilities directly in the table, without generating counts
# in console and then using R as a calculator. 
 
# Here, we condition on the SECOND variable (margin=2), 
# which is lollapalooza. This makes the COLUMNS sum to 1.
100 * xtabs(~acl + lollapalooza, data=aclfest) %>%
  prop.table(margin=2) %>%
      round(2)
  # Conclusion: P(ACL = 1 | Loll = 1) = 18%
  # There is an 18% probability of playing ACL given the band played Lolla

# if we were to change the prop.table() setting to margin=1, we'd see
# a table conditioned on the FIRST variable in xtabs() for which 
# the ROWS sum to 1 
100 * xtabs(~acl + lollapalooza, data=aclfest) %>%
  prop.table(margin=1) %>%
  round(2)
  # We get probabality of Lolla CONDITIONAL on value of ACL


  #### Addition Rule practice with tables ####

### What is P(played bonnaroo or played coachella)? ###
# Addition rule: P(A or B) = P(A) + P(B) - P(A,B)
# So P(bonnaroo or coachella) = P(B) + P(C) - P(B,C)
# First let's get the joint probability P(B,C)
xtabs(~bonnaroo + coachella, data=aclfest) %>%
  prop.table() %>% 
  round(2)

# the addmargins function sums up the rows and columns for us.
# this gives us P(B) and P(C) --- in addition to P(B,C)
xtabs(~bonnaroo + coachella, data=aclfest) %>%
  prop.table() %>%
  addmargins() %>%  # add margins to table
  round(2)

# Addition Rule: P(bonnaroo or coachella) = 
#                = P(B) + P(C) - P(B,C) =
#                = 0.26 + 0.45 - 0.05 = 66%

  #### Optional shortcut for OR probability: use OR operator ####
    ## Warning: confusing! OR Operator for RStudio is "given" symbol 
    ## in probability notation (i.e., vertical bar)
xtabs(~bonnaroo | coachella, data=aclfest) %>%
  prop.table()


  #### OPTIONAL PRO TIP ####  
# set up a single code block to make joint probabilities and conditional
# condition on row, condition on column, and/OR add margin
# Comment/Uncomment (by adding/removing # symbol) for relevant lines of code
xtabs(~bonnaroo + acl, data=aclfest) %>% 
  prop.table() %>%              # joint probabilities
  addmargins() %>%              # add margins to joint probabilities
  # prop.table(margin=1) %>%    # condition on row
  # prop.table(margin=2) %>%    # condition on column
    round(2)


  #### checking INDEPENDENCE with data ####
    ## This entails making the same tables we've been making %>% using the 
    ## results of tables to apply rules for checking independence 

# Example 1: is playing Coachella independent of playing Outside Lands? If so:
# P(coachella=1 | outsidelands=1) = P(coachella=1 | outsidelands=0)

# Let's form a table of probabilities conditional on outside lands
xtabs(~coachella + outsidelands, data=aclfest) %>%
  prop.table(margin=2) %>% 
  round(2)
    # Looks like:
    # P(coachella = 1 | outsidelands = 1) = 14%
    # P(coachella = 1 | outsidelands = 0) = 50%

    # Conclusion: not independent!
    # A band that plays Outside Lands is much less likely to play 
    # Coachella than a band that does not play Outside Lands

# Example 2: is playing ACL independent of playing Outside Lands? If so:
# P(outsidelands=1 | acl=1) = P(outsidelands=1 | acl=0)

# form a table of probabilities conditional on value of acl 
xtabs(~acl + outsidelands, data=aclfest) %>%
  prop.table(margin=1) %>%
  round(2)
    # Looks like:
    # P(outsidelands=1 | ACL=1) = 16%
    # P(outsidelands=1 | ACL=0) = 15%

    # Conclusion: nearly independent!
    # A band that plays ACL has approximately equal probability of 
    # playing or not playing Outside Lands. These numbers are not identical, 
    # but they are close enough that we might plausibly explain the 
    # difference as a small-sample fluctuation. 

# Let's check another rules for independence: the product of marginal 
# probabilities for two independent events equals their joint probability
    # if independent, P(ACL, OL) = P(ACL) * P(OL)

# form a table of joint probabilities with margins
xtabs(~acl + outsidelands, data=aclfest) %>%
  prop.table() %>% 
  addmargins() %>%  
  round(2)

# According to data set: 
# P(ACL, OL) = 2%   
p_ACL = 0.13
p_OL = 0.16 
p_ACL * p_OL  # = 0.0208 ~ nearly identical to joint probability^^

# whether a band plays Outside Lands conveys little to no information 
# about how likely that band is to play ACL. Therefore we consider
# variables ACL and Outside Lands nearly independent of each other

