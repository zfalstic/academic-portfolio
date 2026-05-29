#import "@preview/noteworthy:0.3.0": *
#import "@preview/unify:0.7.1": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "STA 301H Notes",
  header-title: "STA 301H",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#show link: underline

// Reset the figure counter at each top-level heading
#show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

// Number figures as <section>.<figure>
#set figure(numbering: n => {
  let h = counter(heading).get()
  numbering("1.1", h.first(), n)
})

#pagebreak()
= Statistical Uncertainty

A huge part of statistical inference involves quantifying
uncertainty about our model of the data. Instead of saying
"I think the answer is 10," you say something like, "I think
the answer is 10, plus or minus 3."

Here is an unexhaustive list of 5 such ways uncertainty may
occur:

+ *Our data consists of a sample*, and we want to generalize 
  from facts about the sample to facts about the wider 
  population from which the sample was drawn. This process of
  generalizing from sample #sym.arrow.r population is
  inherently uncertain, because we haven't sampled everyone.
+ *Our data come from a randomized experiment.* Because the
  experiment itself is random, how can we be sure that the
  results were not just an anomaly due to chance?
+ *We want to use data to make a prediction about the future,
  and we expect the future to be similar to the past.* This
  also comes with uncertainty because the truth is we can't
  predict future events.
+ *Our measurements are subject to measurement or reporting
  error.* Consider this, whenever we measure the length of 
  something, we will measure to maybe #qty(0.1, "cm"), but
  how do we know that a more precise measurement #qty(0.001, "cm")
  would have resulted in the model that we were actually after?
  We don't. We have to model that error.
+ *Our data arise from an intrinsically random or variable
  process.* Consider modeling a heartbeat by counting the number
  of pulses for 15 seconds. Each time this trial is repeated,
  you will likely get a different number.

Like it or not, uncertainty is a fact of life. Statistical 
inference means saying something intelligent about _how uncertain_
our conclusions actually are, in light of the data.

== Sampling Distributions

There exists a difference between real-world uncertainty
and statistical uncertainty. In statistics, "certainty" is
roughly equivalent to the term "repeatability."

Suppose, for example, that we take a random sample of 100
Americans, and asked them whether they would prefer
huckleberry pie or tiramisu:

- Huckleberry pie: 52%
- Tiramisu: 48%

This sample says that more people tend to like Huckleberry pie,
but what if we want to generalize the results to a broader
population? Then, we would need a margin of error.

Here are two definitions that will help us talk about these
ideas precisely:

#definition[
  In data science, an *estimand* is any fact about the world,
  or any fact about some idealized model of the world, that
  we're trying to learn about using data.
]

In our dessert example, this happens to be the latter, the
true nationwide proportion of folks that prefer huckleberry
pie to tiramisu.

#definition[
  An *estimator* is any statistical summary (sample mean,
  sample proportion, etc.) designed to estimate the estimand.
]

Here, our estimator is the proportion based on a survey of
size $n = 100$.

Clearly our sample provides _some_ information about the
population, but it's not perfect. Even after the data,
we're still uncertain. But just how uncertain are we? From
a statistical perspective, the answer to this question
involves repeatability. _You're certain if your results are
repeatable._ So to measure repeatability, and therefore 
certainty, you take a different sample of 100 people,
ask the same question again, and see how much your estimator
changes. And then you do it again, and again, and again! If
you get something close to 52% every time, then you're pretty
sure the value of the estimand is about 52%.

In short, we're "certain" if when we ask the same question
over and over again, we get the same answer each time. If
our answer fluctuates each time, we're uncertain and the
_amount_ by which those answers fluctuate provides a
quantitative measure of uncertainty.

Let's see this process in action through a computer simulation.

#definition[
  A *Monte Carlo simulation* is the process of repeatedly
  simulating the random process that generated our data through
  a computer.
]

#example[
  Suppose that it were actually true that, if offered a choice,
  52% of Americans would prefer huckleberry pie and 48%
  tiramisu. If we asked 100 randomly chosen people about their 
  preference, we'd hope that _on average,_ it would yield the
  right result: that 52% of people prefer huckleberry pie.
  But any individual result could easily deviate from the 
  right answer, just by chance. The question is: by how much?

  Let's find out by treating heads as huckleberry pie and tails
  as tiramisu.

  ```R
  rflip(100, prob = 0.2)
  ```

  ```R
  ## 
  ## Flipping 100 coins [ Prob(Heads) = 0.52 ] ...
  ## 
  ## H H H T T H H H H H H H H T H H H H H T H H T H T T H T T H H H H H H H
  ## T H T H H H H T T H T H T T T H H H H H H T H T T T T T T T H H H H H H
  ## T T H T T H T H T T T H T T H T T T T T T H T H H H H T
  ## 
  ## Number of Heads: 57 [Proportion Heads: 0.57]
  ```

  Here, it looks like 57% of respondents said they preferred
  huckleberry pie. The true population-wide proportion was
  assumed to be 52% so in this scenario, the estimand (52%)
  and estimator (57%) differ by about 5%.
  
  Did we just get unlucky or is 5% a typical error? Let's
  repeat the experiment 10,000 times and plot the results.

  ```R
  dessert_simulation = do(10000) * nflip(100, prob = 0.52)

  dessert_simulation = dessert_simulation %>%
    mutate(huckleberry_prop = nflip / 100)

  ggplot(dessert_simulation) +
    geom_histogram(aes(x = huckleberry_prop), binwidth = 0.01)
  ```

  #figure(
    image("figures/sampling-distribution-01.png", width: 60%),
    caption: [
      Sampling distribution of the proportion of huckleberry 
      pie
    ],
  ) <huckleberry-dist>

  #definition[
    The *sampling distribution* of a statistical summary is the
    distribution of values we expect to see for that summary
    under repeated sampling from a random process that generated
    our data.
  ]

  There are two important questions to ask about a sampling,
  one about its center and one about its spread. First, let's 
  look at where the distribution is centered.

  #definition[
    The *expected value* of a statistical summary is the average
    of that summary's sampling distribution.
  ]

  Now looking at the variance of our sampling distribution we 
  arrive at our second description.

  #definition[
    The *standard error* is the standard deviation of a 
    sampling distribution. This describes the typical 
    statistical fluctuation of our summary statistic.
  ]

  #note[
    The best way I've found to remember expected value and
    standard error is to remember their respective parallels
    with mean and standard deviation.
  ]

  We can easily calculate the standard deviation  of our
  sampling distribution in @huckleberry-dist like how
  we've learned previously.

  ```R
  dessert_simulation %>%
    summarize(std_err = sd(huckleberry_prop))
  ```

  ```R
  ##      std_err
  ## 1 0.04974177
  ```

  This number tells us that we can expect any particular sample
  to be about 5% of our expected value. For a more conservative
  estimate, we could go out two standard errors to either side
  of our estimate.
]

In the prior example, our statistical summary was the proportion
of those surveyed, out of 100, that preferred huckleberry pie.
Let's now see a more complex model.

