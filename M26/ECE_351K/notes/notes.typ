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

#set math.equation(numbering: none)

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
      Sample Space of a Deck of Cards. 
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
    Conditional Probability Example.
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
    Conditional Probability with Intersection.
  ],
)

_Example._ Two roll of a die

#figure(
  image("2-dice-conditional.png", width: 40%),
  caption: [
    Two Die Roll Conditional Probability Example.
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

#figure(
  image("total-probability.png", width: 70%),
  caption: [
    Total Probability Example.
  ],
)

Given $P(A_i)$, and $P(B | A_i)$, how to compute $P(B)$?
- Partition sample space $Omega$ into $A_1$, $A_2$, and $A_3$
  - $A_1 union A_2 union A_3 = Omega$, and
  - $A_1 inter A_2 = A_2 inter A_3 = A_3 inter A_1 = emptyset$
- Assume we know $P(A_i)$, for every $i$
- Specify an event of interest $B$
- Assume we know $P(B|A_i)$, for every $i$

$
P(B) &= P((A_1 inter B) union (A_2 inter B) union (A_3 inter B)) \
&= P(A_1 inter B) + P(A_2 inter B) + P(A_3 inter B) \
&= P(A_1) P(B | A_1) + P(A_2) P(B | A_2) + P(A_3) P(B | A_3)
$

$
P(B) = sum^n_(i = 1) P(A_i) P(B | A_i)
$

== Bayes' Rule

- If I have COVID, the test manufacturer tells me that the test
  will detect the virus with 99% accuracy. 
  - $P("+ve test" | "have COVID")$
- But what I really want to know is ...
  if my test comes back positive, do I REALLY have COVID?
  - $P("have COVID" | "+ ve test")$

#figure(
  image("total-probability.png", width: 70%),
  numbering: none
)

Given $P(A_i)$, and $P(B | A_i)$, how to compute $P(A_i | B)$?

- Partition sample space $Omega$ into $A_1, A_2, A_3$
- Assume we know $P(A_i)$, for every $i$
  - This is the initial, or "*a priori*" probability
- Specify an event of interest $B$.
- Assume we know $P(B | A_i)$, for every $i$
- If we are then told that $B$ has occurred, the _revised_, or
  "*a posteriori*" probabilities of $A_i "given" B$ are given by:

$
P(A_i | B) &= P(A_i inter B) / P(B) \
P(A_i | B) &= (P(A_i) P(B | A_i)) / (sum_j P(A_j) P(B | A_j))
$

_example._ *The Virus Testing Problem*

- A virus test claims "95% accuracy"
- Which means you really want to know ...
  - if the test is positive, do you _really_ have the virus?
- Event $A$: You have the virus
- Event $B$: The test is positive
- Test specs:
  - Correct detection: 95%. Missed detection: 5%
  - Correct non-detection: 95%. False positive: 5%

#table(
  columns: 2,
  [95%], [5%],
  [95%], [5%]
)

