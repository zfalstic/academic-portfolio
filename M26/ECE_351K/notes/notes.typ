#import "@preview/ilm:2.1.1": *

#set text(lang: "en")

#show: ilm.with(
  title: [ECE 351K: Probability and Random Processes],
  authors: "Dawson Zhang",
  date: datetime.today(),
  abstract: [
  ],
  preface: [
    #align(center + horizon)[
      Dawson Zhang
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

= Introduction to Probability

In the real world, collected data is used in inference and
statistics. Statisticians use that data and make models.
Probability occurs when those models are used as predictions
to make real world decisions.

== Sample Spaces

- Starts with an _experiment_
- Each run of an experiment is called a _trial_
- The result of a trial is called an _outcome_
- The set of all relevant possible outcomes is called a *Sample
  Space*
- Outcomes must be:
  + Mutually exclusive
  + Collectively exhaustive

#let sample-space-table = table(
  columns: 2,
  table.header[Experiment][Sample Space],
  [Flip of a coin], [HEADS or TAILS],
  [Roll of a die], [1 through 6],
  [Choice of card], [All cards of the deck],
)

#figure(caption: [Corresponding sample
spaces to separate experiments], sample-space-table)

== Axioms of Events and Probabilities

- *Event:* A _subset_ $A$ of a sample space

- An event is a set of _outcomes of interest_

- Probabilities are assigned to events

- The probability of event $A$ is denoted as $P(A)$

- $P(A)$ needs to satisfy these *Axioms:*
  + Non-negativity: $P(A) <= 0$
  + Normalization: $P(Omega) = 1$
  + Additivity: If $A inter B = emptyset$, then $P(A union B) = 
  P(A) + P(B)$

Consequences of the Axioms:

- $P(A) <= 1$

- $P(emptyset) = 0$

- $P(A) + P(A^complement) = 1$

- if $A in B$, then $P(A) < P(B)$

- $P(A union B) = P(A) + P(B) - P(A inter B)$

== Examples of Probabilistic Problems

*Three Tosses of a Coin:*

- $Omega = {H H H, H H T, H T H, H T T, T H H, T H T, T T H, T T T}$
- If it is a fair coin, each of the 8 outcomes will have a
  probability of 1/8
- If $A$ is the event that exactly 2 heads occur, then
- $P(A) = 3/8$

= Conditional Probability

There is a 52-card deck (no jokers) and a card is picked from
the deck.

_What is the probability that it is a heart?_

+ Specify the sample space

  #figure(
    image("cards-sample-space.png", width: 70%),
    caption: [
      Sample space of a deck of cards. 
    ],
  )

+ Specify the probability law: $1/52$
+ Specify the event of interest: $13/52 = 1/4$

_What is the probability that it is a heart card GIVEN that 
the card is a Jack_

+ Specify the sample space: the four jack cards
+ Specify the probability law: $1/4$
+ Specify the event of interest: (occurs only once) $1/4$

Assume an experiment with 12 equally likely outcomes

#figure(
  image("conditional-a-b.png", width: 70%),
  caption: [
    Conditional probability example.
  ],
)

$
P(A) &= 5/12 \
P(B) &= 6/12
$

If we were told *$B$* occured...

$ P(A|B) = 2/6 $

== Definition of Conditional Probability

$P(A|B)$ = "Probability of event $A$, *_given that_* event $B$
has occured"

$ P(A|B) = P(A inter B) / P(B) $

_defined only when $P(B) > 0$_

#figure(
  image("conditional-intersect.png", width: 70%),
  caption: [
    Conditional probability with intersection.
  ],
)

_Example._ Two roll of a die

#figure(
  image("2-dice-conditional.png", width: 70%),
  caption: [
    Two die roll conditional probability example.
  ],
)

- Let $#text(fill: blue)[A]$ be the event: $min(X, Y) = 3$
- Let $#text(fill: red)[B]$ be the event: $max(X, Y) = 5$
- Find $P(A|B)$

$
P(A|B) &= P(A inter B) / P(B) \
&= 2/9
$

== Multiplication Rule

- What if I told you that ...
  - ECE majors make up 10% of the UT student population, and
  - The probability that an ECE major likes donuts is 0.7
- And asked you ...
  - What is the probability that a randomly picked UT student
    is an ECE major _AND_ likes donuts?

In other words, where $P(A)$ = is ECE major and $P(B)$ = likes
donuts:

- What is $P(A inter B)$ given the information of $P(A)$ and
  $P(B | A)$

$
P(A|B) &= P(A inter B) / P(B) \
P(A|B) * P(B) &= P(A inter B)
$

$P("ECE major" inter "likes donuts") = 0.1 * 0.7 = 0.07$

- The probability of selecting a student in the UT population
  that is an ECE student _AND_ likes donuts is 7%.

== Total Probability Theorem

- What if I told you that ...
  - On MWF, I eat oatmeal with probability 0.3
  - On TTH, I eat oatmeal with probability 0.4
  - On SAS, I eat oatmeal with probability 0.2
- And asked you ...
  - What is the probability that I eat oatmeal on any given day?