#example[
  Imagine that you go on a four-day fishing trip to a lake home
  to 800 fish of varying size and weight, depicted below in 
  @fish-dist. Each day you catch and release 15 fish, recording
  each weight and volume. You then use the day's catch to compute
  the volume-weight relationship for the entire population of
  fish in the lake.
]

#figure(
  image("figures/sampling-distribution-02.png", width: 70%),
  caption: [
    An imaginary lake with 800 fish with the results of 4 
    days of fishing
  ],
) <fish-dist>

The two things we are trying to estimate are the slope ($beta_1$)
and intercept ($beta_0$) of the dotted line in the figure.
Because Dr. Scott has already simulated the entire population in
R for us, estimand is:

$ E(y | x) = 49 + 4.24 dot x $

This equation is the true population regression line for all 800
fish in the lake. To distinguish between each individual sample
of size 15, statisticians designate the $hat$ hat symbol. In
our scenario: these are the estimates $hat(beta_0)$ and 
$hat(beta_1)$.

Four days give us some idea of how $hat(beta_0)$ and 
$hat(beta_1)$ vary from sample to sample. But 2,500 days will
give us an even better picture. Again, we will use a Monte Carlo
simulation to achieve this. @fish2-dist shows our simulated
2,500 days of fishing:

#figure(
  image("figures/sampling-distribution-04.png", width: 70%),
  caption: [
    Simulated results of 2,500 days of fishing.
  ],
) <fish2-dist>

@fish3-dist shows the sampling distribution of the regression
line. Again, because the regression is described by two
variables $beta_0$ and $beta_1$, we have two distributions one
for each variable.

#figure(
  image("figures/sampling-distribution-03.png", width: 70%),
  caption: [
    The sampling distributions of the intercept (left) and slope
    (right) from 2,500 simulated fishing trips
  ],
) <fish3-dist>

Let's ask our two big questions about sampling distributions:

+ Where are they centered? They seem to be roughly centered on
  the true values of $beta_0 = 49$ and $beta_1 = 4.24$.
+ How spread out are they? The standard error of $hat(beta_0)$
  is about 50, while the standard error of $hat(beta_1)$ is
  about 0.5. These represent the statistical fluctuations when
  using a single sample to estimate the population regression
  line, and provide a numerical description of the spread of the
  grey lines in @fish2-dist.

#heading(level: 3, numbering: none)[
  Summary
]

@visual-dist shows a stylized depiction of a sampling
distribution that summarizes everything we've covered so far.

Our goal is to estimate some fact about the population, which
we'll denote generically by $theta$, our estimand. We
repeatedly take many samples (say 1,000) from some random
process that generated our data, and for each sample we calculate
our estimator $hat(theta)$.

#figure(
  image("figures/sampling-distribution-05.png", width: 70%),
  caption: [
    A stylized depiction of a sampling distribution of an
    estimator.
  ],
) <visual-dist>

At the end, we combine all the estimates $hat(theta)^1, dots, 
hat(theta)^1000$ into a histogram. This final histogram
represents the sampling distribution of our estimator.

We then ask two questions:

+ Where is the sampling distribution centered?
+ How spread out is the sampling distribution?

#pagebreak()
= The Bootstrap

In the previous section, we uncovered the power of utilizing the
sampling distribution to quantify the statistical uncertainty
of our estimate. To achieve this, we repeatedly sampled the
population over and over again through Monte Carlo simulations
to construct our distribution. However, in the real world we
don't have access to direct sampling from the population.
Most of the time, we're just stuck with one sample. We therefore
_cannot ever know the actual sampling distribution_ of an
estimator.

Thus, quantifying our uncertainty would seem like an impossible 
task. Surprisingly, we actually can come quite close to
performing the impossible. There are two ways of feasibly
constructing something like the histogram in @visual-dist,
thereby approximating an estimator's sampling distribution.

+ Resampling: that is, by pretending that the sample itself
  represents the population, which allows one to approximate
  the effect of sampling variability by resampling
  from the sample.
+ Mathematical approximations: that is, by recognizing that 
  the _forces_ of randomness obey certain mathematical
  regularities, and by drawing conclusions on these regularities
  using probability theory.

In this section, we'll first discuss the resampling approach.

== The Bootstrap Sampling Distribution

The approach to resampling is quite simple. Instead of
repeatedly sampling from our population, which we have already
established as infeasible in almost all real world scenarios,
we can instead take _resamples_ from the sample itself.

This process of pretending that our sample represents some
notional population, and taking repeated samples of size $N$
with replacement from our original sample of size $N$
is called *bootstrap resampling* or just *bootstrapping*.

Why would this work? Remember that uncertainty arises from
the randomness inherent to our data-generating processes. So if
we can _approximately_ simulate this randomness, then we can
_approximately_ quantify our uncertainty.

Here's what bootstrapping looks like.

#figure(
  image("figures/bootstrap-01.png", width: 70%),
  caption: [
    A stylized depiction of a bootstrap sampling distribution
  ],
)

Each block of $N$ resampled data points is called a "bootstrap 
sample." To bootstrap, we write a computer program that
repeatedly resamples our original sample and recomputes our
estimate for each bootstrap sample.

There are two key properties of bootstrapping that make this
idea actually work. First, each bootstrap must be the same size
$N$ as the original sample. If we were to take bootstrap samples
of size $1/2N$ or $N - 1$, or _anything else other than $N$_,
we are simulating a "wrong" data-generating process.

Second, each bootstrap sample must be taken *with replacement*
from the original sample. This creates a _synthetic_ sampling
variability that approximates _true_ sampling variability.

#note[
  I would really make sure that you understand this second
  property well. We're able to use the bootstrap because of the
  fact that sampling with replacement creates different
  bootstrapped samples than the original sample. Check out the textbook for a full overview on the sampling
  with replacement process. I won't go over it here.
]

The core assumption of the bootstrap is that the statistical
uncertainty in your data arises from the processes of sampling.
That is, the bootstrap implicitly assumes that your data can
be constructed as random samples of some wider reference
population. While the bootstrap isn't explicitly designed for
anything else, it's actually a pretty good approximation of
_other_ common forms of randomness as well.

== Bootstrapping Summaries

The following example will utilize the
#link("https://bookdown.org/jgscott/DSGI/data/NHANES_sleep.csv")[
  NHANES_sleep.csv
]
dataset. NHANES is a major survey run by the CDC designed to
assess the health and nutritional status of individuals in the
United States. Specifically, we'll be taking a look at variables
related to sleep.

Here's what the first five lines of the file look like.

```R
head(NHANES_sleep, 5)
```

```R
##   SleepHrsNight Gender Age Race_Ethnicity HomeOwn Depressed Smoke100
## 1             4 female  56          Black     Own      None      Yes
## 2             7   male  34     White (NH)    Rent      None       No
## 3             7   male  27     White (NH)    Rent      None       No
## 4             9   male  50     White (NH)     Own      None       No
## 5             6   male  80          Black    Rent      None       No
```