#table(
  columns: 2,
  [$P(B | A)$], [$P(B' | A)$],
  [$P(B' | A')$], [$P(B | A')$]
)

$P(A)$ is known to be $0.01$

#figure(
  image("virus-tree.png", width: 30%),
  caption: [
    Virus Testing Tree.
  ],
)

- $P(A inter B) = P(A) P(B | A) = 0.01 dot 0.95 = 0.0095$ 
- $P(B) = P(A) P(B | A) + P(A') P(B | A') = 0.01 dot 0.95
  + 0.99 dot 0.05 = 0.059$
- $P(A | B) = P(A inter B) / P(B) = 0.0095/0.059 = 0.161$

= Independence

If the occurence of $B$ provides no information that alters
the probability model of event $A$, we say that $A$ is
*independent* of $B$.

$
P(A | B) = P(A)
$

Recall that 

$
P(A | B) &= P(A inter B) / P(B) \
P(A) &= P(A inter B) / P(B) \
P(A) P(B) &= P(A inter B)
$

We say that the events $A_1, A_2, dots, A_n$ are independent only
if the events are pairwise and groupwise independent.

_example._ Two Coin Tosses

- $A = {"1st toss is a Head"}$
- $B = {"2nd toss is a Head"}$
- $C = {"the two tosses have different results"}$

Are $A, B, C$ independent?

- $P(A) = P({(H, H), (H, T)}) = 1/2$
- $P(B) = P({(H, H), (T, H)}) = 1/2$
- $P(C) = P({(H, T), (T, H)}) = 1/2$

Caculate pairwise independence

- $P(A inter B) = 1/4$, $P(A)P(B) = 1/4$
- $P(A inter C) = 1/4$, $P(A)P(C) = 1/4$
- $P(C inter B) = 1/4$, $P(C)P(B) = 1/4$

Calculate triplewise independence

- $P(A inter B inter C) = 0$, $P(A)P(B)P(C) = 1/8$

*NOT INDEPENDENT*, $0 eq.not 1/8$

== Conditional Independence

- Two events $A$ and $B$ are *conditionall independent* given an event $C$, if

$
P(A inter B | C) = P(A | C) P (B | C)
$

- Two independent events need not be conditionally independent
- Two conditionally independent events need not be independent

_note._ These two ideas are basically just unrelated. In a way,
they in themselves are independent.

= Counting

Why do we need to study counting?

- if $Omega$ is finite, and contains $n$ elements: ${s_1, s_2, dots, s_n}$
- Then if each outcome is equally likely, each will have a 
  probability $1/n$
- If the event $A$ consists of $k$ elements: ${s_1, s_2, dots, s_k}$
- Then $$

== The Counting Principle

If you have a menu with 3 appetizers, 4 entrees, and 2 desserts,
how many distinct meals you can put together?

$
3 dot 4 dot 2 = 24
$

_example._

Number of license plates of 2 letters followed by 4 digits

- Repition allowed: $26^2 dot 10^4$
- Not allowed: $26 dot 25 dot 10 dot 9 dot 8 dot 7$

== $k$-permutations

A $k$-permutation is the process of selecting and arranging $k$
objects out of a collection of $n$ objects, and the order of
selection matters.

$
26 dot 25 dot 24 dot 23 = 26! / 22!
$

In general, 

$
n_p_k= n! / (n-k)!
$

_example._ Rearrange 10 books on bookshelf

Notice that $n = k$, this is a special case.

$
n!/(n - n)! = n! / 0! = n!
$

== Combination

A combination is the process of selecting a set of $k$ objects
out of a collection of $n$ objects, and the order of selection
doesn't matter.

$
vec(n, k) = n! / (k!(n - k)!)
$

_example._ How many ways of choosing 3 students out of 10?

$
vec(10, 3) = (10!) / (3! dot 7 !) = (10 dot 9 dot 8) / (3 dot 2 dot 1)
$

_example._ How many ways of choosing a President, VP, and Treasurer?

Permutation.

_example._ How many sequences of $n$ coin tosses have $k$ heads?

Combination

#link("https://claude.ai/share/59b8ec1e-afbc-4268-9cfa-46939f2c0e74")[Claude]

= Discrete Random Variables

#figure(
  image("random-mapping.png", width: 90%),
  caption: [
    Random Variable Mapping
  ],
)

- A *random variable* is a real-valued function of the experimental
  outcome
- It assigns a real number value to every possible outcome
- Notation: $X$ is the random variable, $x$ is the *value* of the
  random variable

_example._ 10 tosses of a coin

- Outcomes: $2^10$ sequences of heads and tails
  - Example outcome: HHHTTHTTHH
- Example random variable $X$: Number of heads in the sequence
- Example random variable $Y$: Number of heads before the first tails
- Example random variable $Z$: Length of the longest string of heads

== Probability Mass Function

- A _discrete_ random variable takes on finite or countably
  infinite values
- A *probability mass function (PMF)* represents the probabilities
  that the random variable can take on different values
- The probability mass $p_X(x_1)$ is the probability of the
  event ${X = x_1}$

_example._ Two independent tosses of a fair coin

R.V. $X$ is defined as the number of heads.

#table(
  columns: 2,
  table.header[Outcome][$x$],
  [HH],[2],
  [HT],[1],
  [TH],[1],
  [TT],[0],
)

#table(
  columns: 2,
  table.header[$x$][$p_X ()$],
  [0],[1/4],
  [1],[1/2],
  [2],[1/4],
)

== Properties of the PMF

- $p_X (x) >= 0$  (Non-negativity axiom)
- $sum_x p_X (x) = 1$ (Normalization axiom)
- $P(X = a union X = b) = p_X (a) + p_X (b)$ (Additivity axiom)
- $P(a <= X <= b) = sum_(x: a <= x <= b) P_X (x)$ (Additivity axiom)

== Uniform Random Variable

- Pick an integer from the range $a, dots, b$
- Sample space: $Omega = {a, a + 1, dots, b}$
- *All outcomes are equally likely*
- Examples:
  - Lottery numbers
  - Die roll

== Binary Random Variable

- Associated with a binary experiment, only two outcomes
- Widely used, can be used for a binary valued random variable
  - Win/loss
  - Pass/fail
  - Sick/healthy
  - Guilty/not guilty
- $X = {0, 1}$
- $p_X (1) = p$
- $p_X (0) = 1 - p = p'$

== Geometric Random Variable

- Experiment: an infinite number of *independent* coin tosses,
  $P("Heads") = p$
- Sample space: Set of infinite sequences of H and T
- Random variable $X$: number of tosses needed to see the first
  head
