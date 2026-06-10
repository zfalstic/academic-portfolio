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