#example[
  *Sample Mean*

  Let's first address the question of how well Americans are
  sleeping, on average. Our first intuition might be to plot
  the distribution for the ```R SleepHrsNight``` variable in a
  histogram:

  ```R
  ggplot(NHANES_sleep) +
    geom_histogram(aes(x = SleepHrsNight), binwidth = 1))
  ```

  #figure(
    image("figures/bootstrap-02.png", width: 70%),
    caption: [
      ```R SleepHrsNight``` histogram distribution
    ],
  )

  From this, it looks like the sample mean is somewhere around
  7 hours per night, but with a lot of variation. Let's take a
  look at the actual numerical average.

  ```R
  mean(~SleepHrsNight, data = NHANES_sleep)
  ```

  ```R
  ## [1] 6.878955
  ```

  According to the sample, it's 6.88 hours per night, on average.
  But remember, this is just one single sample. We clearly have
  some uncertainty in generalizing this number to the wider
  American population.

  How much? Let's take a single bootstrap sample and calculate its
  mean.

  ```R
  NHANES_sleep_bootstrap = mosaic::resample(NHANES_sleep)
  mean(~SleepHrsNight, data = NHANES_sleep_bootstrap)
  ```

  ```R
  ## [1] 6.833385
  ```

  The result of 6.83 hours, on average, differs from 6.88, the
  mean of the original sample by about 0.05 hours, or 3 minutes.
  This difference represents our bootstrap sampling error. What
  we just did was take a single bootstrap sample. However, to get
  a full picture of our sampling error, we need to find the
  distribution of many bootstrap sample means.

  ```R
  boot_sleep = do(10000)*mean(~SleepHrsNight, data=mosaic::resample(NHANES_sleep))

  ggplot(boot_sleep) + 
    geom_histogram(aes(x=mean))
  ```

  #figure(
    image("figures/bootstrap-03.png", width: 70%),
    caption: [
      Bootstrap sampling distribution for means
    ],
  ) <bootstrap-dist-means>

  Our bootstrap sampling distribution is designed to
  approximate the _true_ sampling distribution. Next, let's ask
  the same two questions for any sampling distribution:

  + Where is it centered?
  + How spread out is it?

  But before we jump into calculating the expected value and
  standard error using processes we learned last chapter, let's
  set up a more standardized process of evaluating "how spread 
  out the sampling distribution" is. This process is called a 
  confidence interval.

  #definition[
    A *confidence interval* is a range of values, calculated from 
    sample data, that is likely to contain the true population 
    parameter with a specified level of certainty.
  ]

  In statistics, the standard "specificed level of certainty"
  is 95%. That is, the interval of which we are 95% confident
  captures the estimand. In our scenario, the interval of which
  we are 95% confident captures the true average hours of sleep
  in Americans. In R, we can use the following.

  ```R
  confint(boot_sleep, level = 0.95)
  ```

  ```R
  ##   name    lower   upper level     method estimate
  ## 1 mean 6.819186 6.93772  0.95 percentile 6.877951
  ```

  This is a 95% confidence interval for the average sleep time
  of the American population. Our best guess is 6.88 hours,
  and we're 95% confident that the true average lies somewhere
  between 6.82 and 6.94.
] 

#heading(level: 3, numbering: none)[
  The Bootstrapping Gotcha
]

Consider the following question about the confidence interval
of the last question.

*True or false:* this histogram, and the associated confidence
interval, tell us that about 95% of all Americans sleep somewhere
between 6.82 and 6.94 hours on an average night.

The issue with this claim lies in interpreting the boostrap
sampling distribution. The bootstrap sampling distribution is
a distribution of _imaginary_ means. That is, the histogram
describes the distribution of a set of means generated from the
process of resampling, not hours.

What _is_ true, however, is that this sample has allowed us to
_estimate_ the population mean quite precisely: it's about
6.82 to 6.94 hours per night, with 95% confidence.

#example[
  *Sample Proportion* Let's take a look at another question
  where we will address the question of "how frequent are
  feelings of depression among the American population?"

  To keep our analysis simple, we'll define a new variable
  ```R DepressedAny``` that encodes whether a participant's
  response to this question was anything other than 
  ```R None```.

  ```R
  NHANES_sleep = NHANES_sleep %>%
    mutate(DepressedAny = ifelse(Depressed != "None", yes = TRUE, no = FALSE))

  prop(~DepressedAny, data = NHANES_sleep)
  ```

  ```R
  ## prop_TRUE 
  ## 0.2034154
  ```

  This tells us that about 20% of participants in the sample
  have some feeling of hopelessness. Let's bootstrap the sample
  to get a sense of our uncertainty.

  ```R
  boot_depression = do(10000) * prop(
    ~DepressedAny,
    data = mosaic::resample(NHANES_sleep)
  )

  ggplot(boot_depression) + 
    geom_histogram(aes(x = prop_TRUE))
  ```

  #figure(
    image("figures/bootstrap-04.png", width: 70%),
    caption: [
      Bootstrap sampling distribution for proportions
    ],
  )

  ```R
  confint(boot_depression, level = 0.95)
  ```

  ```R
  ##        name     lower     upper level     method  estimate
  ## 1 prop_TRUE 0.1858363 0.2209945  0.95 percentile 0.2069312
  ```

  So our best guess is that 20.7% of Americans feel depressed
  at least some of the time. Moreover, based on the sample, we
  are 95% confident that the true population proportion is
  somewhere between 18.6% and 22.1%. This interval represents
  our statistical uncertainty.
]

== Bootstrapping Differences

Let's delve into a deeper example by looking at specific
subgroups. For example, how sleep or depression varies by
gender.

#example[
  *Sleep Hours by Gender*

  ```R
  mean(SleepHrsNight ~ Gender, data = NHANES_sleep)
  ```

  ```R
  ##   female     male 
  ## 6.996954 6.763419
  ```

  It looks like on average females sleep a bit longer than
  males. If we just cared about that difference, we could use
  the following.

  ```R
  diffmean(SleepHrsNight ~ Gender, data = NHANES_sleep)
  ```

  ```R
  ##   diffmean 
  ## -0.2335348
  ```

  By this, in our sample, women sleep on average 0.23 hours
  more than men. But what about our uncertainty?

  ```R
  boot_sleep_gender = do(10000) * diffmean(
    SleepHrsNight ~ Gender, 
    data = mosaic::resample(NHANES_sleep)
  )

  ggplot(boot_sleep_gender) + 
    geom_histogram(aes(x = diffmean))
  ```

  #figure(
    image("figures/bootstrap-05.png", width: 70%),
    caption: [
      Bootstrap sampling distribution for difference in means
    ],
  )

  ```R
  confint(boot_sleep_gender, level = 0.95)
  ```

  ```R
  ##       name      lower      upper level     method  estimate
  ## 1 diffmean -0.3505617 -0.1201343  0.95 percentile -0.229164
  ```

  Based on our results from our bootstrapping, we can say with
  95% confidence that females get a bit more sleep than males,
  on average, with a difference in means somewhere between
  0.12 and 0.35 hours.

  You'll notice that this interval rules out a difference of
  zero. Therefore, we say that the difference is *statistically
  significant*.

  #definition[
    An estimate is said to be *statistically significant* at
    some specified level $alpha$ if a confidence interval
    at level $1 - alpha$ for that estimate _does not contain
    zero_.
  ]

  The convention to report statistical significance is the
  opposite of confidence. Here, we'd say that the difference
  in average sleep time between males and females is
  statistically significant at the 5% level, because a 95%
  confidence interval for that difference fails to contain zero.
]