$
p_X (x) = P(X = x) &= P(T_1 T_2 dots T_(x - 1) H) \
&= P(T_1)P(T_2)dots P(T_(x-1))P(H) \
&= (1 - p)^(x - 1) p
$

== Binomial Random Variable

- Experiment: $n$ independent coin tosses of a coin with
  $P("Heads") = p$
- Sample space: Set of $2^n$ sequences of H and T, length $n$
- Random variable $X$: number of Heads
- Parameter: $p in [0, 1]$

$
p_X (k "heads") = vec(n, k) p^k (1 - p)^(n - k)
$

_example._

- Consider a sequence of 10 independent coin tosses with
  $P(H) = p$.
- What is the probability that the first two tosses are Heads
  given that there are 3 Heads in 10 tosses.
- $A = {"first two are heads"} = {H, H, X, X, X, X, X, X, X, X}$
- $B = {"3 Heads out of 10 tosses"}$

$
P(A|B) = P(A inter B) / P(B) = (p^2 dot vec(8, 1) p(1 - p)^7) / (vec(10, 3) p^3 (1 - p)^7)
$

== Expectation

$
E[X] = sum_x x p_X (x)
$

== Functions of Random Variables

Let $X$ be a R.V. with PMF $p_X (x)$, and let $Y$ be another
R.V., where $Y = g(X)$

What is the PMF of $Y$?

$
p_Y (y) &= sum_(x | g(x) = y) p_X (x) \
E[Y] &= sum_x g(x) p_X (x)
$

_example._

- If $Y = X^2$, i.e., $g(X) = X^2$
- If $Y = a X + b$, then $E[Y] = sum_x (a x + b)p_X (x)$
  - $E[Y] = sum_x a x p_X (x) + sum_x b p_X (x)$
  - $E[Y] = a sum_x x p_X (x) + b sum_x p_X (x)$
  - $E[a X + b] = a mu + b$. So, in this case, $E[g(X)] = g(E[X])$

_This is known as the *Linearity of Expectation*_

= Variance

_consider this._

- Suppose you could play one of two games ...
- In each game the amount of money you win is a random variable $X$

#image("variance-c1.png", width: 30%)
#image("variance-c2.png", width: 30%)


- Both r.v.s have uniform PMFs
- Both have the same *expectation*
- But are the games the same?
- What is different?

*Variance* is a measure of the "spread" of the PMF around the _mean_

$
"var"(X) = E[(X - mu)^2] = sigma_X^2
$

Using the expected value rule,

$
sigma_X^2 = sum_x (x - mu)^2 p_X (x)
$

*Standard Deviation*

$
sigma_X = sqrt("var"(X))
$

_properties of variance._

$
"var"(a X + b) = a^2 sigma_X^2
$

$
"var"(X) &= E[X^2] - (E[X])^2 \
E[X^2] = "var"(X) + (E[X])^2
$

== Variance of Bernoulli

$
"var"(X) = p - p^2
$

== Variance of Uniform

$
"var"(X) &= n(n + 2) / 12 \
&= ((b - a)(b - a + 2)) / 12
$

#figure(
  image("variance-table.png", width: 90%),
  caption: [
    Variance of Common Distribution
  ],
)

== Conditional PMF, Expectation, and Variance

Just like we conditioned the probability of an _event_ on
_another event_, we can also condition the PMF of a r.v. on an
_event_.

$
p_(X | A) (x) = P(X = x | A) = P({X = x} inter A) / P(A)
$

$
sum_x P_(X | A) (x) = 1
$

$
E[X | A] = sum_x x p_(X | A) (x)
$

$
E[g(x) | A] = sum_x g(x) p_(X | A) (x)
$

_example._

Fair 4-sided die.

#image("conditional-variance-ex.png", width: 40%)

- $E[X] = 1.5$
- $"var"(X) = 1/12 (b - a) (b - a + 2) = 1/12 dot 3 dot 5 = 1.25$

Let $A = {x >= 1}$

- $P(A) = 3/4$

#image("conditional-variance-ex2.png", width: 40%)

- $E[X | A] = 2$
- $"var"(X | A) = 1/12 dot 2 dot 4 = 2/3$

== Total Probability and Total Expectation

Recall $P(B) = sum P(B | A_i)P(A_i)$

$
p_X (x) = sum p_(X | A_i) P(A_i)
$

$
E[X] = sum E[X | A_i] P(A_i)
$

_example._

Compute $E[X]$ for:

#image("total-expect-ex.png", width: 40%)

We could solve it using $E[X] = sum_x x p_X (x)$.

However, notice that this looks like two uniform distributions

$
E[X] = 3/9 dot (2 + 0)/2 + 6/9 dot (8 + 6)/2 = 5
$