#example[
  *Smoking and Depression*

  In this example, we'll ask the question of how does
  the frequency of smoking vary according to whether
  someone reports any days where they feel depressed.

  ```R
  prop(Smoke100 ~ DepressedAny, data = NHANES_sleep)
  ```

  ```R
  ##  prop_No.TRUE prop_No.FALSE 
  ##     0.4592593     0.5794451
  ```

  What this is saying is that:

  - among those with at least one depressed day per month 
    (```R DepressedAny = TRUE```), the proportion of nonsmokers
    (```R Smoke100 = "No"```) is about 46%.
  - among those with no depressed days 
    (```R DepressedAny = FALSE```), the proportion of nonsmokers
    (```R Smoke100 = "No"```) is about 58%.

  ```R
  diffprop(Smoke100 ~ DepressedAny, data = NHANES_sleep)
  ```

  ```R
  ##  diffprop 
  ## 0.1201859
  ```

  Altogether, this means that those reporting at least some
  symptoms of depression are 12% more likely to have smoked
  at least 100 cigarettes in their lives.

  Now, let's characterize the statistical uncertainty of this
  number.

  ```R
  boot_smoke_depression = do(10000) * diffprop(
    Smoke100 ~ DepressedAny, 
    data = mosaic::resample(NHANES_sleep)
  )

  ggplot(boot_smoke_depression) + 
    geom_histogram(aes(x = diffprop))
  ```

  #figure(
    image("figures/bootstrap-06.png", width: 70%),
    caption: [
      Bootstrap sampling distribution for difference in 
      proportions
    ],
  )

  ```R
  confint(boot_smoke_depression, level = 0.95)
  ```

  ```R
  ##       name      lower     upper level     method  estimate
  ## 1 diffprop 0.06722841 0.1761976  0.95 percentile 0.1100304
  ```

  Based on these results, our best guess is that there's a 11%
  difference in smoking rates, with a 95% confidence interval
  from 6.7% to 17.6%. Because this interval does not contain
  zero, we can say that the difference is statistically
  significant at the 5% level.
]

== Bootstrapping Regression Models

#note[
  Because much of bootstrapping is the same 3-4 steps, I will
  quickly speed through most of the code, outputs, and figures 
  in this section. For a more thorough explanation on anything,
  please read Dr. Scott's writing in the textbook.
]

#example[
  *Sleep Versus Age*

  ```R
  ggplot(NHANES_sleep) + 
    geom_jitter(aes(x=Age, y=SleepHrsNight), alpha=0.1)
  ```

  #figure(
    image("figures/bootstrap-07.png", width: 70%),
    caption: [
      Scatter plot of the relationship between age and hours 
      slept
    ],
  )

  As you can see from this plot, there isn't any particularly
  obvious correlation between these two variables. However,
  let's create a regression model to help us.

  ```R
  lm_sleep_age = lm(SleepHrsNight ~ Age, data = NHANES_sleep)
  coef(lm_sleep_age)
  ```

  ```R
  ## (Intercept)         Age 
  ##  6.56188885  0.00658811
  ```

  The coefficient of age is positive. 0.006 extra hours of
  nightly sleep with each additional year of age. Now what
  about our uncertainty?

  ```R
  boot_sleep_age = do(10000) * lm(
    SleepHrsNight ~ Age, 
    data = mosaic::resample(NHANES_sleep)
  )

  confint(boot_sleep_age, level = 0.95)
  ```

  ```R
  ##        name       lower        upper level     method    estimate
  ## 1 Intercept 6.386619519  6.736400183  0.95 percentile 6.610473992
  ## 2       Age 0.003269016  0.009923043  0.95 percentile 0.005266427
  ## 3     sigma 1.266657274  1.358531885  0.95 percentile 1.376760140
  ## 4 r.squared 0.001811325  0.016796079  0.95 percentile 0.004324687
  ## 5         F 3.609263281 33.978100537  0.95 percentile 8.639164861
  ```

  Based on our results, we are 95% confident that the true
  population slope of sleeping hours versus age is somewhere
  between 0.003 and 0.010 extra hours per night. Because 0 is
  not in this interval, it is statistically significant at a
  5% level.
]

#heading(level: 3, numbering: none)[
  Statistical vs. Practical Significance
]

What's especially relevant to this example however is the
difference between statistical and practical significance.
Although our results were statistically significant, the scale
of 0.003 and 0.10 extra hours per night is too small to be
considered practically significant.

#pagebreak()
= p-Values

In a stretch of 25 games from the New England Patriot's 2014-15
NFL seasons, they won 19 out of 25 coin tosses. A suspiciously
high 76% winning percentage. Our question that we want to
evaluate is, just how likely is it that one team could win
the coin toss at least 19 out of 25 times.

This calls for something called a *hypothesis test*. The
innocent explanation here that the Patriots just got lucky is
called a _hypothesis_, more specifically the *null hypothesis*.
The goal of our test is to check whether the null hypothesis
seems plausible, or whether instead we need a new hypothesis.
To do this, we'll calculate a number called the *p-value*.

#example[
  *Did the Patriots Cheat?*

  We'll answer this question systematically in R, using
  a Monte Carlo simulation.

  ```R
  rflip(25)
  ```

  ```R
  ## Flipping 25 coins [ Prob(Heads) = 0.5 ] ...
  ##
  ## T H H T T H H H T T H H T T T H H T H H T H T H T
  ##
  ## Number of Heads: 13 [Proportion Heads: 0.52]
  ```

  This simulated the results of 25 coin flips. Here, we'll
  identify the "H" outcome with the Patriots winning. Here,
  it looks like they won 13/25 times, far shy of the 19/25
  coin tosses they actually won in real life.

  Now, let's repeat this simulation 10,000 times and see
  what happens.

  ```R
  patriots_sim = do(10000) * nflip(25)

  ggplot(patriots_sim) + 
    geom_histogram(aes(x = nflip), binwidth = 1)
  ```

  #figure(
    image("figures/p-value-01.png", width: 70%),
    caption: [
      Simulated distribution of patriots coin flip wins
      over 10,000 stretches of 25 flips
    ],
  ) <prob-dist>

  Just eyeballing the histogram, 19 wins ore more seems
  pretty unlikely. Just how unlikely?

  ```R
  sum(patriots_sim >= 19)
  ```

  ```R
  ## [1] 96
  ```

  96 times out of 10,000. Clearly 19 wins is unusual, although
  not impossible. Based on the simulation, we estimate the
  probability to be about 96/10000 $approx$ 0.010. This means
  that for any 25 game stretch, the probability of winning
  the coin toss 19 or more times is 1%.
]

== The Four Steps to Hypothesis Testing

The four major elements to constructing a hypothesis test is
the following:

+ A _null hypothesis_, a "hypothesis to no effect." Here,
  our null hypothesis is that the Patriot's streak of winning
  was due to pure chance, meaning that their chance of winning
  each coin toss was in fact 50%.
+ A _test statistic_, a numerical summary used to measure the
  strength of evidence against the null hypothesis. Here, our
  test statistic is the number of Patriot's coin-toss wins out
  of 25: higher numbers entail stronger evidence against the
  null hypothesis.
+ Calculate the _probability distribution_ of the test statistic
  as seen in @prob-dist.
+ An _assessment_ based on the probability distribution to 
  asses whether the null hypothesis seemed capable of
  explaining the observed test statistic.

To perform our assessment in the previous example, we calculated
the number 0.010 that represented the probability that the
Patriots would go on a lucky streak of at least 19 wins out of
25 coin tosses. This number is called the *p-value*.

#definition[
  A *p-value* is the probability of observing the test
  statistic as extreme as, or more extreme than, the test
  statistic actually observed, given the null hypothesis is
  true.
]

#note[
  In other words, given a probability distribution, the p-value
  just represents the proportion of the area that is "as
  extreme as, or more extreme than the test statistic actually
  observed."
]

== Intepreting p-Values

There are a lot of pitfalls that can occur when interpreting
a p-value. For a full overview on what mistakes and 
misinterpretations can occur while interpreting p-values, take
a look at Dr. Scotts writing in the textbook.

In summary, I think it comes down to two main things:

+ The definition of the p-value says exactly what it is, and it
  is nothing more than what it says it is. That is, don't
  interpret the p-value as anything besides "the probability 
  of observing the test statistic as extreme as, or more 
  extreme than, the test statistic actually observed, given 
  the null hypothesis is true."
+ Smaller p-value does not always signal _practical 
  significance_. Like Dr. Scott puts it, $p = 0.049$ is almost
  identical to $p = 0.051$, yet the first will get you
  published and the second will not.

It's worth understanding the threshold $p <= 0.05$ is quite
arbitrary, and it really just a convention that most
statisticians use to deem _statistical significance_.

#pagebreak()
= Large-Sample Inference

We've now spent some time with Monte Carlo simulations where
we use computer processes to simulate random processes over
and over again using ```R do()``` in R. However, before people
had access to powerful computers that could simulate 10,000
samples in a matter of seconds, statisticians used other
techniques to measure uncertainty.

In this chapter, we'll uncover a set of particular techniques
made possible by some powerful mathematical models developed 
across multiple centuries before the era of modern computers.

#table(
  columns: (auto, auto),
  inset: 5pt,
  align: horizon,
  table.header(
    [*Test*], [*Bootstrap*],
  ),
  [One-sample t-test (or "t interval")],
  [Bootstrapping a sample mean and making a confidence interval],
  [One-sample test of proportion (or "z interval")],
  [Bootstrapping a proportion and making a confidence interval],
  [Two-sample t-test (or z-test)],
  [Bootstrapping the difference in means between two groups using
  ```R diffmean()``` and making a confidence interval for the 
  difference (and possibly checking whether that confidence
  interval contains zero)],
  [Two-sample test of proportions],
  [Bootstrapping the difference in proportions between two groups
  using ```R diffprop()``` and making a confidence interval for
  the difference (and possibly checking whether that confidence
  interval contains zero)],
  [Regression summary table],
  [Bootstrapping a regression model (```R lm()```) and making
  a confidence interval for the regression coefficients (and
  possibly checking whether those confidence intervals contain
  zero)]
)

#note[
  Dr. Scott covers some practical reasons why we may need to
  utilize these mathematical techniques rather than computer
  simulations that is worth checking out. I will be omitting
  them here.
]

== The Central Limit Theorem

#heading(level: 3, numbering: none)[
  The Normal Distribution
]

Throughout the previous three chapters, you may have began to
notice that almost all sampling distributions (given there are
enough samples) tend to look like something called the normal
distribution. Take a look here.

#figure(
  image("figures/large-sample-01.png", width: 70%),
  caption: [
    Nine sampling distributions that all look pretty much 
    the same
  ],
) <nine-dist>

Distributions that have this distinct bell shape to them 
are called *normal distributions* or *Gaussian distributions*.
We call them normal because of how they appear so often in
statistics. As you could imagine, this is _not_ a coincidence
but rather a consequence of a very important result in 
mathematics called the *Central Limit Theorem*. The following
is a simplified explanation.

#theorem(title: "Central Limit Theorem")[
  Sampling distributions based on averages from a large number
  of independent samples basically all look the same: like a normal
  distribution.
]

Let's first try to understand the normal distribution a bit more.
Formally, a normal distribution is defined by two parameters, 
$mu$ and $sigma$, written as $N(mu, sigma)$.

- the mean $mu$, which determines where the peak of the
  distribution is centered.
- the standard deviation $sigma$, which determines how spread out
  the distribution is.

The nine distributions from @nine-dist all had different means and
standard deviations, but it's hard to tell because they're
all shown on different scales and aspect ratios. Below
are three different normal distributions all on the same scale.

#figure(
  image("figures/large-sample-02.png", width: 70%),
  caption: [
    Three different normal distributions on the same scale
  ],
)

As you can see, a normal distribution can be centered anywhere
(depending on $mu$). And it can be tall and skinny, short and
broad, or anywhere in between (depending on $sigma$). If we 
think some random quantity $X$ follows a normal distribution,
we write $X tilde N(mu, sigma)$ as shorthand, where the $tilde$
sign means "is distributed as."

#heading(level: 3, numbering: none)[
  68-95-99.7 Rule
]

There is a repeating pattern associated with normal repeating
variables and their central areas under the curve. If
$X tilde N(mu, sigma)$, then the chance that $X$ will be within
$1 sigma$ of its mean is about 68%; the chance that it will
be within $2 sigma$ of its mean is about 95%; and the chance that
it will be within $3 sigma$ of its mean is about 99.7%.

$
P(mu - 1 sigma < X < mu + 1 sigma) &approx 0.68 \
P(mu - 2 sigma < X < mu + 2 sigma) &approx 0.95 \
P(mu - 3 sigma < X < mu + 3 sigma) &approx 0.997
$

Here it is in a picture.

#figure(
  image("figures/p-value-02.png", width: 70%),
  caption: [
    68-95-99.7 rule of normal distributions
  ],
)

#heading(level: 3, numbering: none)[
  de Moivre's Equation
]

Suppose we take a bunch of samples $X_1, dots, X_N$ from some
wider population whose mean is $mu$, and we calculate
$macron(X)_N$, the mean of the sample. de Moivre's equation
allows us to quantify how spread out the fluctuations are 
around $mu$. Specifically, the Central Limit Theorem tells us
that with enough data points, the distribution of an average
looks approximately normal; de Moivre's equation tells us just
how precisely narrow or wide that normal distribution will be,
as a function of two things.

+ The variability of a single data point.
+ The number of data points you're averaging.

Here it is.

$ "Standard error of the mean" = sigma / sqrt(N) $

This equation tells us two things,

+ The standard error of the mean is proportional to the
  variability of a single data point.
+ The standard error of the mean is inversely proportional to the
  square root of the sample size.

This second point is quite interesting to think about.
Intuition points us in the direction that taking by having a
large sample size, we should expect less variability in our
model. However, de Moivre's equation tells us that we expect less
variability by a square root of the sample size.

This equation also allows us to develop a more complex definition
of the Central Limit Theorem.

#theorem(title: "Central Limit Theorem")[
  Suppose we take $N$ independent samples from some wider
  population, and we compute the average of the samples,
  $macron(X)_N$. Let $mu$ be the mean of the population, and let
  $sigma$ be the standard deviation of a single observation from
  the population. If $N$ is sufficiently large, then the
  statistical fluctuations in $macron(X)_N$ can be well
  approximated by a normal distribution, with mean $mu$ and
  standard deviation $sigma / sqrt(N)$:

  $ macron(X)_N approx N(mu, sigma / sqrt(N)) $
]

#example[
  *FedEx Packages*

  Let's see this in an example with FedEx packages. What's the
  average weight of packages that a FedEx driver delivers in a
  single day, and how does that average fluctuate from truck
  to truck.

  Dr. Scott made a simulated notional population of 100,000 
  imaginary FedEx packages 
  #link("https://bookdown.org/jgscott/DSGI/data/fedex_sim.csv")[
  fedex_sim.csv
  ]

  ```R
  ggplot(fedex_sim) + 
    geom_histogram(aes(x = weight), binwidth = 0.5)
  ```

  #figure(
    image("figures/large-sample-03.png", width: 70%),
    caption: [
      A simulated distribution of FedEx package weights
    ],
  ) <fedex-population-dist>

  Although this is not the actual distribution of all FedEx
  package weights, we can treat it as a stand-in for the
  purposes of this example.

  ```R
  favstats(~weight, data = fedex_sim)
  ```

  ```R
  ##  min   Q1 median   Q3   max    mean       sd      n missing
  ##  0.1 2.07   4.52 8.42 72.99 6.10375 5.605429 100000       0
  ```

  Let's create a sampling distribution for means at $N = 60$.

  #note[
    $N$ represents the sample size of each sample. Not the
    amount of samples we will take.
  ]

  ```R
  sim_n60 = do(5000) * mean(~weight, data = sample_n(fedex_sim, 60))

  ggplot(sim_n60) + 
    geom_histogram(aes(x = mean), binwidth = 0.1)
  ```

  #figure(
    image("figures/large-sample-04.png", width: 70%),
    caption: [
      Sampling distribution of mean package weight for a FedEx truck
      carrying 60 packages
    ],
  )

  Even though the _population distribution_ in 
  @fedex-population-dist looks non-normal, the sampling distribution
  isquite close a normal distribution.

  de Moivre's equation tells us that the standard error of the mean
  of 60 packages is:

  $ "std. err." = sigma / sqrt(N) = 5.6 / sqrt(60) approx 0.72 $

  To illustrate how accurate de Moivre's equation is, let's
  superimpose a $N(6.1, 0.72)$ distribution on top of the previous
  histogram.

  #figure(
    image("figures/large-sample-05.png", width: 70%),
    caption: [
      Sampling distribution $N = 60$ superimposed with 
      $N(6.1, 0.72)$
    ],
  )

  Dr. Scott repeats the previous process but for $N = 300$, and
  once again the results were very similar.
]

== Confidence Intervals for a Mean

Now that we've learned about the Central Limit Theorem and
de Moivre's equation, how can we get confidence intervals
without bootstrapping?

The answer to this question we've actually already answered.
Recall when we talked about the 68-95-99.7% rule for normal
distributions. Because our sampling distribution is a normal
distribution, we can use our definition of the 68-95-99.7% rule.

That is, if we quote the confidence interval as 
$macron(X)_N plus.minus 2 dot sigma / sqrt(N)$, we should capture
$mu$ in our interval 95% of the time. Simple as that.

#example[
  *Sleep, Revisited*

  Recall 
  #link("https://bookdown.org/jgscott/DSGI/data/NHANES_sleep.csv")[
  NHANES_sleep
  ]

  ```R
  ggplot(NHANES_sleep) +
    geom_histogram(aes(x = SleepHrsNight), binwidth = 1))
  ```

  #figure(
    image("figures/bootstrap-02.png", width: 70%),
    caption: [
      ```R SleepHrsNight``` histogram distribution
    ],
  )

  ```R
  mean(~SleepHrsNight, data=NHANES_sleep)
  ```

  ```R
  ## [1] 6.878955
  ```

  We found that on average, Americans sleep $mu = 6.88$ hours
  per night.

  Our sample size $N$ is ...

  ```R
  nrow(NHANES_sleep)
  ```

  ```R
  ## [1] 1991
  ```

  And we estimate that standard deviation $sigma$ of the
  ```R SleepHrsNight``` variable is:

  ```R
  sd(~SleepHrsNight, data = NHANES_sleep)
  ```

  ```R
  ## [1] 1.317419
  ```

  ... about 1.32 hours. Therefore de Moivre's equation says that
  the standard error of our sample mean should be...

  $ "std. err." = sigma / sqrt(N) = 1.32 / sqrt(1991) approx 
  0.0296 $

  What about our 95% confidence interval? Let's compare our
  bootstrapped confidence interval with what we get using de
  Moivre's equation.

  ```R
  confint(boot_sleep, level = 0.95)
  ```

  ```R
  ##   name    lower   upper level     method estimate
  ## 1 mean 6.819186 6.93772  0.95 percentile 6.877951
  ```

  And if we use de Moivre's equation to go our two standard
  errors to either side of the sample mean, we get a confidence
  interval of...

  $
  6.88 - 2 dot 0.0296 &approx 6.821 \
  6.88 + 2 dot 0.0296 &approx 6.939
  $

  As you can see, these confidence intervals are nearly identical.
  This is exactly what this new mathematical approach allows us 
  to do.
]

#heading(level: 3, numbering: none)[
  ```R t.test()``` Shortcut
]

In the previous example to calculate the confidence interval
using de Moivre's equation, our process of calculating mean,
standard deviation, standard error, and then finding the interval
could all be automated.

That's exactly what ```R t.test()``` does for us.

```R
t.test(~SleepHrsNight, data = NHANES_sleep)
```

```R
## 
##  One Sample t-test
## 
## data:  SleepHrsNight
## t = 232.99, df = 1990, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  6.821052 6.936858
## sample estimates:
## mean of x 
##  6.878955
```

For a slightly technical overview on why ```R t.test()```
numbers differ slightly from hand calculation, check Dr. Scott's
textbook writing.

== Beyond de Moivre's Equation

The big idea here is that the sample mean isn't the only statistic
that turns out to be normal. There are a lot of estimators that
are _asymptotically normal_. Meaning,

#definition[
  An estimator is said to be *asymptotically normal* if its
  sampling distribution is approximately normal for large enough
  samples.
]

For any asymptotically normal estimator $hat(theta)$, we
can calculate a confidence interval using the same basic approach:

+ Calculate the sample estimate $hat(theta)$
+ Calculate the standard error in the estimate $"se"(hat(theta))$
+ Form the confidence interval like this:

$ theta in hat(theta) plus.minus z dot "se"(hat(theta)) $

The only thing that's different from one summary statistic to the
next is how we calculate the standard error. For means, we use
$"se"(macron(X)_N) = sigma / sqrt(N)$. For any statistic other
than the mean, we a "de-Moivre-like" formula to calculate the
standard error.

#note[
  If you took a course in highschool similar to AP Statistics,
  the following will feel very familiar.
]

#heading(level: 3, numbering: none)[
  Sample Mean
]

$ "se"(macron(x)) = sigma / sqrt(N) $

#heading(level: 3, numbering: none)[
  Sample Proportion
]

$ "se"(hat(p)) = sqrt( hat(p) dot (1 - hat(p)) / N ) $

#heading(level: 3, numbering: none)[
  The Pythagorean Theorem of Statistics
]

$ ["se"(hat(theta)_1 - hat(theta)_2)]^2 = ["se"(hat(theta)_1)]^2
+["se"(hat(theta)_2)]^2 $

#note[
  If you're having trouble understanding why a theorem for
  triangles is applicable here, I would recommend reading Dr.
  Scott's writing on it.
]

- Difference of means, $macron(x)_1 - macron(x)_2$

$ "se"(macron(x)_1 - macron(x)_2) = sqrt(sigma_1^2 / N_1
+ sigma_2^2 / N_2) $

- Difference of proportions, $hat(p)_1 - hat(p)_2$

$ "se"(hat(p)_1 - hat(p)_2) = sqrt(hat(p)_1 dot (1 - hat(p)_1) / 
N_1 + hat(p)_2 dot (1 - hat(p)_2) / N_2) $

#example[
  *Sample Proportion*

  In this example, we'll investigate the proportion of beers in 
  #link("https://bookdown.org/jgscott/DSGI/data/beer.csv")[
  beers.csv
  ]
  , which is of a style ```R IPA```.

  ```R
  prop(~IPA, data = beer)
  ```

  ```R
  ## prop_TRUE 
  ## 0.2063953
  ```

  Most of our analysis will be of the following form:

  *Step 1: Summary statistics.* $hat(p) = 0.206, N = 344$
  *Step 2: Standard error.*

  $ "se"(hat(p)) = sqrt(hat(p) dot (1 - hat(p)) / N) = sqrt(
  0.206 dot (1 - 0.206) / N) = 0.022 $

  *Step 3: Confidence interval.* For a confidence interval of 95%,
  we go out two standard errors from our sample estimate of 0.206.
  Therefore out 95% confidence interval is:

  $
  0.206 plus.minus 2 dot 0.022 \
  approx (0.16, 0.25)
  $

  If you were to construct a bootstrap smapling distribution for
  this scenario, your results would be approximately the same.

  #heading(level: 3, numbering: none)[
    ```R prop.test()``` Shortcut
  ]

  ```R
  prop.test(~IPA, data = beer)
  ```

  ```R
  ## 
  ##  1-sample proportions test with continuity correction
  ## 
  ## data:  beer$IPA  [with success = TRUE]
  ## X-squared = 117.44, df = 1, p-value < 2.2e-16
  ## alternative hypothesis: true p is not equal to 0.5
  ## 95 percent confidence interval:
  ##  0.1656553 0.2538389
  ## sample estimates:
  ##         p 
  ## 0.2063953
  ```
]

#example[
  *Difference of Means*

  Let's now compare the mean ```R ped``` (price elasticity of
  demand) for ```R IPA```'s versus non-```R IPA```'s:

  ```R
  ggplot(beer) + 
    geom_boxplot(aes(x = IPA, y = ped))
  ```

  #figure(
    image("figures/large-sample-06.png", width: 70%),
    caption: [
      Distribution of ```R ped``` by ```R IPA``` status.
    ],
  )

  #note[
    I'll skip over the manual standard error and confidence
    interval calculation and go straight into the test
    shortcut.
  ]

  ```R
  t.test(ped ~ IPA, data = beer)
  ```

  ```R
  ## 
  ##  Welch Two Sample t-test
  ## 
  ## data:  ped by IPA
  ## t = 15.827, df = 106.98, p-value < 2.2e-16
  ## alternative hypothesis: true difference in means between 
  ## group FALSE and group TRUE is not equal to 0
  ## 95 percent confidence interval:
  ##  1.143341 1.470774
  ## sample estimates:
  ## mean in group FALSE  mean in group TRUE 
  ##           -1.485055           -2.792113
  ```
]

#example[
  *Regression Model*

  Let's investigate the relationship between maximum heart rate
  and age in
  #link("https://bookdown.org/jgscott/DSGI/data/heartrate.csv")[
  heartrate.csv
  ].
  
  ```R
  ggplot(heartrate) + 
    geom_point(aes(x = age, y = hrmax))
  ```

  #figure(
    image("figures/large-sample-07.png", width: 70%),
    caption: [
      Scatter plot of the variables ```R age``` and ```R hrmax```
    ],
  )

  ```R
  lm_heart = lm(hrmax ~ age, data = heartrate)
  coef(lm_heart)
  ```

  ```R
  ## (Intercept)         age 
  ## 207.9306683  -0.6878927
  ```

  In R, we can just call ```R confint()``` to get on our 
  fitted model object.

  ```R
  confint(lm_heart)
  ```

  ```R
  ##                  2.5 %      97.5 %
  ## (Intercept) 203.824290 212.0370467
  ## age          -0.795802  -0.5799834 
  ```

  So this gives us our 95% confidence interval on both our
  intercept and slope. For age, it's about (-0.80, -0.58).
]

#pagebreak()
= Experiments

== Causal vs. Statistical Questions

There exists a difference between causal questions and
statistical. Causal questions tend to be based on 
hypothetical if-then situations, where some "treatment"
variable is changed and everything else is held equal.
Statistical questions, on the other hand, are about the
patterns we observe in the real world.

For example, suppose we observe that people who eat more vegetables
live longer. But those same people who eat lots of
vegetables probably also tend to exercise more, live in
better housing, and work higher-status jobs. These other
factors are _confounders_.

#definition[
  A *confounder* is a competing causal explanation for some
  observed correlation.
]

In our example, the presence of confounders forces us to ask
the question: is it the vegetables that make people live
longer, or is it just the other things that vegetable
eaters have/are/do?

This task isn't easy, but neither is it impossible. This
chapter will explore how we can minimize the effect of
confounders through _experiments_, also known as a 
_randomized control trial_.

== Control Group

In an experiment, a _control group_ is the standard by which
comparisons are made. Typically, it's a group of subjects in
an experiment or study that do not receive the treatment
under study, but rather are used as a benchmark for subjects
that _do_ receive the treatment.

#example[
  You recruit 100 people suffering from cold symptons. You
  feed them oranges, which are full of Vitamin C. Seven days
  later, 92 out of 100 people are free of cold symptoms.
  Did the oranges make people better?
]

Chances are, the oranges may have accelerated the recovery of
the 100 people, but people tend to recover from a cold on 
their own after seven days anyways. As you can see,
there's clear confounding going on in this experiment.

#heading(level: 3, numbering: none)[
  Placebos
]

In another form of trial, some patients are intentionally
given a useless treatment. Using a placebo for your control
group avoids the possibility that patients might simply
imagine that the latest miracle drug has made them feel
better.

#definition[
  A *placebo effect* is any effect produced by some treatment
  that cannot be attributed to the properties of the
  treatment itself, and must therefore be due to the patient's
  belief in the effect of that treatment.
]

Because of placebo effects, we don't compare "treatment" to
"nothing." Instead, we compare "treatment" with "other
treatment" which could be a placebo.

== Randomization

I think that randomization is probably the easiest to
understand when it comes to an experiment. Here's an example
on an experiment on the health benefits of broccoli. 

We take our sample population and assign one group to eat
more broccoli in their diet ("treatment"), and one group to
not eat broccoli ("control"). Specifically, we are interested
in measuring the difference in blood pressure between our two
groups.

The issue with the experiment is that we don't know how
the two groups were assigned. What if one group was 
significantly wealthier than the other? Wealthy people
tend to live healthier lives and have lower blood pressure
with or without broccoli. What if one group was younger
than the other? Younger people tend to have lower blood
pressure with or without broccoli. You get the point.

The only way to "balance out" these difference between
the two groups is by randomization.

== Blocking

Consider this study on sets of twins. One twin is given the
treatment, and the other is given the control. If you
notive that the "treated" twins differed systematically from
"control" twins, then you'd have a pretty good evidence of
causality. This is because confounding is impossible; we're
talking about identical twins.

This principle is called _blocking_, a process that originated
from agricultural experiments. Suppose you wanted to test
two different farming practices, A and B. And suppose you
had a big property with a bunch of different areas that
varied in their underlying growth conditions for the crop.

#figure(
  image("figures/experiments-01.png", width: 70%),
  caption: [
    Plot of land with different conditions
  ],
)

If we were to randomly assign the treatments A and B,

#figure(
  image("figures/experiments-02.png", width: 70%),
  caption: [
    Same plot of land with randomly assigned treatments
  ],
)

We could get this outcome. But as you can see, by pure
chance, B landed on most of the plush & productive land,
whereas A landed on most of the unproductive land. If we
went on and performed this experiment, we might conclude
that treatment B is better than treatment A, but that 
could've been because by chance, B was on most of the 
productive land.

A better approach is blocking. You split the blocks into
identical twins, then assign treatment A and B to each half
respectively.

#figure(
  image("figures/experiments-03.png", width: 70%),
  caption: [
    Same plot of land with blocking
  ],
)

Now differences in underlying land quality can't drive
the outcome.

In general, a _block_ design means arranging of experimental
units in groups that are similar to one another.

A natural question is: when should we block and when should
we randomize? In general, we use blocking to balance
confounders that are both _known_ and _under the experimentor's
control._ We then rely on randomization within blocks.

*Block what you can, randomize what you cannot.*

#pagebreak()
= Grouped Data

This chapter will explore using fitting equations to describe
grouped data. In effect, we're combining data wrangling
with the concept of linear regressions.

== Baseline/Offset Form

A common goal in statistics is to quantify differences in
some outcome variable across different groups.

- How much more cheese do people buy when you show them an ad
  for cheese, versus not showing the ad?
- How much less likely is a heart attack on a Mediterranean
  diet versus a low-fat diet?
- How much more quickly do video-gamers react to a bad guy
  popping up on the screen when the bad guy is large, rather
  than small?

These are all questions about _differences_. About comparing
some situation of interest versus a baseline situation. For
this reason, we usually fit models for grouped data in
"baseline/offset" form.

#note[
  Review Dr. Scott's writing for clear examples of how
  baseline/offset works. Basically, just pick one as the 
  baseline, and everything else is an offset from the
  baseline.
]

== Models with One Dummy Variable

#definition[
  A *dummy variable* is a variable that takes only two
  possible values, 1 or 0. It is used to indicate whether a
  case in your data frame does (1) or does not(0) fall into
  some specific category.
]

In R, the application of this is quite simple, you can just
feed your variable into ```R lm()``` and it will make
the dummy variable for you. For an in depth example,
check our Dr. Scott's writing.

== Models with Multiple Dummy Variables

Let's take a look at an example in an video game where
researches measured the reaction time of participants
under different conditions.
#link("https://bookdown.org/jgscott/DSGI/data/rxntime.csv")[
rxntime.csv
]

#example[
  ```R
  games_model1 = lm(PictureTarget.RT ~ FarAway + Littered, data = rxntime)
  coef(games_model1) %>%
    round(0)
  ```

  ```R
  ## (Intercept)     FarAway    Littered 
  ##         482          50          87
  ```

  Our model for reaction time $y$ is,

  $ hat(y) = 482 + 50 dot "FarAway" + 87 dot "Littered" $

  This equation encodes all four combinations of our dummy
  variable.

  - If $"FarAway" = 0$ and $"Littered" = 0$,
    $hat(y) = 482$
  - If $"FarAway" = 1$ and $"Littered" = 0$,
    $hat(y) = 482 + 50$
  - If $"FarAway" = 0$ and $"Littered" = 1$,
    $hat(y) = 482 + 87$
  - If $"FarAway" = 1$ and $"Littered" = 1$,
    $hat(y) = 482 + 50 + 87$
    
  #heading(level: 3, numbering: none)[
    Using ```R factor()```
  ]

  In our data, ```R subject``` is a categorical variable
  for the ID of each subject but it is encoded numerically. If
  we plot the distribution of reaction times for each subject,
  we get:

  ```R
  ggplot(rxntime) + 
    geom_boxplot(aes(x = Subject, y = PictureTarget.RT))
  ```

  ```R
  ## Warning: Continuous x aesthetic -- did you forget aes(group=...)?
  ```

  #figure(
    image("figures/grouped-data-01.png", width: 70%),
    caption: [
      Incorrect encoding of ```R subject``` as numerical
    ],
  )

  Instead, we need to _explicitly_ tell R that ```R Subject```,
  despite being a number, is really a categorical variable.

  ```R
  rxntime = mutate(rxntime, Subject = factor(Subject))
  ```

  The ```R factor()``` method does that for us in R.

  ```R
  ggplot(rxntime) + 
    geom_boxplot(aes(x = Subject, y = PictureTarget.RT))
  ```

  #figure(
    image("figures/grouped-data-02.png", width: 70%),
    caption: [
      Correct encoding of ```R subject``` as categorical
    ],
  )
]

== Interactions

#definition[
  An *interaction* in data science is used to describe
  situations where the effect of some predictor variable
  on the outcome $y$ is *context-specific*.
]

When we talk about _modeling interactions_, we're capturing
context-specific phenomena. That is, we're trying to account
for the fact that the _joint effect_ of two predictor
variables may not be reducible to the sum of their individual
effects.

#example[
  *Back to Video Games*


]
