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
  + Non-negativity: $P(A) >= 0$
  + Normalization: $P(Omega) = 1$
  + Additivity: If $A inter B = emptyset$, then $P(A union B) = 
  P(A) + P(B)$

Consequences of the Axioms:

- $P(A) <= 1$

- $P(emptyset) = 0$

- $P(A) + P(A^complement) = 1$

- if $A subset.eq B$, then $P(A) <= P(B)$

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

#image("cards-sample-space.png", width: 70%)

+ Specify the probability law: $1/52$
+ Specify the event of interest: $13/52 = 1/4$

_What is the probability that it is a heart card GIVEN that 
the card is a Jack_

+ Specify the sample space: the four jack cards
+ Specify the probability law: $1/4$
+ Specify the event of interest: (occurs only once) $1/4$

Assume an experiment with 12 equally likely outcomes

#image("conditional-a-b.png", width: 70%)

$
P(A) &= 5/12 \
P(B) &= 6/12
$

If we were told *$B$* occurred...

$ P(A|B) = 2/6 $

== Definition of Conditional Probability

$P(A|B)$ = "Probability of event $A$, *_given that_* event $B$
has occurred"

$ P(A|B) = P(A inter B) / P(B) $

_defined only when $P(B) > 0$_

#image("conditional-intersect.png", width: 70%)

_Example._ Two roll of a die

#image("2-dice-conditional.png", width: 40%)

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
P(B|A) &= P(A inter B) / P(A) \
P(B|A) dot P(A) &= P(A inter B)
$

$P("ECE major" inter "likes donuts") = 0.1 dot 0.7 = 0.07$

- The probability of selecting a student in the UT population
  that is an ECE student _AND_ likes donuts is 7%.

== Total Probability Theorem

- What if I told you that ...
  - On MWF, I eat oatmeal with probability 0.3
  - On TTH, I eat oatmeal with probability 0.4
  - On SAS, I eat oatmeal with probability 0.2
- And asked you ...
  - What is the probability that I eat oatmeal on any given day?

#image("total-probability.png", width: 70%)

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
  - $P("have COVID" | "+ve test")$

#image("total-probability.png", width: 70%)

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

#image("virus-tree.png", width: 30%)

- $P(A inter B) = P(A) P(B | A) = 0.01 dot 0.95 = 0.0095$ 
- $P(B) = P(A) P(B | A) + P(A') P(B | A') = 0.01 dot 0.95
  + 0.99 dot 0.05 = 0.059$
- $P(A | B) = P(A inter B) / P(B) = 0.0095/0.059 = 0.161$

= Independence

If the occurrence of $B$ provides no information that alters
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

Calculate pairwise independence

- $P(A inter B) = 1/4$, $P(A)P(B) = 1/4$
- $P(A inter C) = 1/4$, $P(A)P(C) = 1/4$
- $P(C inter B) = 1/4$, $P(C)P(B) = 1/4$

Calculate triplewise independence

- $P(A inter B inter C) = 0$, $P(A)P(B)P(C) = 1/8$

*NOT INDEPENDENT*, $0 eq.not 1/8$

== Conditional Independence

- Two events $A$ and $B$ are *conditionally independent* given an event $C$, if

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
- Then $P(A) = k/n$

== The Counting Principle

If you have a menu with 3 appetizers, 4 entrees, and 2 desserts,
how many distinct meals you can put together?

$
3 dot 4 dot 2 = 24
$

_example._

Number of license plates of 2 letters followed by 4 digits

- Repetition allowed: $26^2 dot 10^4$
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
""_n P_k = n! / (n - k)!
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

#image("random-mapping.png", width: 90%)

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
  table.header[$x$][$p_X (x)$],
  [0],[1/4],
  [1],[1/2],
  [2],[1/4],
)

== Properties of the PMF

- $p_X (x) >= 0$  (Non-negativity axiom)
- $sum_x p_X (x) = 1$ (Normalization axiom)
- $P(X = a union X = b) = p_X (a) + p_X (b)$ (Additivity axiom)
- $P(a <= X <= b) = sum_(x: a <= x <= b) p_X (x)$ (Additivity axiom)

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
E[X^2] &= "var"(X) + (E[X])^2
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

= Multiple Random Variables

In real life we often care about the probability of a random
variable conditioned on another random variable.

== Joint PMFs

- Let $X$ be an r.v. with PMF $p_X (x)$ and $Y$ be an r.v. with
  PMF $p_Y (y)$
- How can we compute the probability of an event like, say,
  $X = Y$
- We need to define a _joint PMF_, i.e., $p_(X,Y) (x,y) = P
  (X = x inter Y = y)$
  - Say we were given $X$ and $Y$ are independent,
    $p_(X,Y) (x,y)= P_X (x) dot P_Y (y)$

_example._ Roll two _biased_ 4-sided die.

#image("joint-pmf.png", width: 50%)

- $p_(X, Y) (1,3) = 2/20$
- $p_X (4) = 1/20 + 2/20$
- $p_Y (2) = 1/20 + 3/20 + 1/20$
- $p_(X, Y) ({X = Y}) = 1/20 + 1/20$

*Properties of joint PMFs*

$
sum_x sum_y p_(X, Y) (x, y) = 1 \
p_X (x) = sum_y p_(X, Y) (x,y) \
p_Y (y) = sum_x p_(X, Y) (x,y)
$

_the last two are called the *Marginal PMFs*_

#pagebreak()

== Expectation of the Sum of Random Variables

$
E[X + Y] = E[X] + E[Y]
$

_note._ $X$ and $Y$ *DO NOT* need to be independent. This
property is true because of the _linearity of expectation._

_example._ Mean of the Binomial r.v.

- Let $X$ be a binomial r.v., i.e. $X = $ the number of
  successes in $n$ independent trials, and where the
  probability of success for each trial is $p$.
- To compute $E[X]$
- We define $X_i$ as the random variable associated with the
  $i$th trial
  - $X_i = 1$ if the $i$th trial is a success, and $X_i = 0$ otherwise
- Note that $X_i$ is a Bernoulli r.v., and $E[X_i] = p$
- $X = X_1 + X_2 + dots + X_n$, i.e., the total number of successes

$
E[X] &= E[X_1 + X_2 + dots + X_n] \
&= E[X_1] + E[X_2] + dots + E[X_n] \
&= p + p + dots + p \
&= n p
$

== Conditional PMF

Recall: $p_(X | A) (x) = P(X = x | A)$

Conditional PMF conditioned on a r.v.:

$
p_(X | Y) (x | y) &= P(X = x | Y = y)  \
&= P(X = x inter Y = y) / P(Y = y) \
&= (p_(X, Y) (x,y)) / (p_Y (y))
$

== Conditional Expectation

Recall: $E[X | A] = sum_x x p_(X | A) (x)$

Conditional Expectation conditioned on a r.v.:

$
E[X | Y = y] = sum_x x p_(X | Y) (x | y)
$

Expected Value Rule:

$
E[g(X) | Y = y] = sum_x g(x) p_(X | Y) (x | y)
$

== Total Probability and Expectation Theorems

*Total Probability*

Recall: $p_X (x) = p_(X | A_1) P(A_1) + dots$

$
p_X (x) = sum_y p_(X | Y) (x | y) p_Y (y)
$

*Total Expectation*

Recall: $E[X] = sum_i^n E[X | A_i] P(A_i)$

$
E[X] = sum_y E[X | Y = y] p_Y (y)
$

== Independence of Random Variables

Recall independence of two events: $P(A inter B) = P(A) P(B)$

Independence of two r.v.s

$
P(X = x inter Y = y) = P(X = x) P(Y = y), "for all" x, y \
p_(X, Y) (x,y) = p_X (x) p_Y (y), "for all" x, y
$

Also,

$
p_(X | Y) (x|y) = p_X (x) \
p_(Y | X) (y|x) = p_Y (y)
$

== Independence and Conditional Independence

#image("2rv-independence.png", width: 70%)

If $X$ and $Y$ are independent,

$
E[X Y] = E[X] E[Y]
$

$
"var"(X + Y) = "var"(X) + "var"(Y)
$

= Continuous Random Variables

*Discrete vs. Continuous*

#image("discrete-rv.png", width: 40%)
#image("continuous-rv.png", width: 40%)

This is called a *Probability Density Function* denoted with
$f_X (x)$

- $P(a <= X <= b) = integral_a^b f_X (x) dif x$
- $f_X (x) >= 0$
- $integral_(- infinity)^infinity f_X (x) dif x = 1$

== Expectation of Continuous R.V.s

$
E[X] = integral_(- infinity)^infinity x f_X (x) dif x
$

== Variance of Continuous R.V.s

$
"var"(X) = integral_(- infinity)^infinity (x - mu)^2 f_X (x) dif x
$

== Uniform Continuous R.V.

#image("uniform-continuous.png", width: 40%)

$
f_X (x) = cases(
  1/(b - a) &"if" a <= x <= b ,
  0 &"if" x < a "or" x > b
)
$

== Exponential R.V.

$
f_X (x) = cases(
  lambda e^(- lambda x) &"if" x >= 0,
  0 &"if" x < 0
)
$

Probability of waiting longer than $a$:

$
P(X >= a) = integral_a^infinity lambda e^(- lambda x) dif x = e^ (-lambda a)
$

Expected value:

$
E[X] &= integral_0^infinity x lambda e^(- lambda x) dif x = 1 / lambda \
E[X^2] &= integral_0^infinity x^2 lambda e^(- lambda x) dif x = 2 / lambda^2 \
$

Variance:

$
"var"(X) = E[X^2] - (E[X])^2 = 1/lambda^2
$

= Normal Random Variable

== Standard Normal Random Variable

The *Standard Normal R.V.* has parameters: $mu = 0, sigma^2 = 1$.

$
f_X (x) = 1/sqrt(2 pi) e^(- x^2 / 2)
$

It can also be represented as $N(0, 1)$ where the first term
is $mu$ and the second term is $sigma^2$

#image("standard-normal-dist.png", width: 70%)

$
E[X] = integral_(- infinity)^infinity x 1/sqrt(2 pi) e^(- x^2 / 2) dif x = 0
$

_Notice that it's symmetrical centered at 0_

$
"var"(X) = integral_(- infinity)^infinity x^2 1/sqrt(2 pi) e^(- x^2 / 2) dif x = 1
$

== General Normnal Random Variable

The *General Normal R.V.* is defined by $N(mu, sigma^2)$

$
f_X (x) &= 1/(sigma sqrt(2 pi)) e ^(- (x - mu)^2 / (2 sigma^2)) \
E[X] &= mu \
"var"(X) &= sigma^2
$

== Linear Functions of Normal Random Variables

$
Y &= a X + b \
E[Y] &= a mu + b \
"var"(Y) &= a^2 sigma^2
$

Another important non-trivial property is that,

If $X$ is normal, then $Y = a X + b$ is also normal.

== Cumulative Distribution Function (CDF)

CDF is defined by $F_X (x)$ which is different from PDF $f_X (x)$.

For a discrete r.v.

$
F_X (x) = sum_(k <= x) p_X (k)
$

For a continuous r.v.

$
F_X (x) = integral_(- infinity)^x f_X (t) dif t
$

The _derivative_ of the CDF is the PDF:

$
(dif F_X (x)) / (dif x) = f_X (x)
$

== Standardization of non-Standard Normal R.V.s

$
Y = (X - mu) / sigma = (1 / sigma) X - mu / sigma
$

_example._ The weight of a FedEx package is known to be
a Normal r.v. with mean of 6 lbs, and a std. dev. of 2 lbs.

What is the probability that a package will weight between 2
and 8 pounds.

$
X ~ N(6, 4) \
P(2 <= X <= 8)
$

Define 

$
Y = (X - 6) / 2
$

_This is the z-score, AKA number of S.D.s away from the mean_

$
&P((2 - 6)/2 <= (x - 6)/2 <= (8 - 6)/2) \
&= P(-2 <= y <= 1) \
&= F_Y (1) - F_Y (-2) \
&= 0.8185
$

= PDFs of Random Variables

If a r.v. $Y$ is defined as a function of $X$, i.e., $Y = g(X)$,
we can use the _Expected Value Rule_ to determine $E[Y]$, without
finding $f_Y (y)$.

- But to find the probability, say, $P(Y >= 0) = integral_0
  ^infinity f_Y (y) dif y$, we need to find $f_Y (y)$.
- For example, if $X = U_C (0, 1)$, and $Y = X^2$, we need
  $f_Y (y)$ to find $P(Y >= 0.5)$

== Linear Function of a Discrete R.V.

Consider the following $p_X (x)$

#image("linear-discrete.png", width: 70%)
#image("linear-discrete-2.png", width: 70%)
#image("linear-discrete-3.png", width: 70%)

- $Z = 2X + 3$
- $g(x) = 2x + 3$

Notice that for a function, $Z = g(X)$, the probability 
themselves don't change. (Look at the heights of the graphs).

$
p_Z (z) = p_X (g^(-1) (z))
$

== Linear Function of a Continuous R.V.

Consider the following continuous r.v. and its transformation

$
Z = 2X + 3
$

#image("linear-continuous.png", width: 100%)

- $Y = a X + b$, where $a > 0$
- To determine $f_Y (y)$, we use a three step procedure:

+ Find the CDF of $Y$, i.e., $F_Y (y) = P(Y <= y)$
+ Take the derivative: $f_Y (y) = (dif F_Y (y)) / (dif y)$
+ Given the range of $X$, find the range of $Y$

- For a linear function case where $Y = a X + b$,

+ $F_Y (y) = P(Y <= y) = P(a X + b <= y) = P(X <= (y - b) / a) = F_X ((y-b)/a)$
+ Take the derivative w.r.t. $y$: $f_Y (y) = f_X ((y-b)/a) (1/abs(a))$

$
f_Y (y) = f_X (g^(-1)(y))(1/abs(a))
$

== Linear Function of a Normal r.v.

Let $X = N(mu, sigma^2)$, and $Y = a X + b$

$
f_X (x) = 1/(sigma sqrt( 2 pi)) e^(- (x - mu)^2 / (2 sigma^2))
$

== Non-Linear Function

$
Y = X^3
$

- $F_Y (y) = P(Y <= y)$
- $F_Y (y) = P(X^3 <= y)$
- $F_Y (y) = P(X <= y^(1/3))$
- $F_Y (y) = F_X (y^(1/3))$

_example._ $X$ is uniform on 0-5

- $F_Y (y) = 1/5 y^(1/3)$
- $f_Y (y) = 1/15 y^(-2/3)$

$
f_Y (y) = cases(
  1/15 y^(-2/3) &"if" &0 <= y <= 125,
  0 &"if" &"otherwise"
)
$

== Any Monotonic Function

Consider a function $Y = g(x)$ that is continuous, strictly
monotonic, and increasing

$
g'(x) > 0 "for all" x
$

$
f_Y (y) = f_X (h(y)) abs((dif h(y))/(dif y))
$

= Sum of Two Random Variables

== Sum of Two Independent Discrete R.V.s

_example._

$
X &= {0, 1, 2, 3} \
Y &= {0, 1, 2, 3} \
Z &= X + Y
$

If these were both uniform r.v.s,

#image("sum-discrete.png", width: 40%)

$
p_Z (3) &= P(X = 0, Y = 3) + P(X = 1, Y = 2) + P(X = 2, Y = 1) + P(X = 3, Y = 0) \
&= p_X (0) p_Y (3) + p_X (1) p_Y (2) + p_X (2) p_Y (1) + p_X (3) p_Y (0) \
&= sum^3_(x = 0) p_X (x) p_Y (3 - x)
$

$
p_Z (z) = sum_x^z p_X (x) p_Y (z - x)
$

_note._ Notice that one index $p_X$ climbs up, while the other,
$p_Y$ climbs down. This is called *Convolution*

== Sum of Two Independent Continuous R.V.s

$
f_Z (z) = integral^infinity_(x = - infinity) f_X (x) f_Y (z - x) dif x
$

= Covariance and Correlation

== Covariance

Let $X$ and $Y$ be random variables with zero-means:
$mu_x = 0$, $mu_y = 0$

- If $X$ and $Y$ are independent, $E[X Y] = E[X] E[Y]$

= Total Expectation and Total Variance

== $E[X | Y]$ as a Function of a R.V.

_example._ *Coin Factory Problem*

- Unfair coin, with $P["Heads"] = p$
- Let $X$ be a random variable, $X$ = number of Heads in $n$ coin tosses
- $X$ has a Binomial PMF
- Recall that with a binomial PMF with success probability $p$, $E[X] = n p$
- What if $p$ is also a random variable, $Y$?
- Then the number of Heads is a function of a random variable $Y$
- The *Conditional Expectation* $E[X|Y] = n Y$
- We can treat $E[X | Y]$ as a function of the random variable $Y$
- $g(Y) = E[X | Y] = n Y$
- Since it is a r.v., it has an expectation $E[E[X | Y]]$ and a variance

Recall the *Total Expectation Theorem*

$
E[X] = integral_(- infinity)^infinity E[X | Y = y] f_Y (y) dif y
$

But using the expected value rule,

$
E[E[X | Y]] &= integral_(- infinity)^infinity E[X | Y = y] f_Y (y) dif y \
&= E[X]
$

*"Law of Iterated Expectations"*

_example._ *Coin Factory Problem* continued...

- Let the $Y = P("Heads")$ be uniform on $[0.6, 0.7]$
- $E[X] = E[E[X | Y]] = E[n Y] = n E[Y]$
- $E[Y] = 0.65$
- $E[X] = 100 dot 0.65 = 65$

== Conditional Variance

- Recall: Variance $"var"(X) = E[X^2] - (E[X])^2$
- If $X$ is dependent on $Y$, we define the *Conditional Variance:*

$
"var"(X | Y) = E[X^2 | Y] - (E[X | Y])^2
$

- Recognize that Conditional Variance $"var"(X | Y = y)$ is also a function
  of $Y$
- Now, define $"var"(X | Y)$ as a random variable, which is a function
  of the r.v. $Y$
- $h(Y) = "var"(X | Y)$
- Since it is an r.v., it has an expectation $E["var"(X | Y)]$

$
"var"(X) = E["var"(X | Y)] + "var"(E[X | Y])
$

_proof._

$
"var"(X | Y) &= E[X^2 | Y] - (E[X | Y])^2 \
E["var"(X | Y)] &= E[X^2] - E[(E[X | Y])^2] \
"var"(E[X | Y]) &= E[(E[X | Y])^2] - (E[E[X | Y]])^2 \ 
E["var"(X | Y)] + "var"(E[X | Y]) &= E[X^2] - (E[X])^2 \
&= "var"(X)
$

== Sum of a Random Number of Independent R.V.s

- You visit $N$ stores, where $N$ is a random number
- Money spent at store i = $X_i$, where $X_i$s are independent and identically
  distributed (i.i.d.) random variables, and independent of $N$
- So, the total amount of money spent is $Y = X_1 + X_2 + dots + X_N$

$
E[Y | N = n] &= E[X_1 + X_2 + dots + X_n] = n E[X], "for all" n \
E[Y | N] &= N E[X]
$

- Use law of iterated expectations

$
E[Y] = E[E[Y | N]] = E[N E[X]] = E[N] E[X]
$

_example._ *Black Friday Problem*

- The number of stores $N$ is $U_D (10, 20)$
- The money you spend at store i is, $X_i ~ U_C (50, 150)$
- If $X$ is the total amount of money spent, find $E[X]$ and $"var"(X)$

$
E[X] = E[N] E[X] = 15 dot 100 = 1500
$

= Probability Bounds

- Sometimes we may not know enough about a random variable
- We may not know the PDF, but instead we may only have _estimates_ of
  - the mean
  - the variance

So, we can't calculate exact probabilities, but can we at least come up
with a *bound* for the probabilities?

*Probability Bounds*

- Markov Bound
- Chebyshev Bound

== Markov Bound

- We have a random variable $X$ that takes only non-negative values
- All we know about it is the value of the Mean, or $E[X]$
- What is the probability that $X$ is greater than a large value $a$?

$
"if" X >= 0 "and" a > 0 ", then" P(X >= a) <= E[X]/a
$

_proof._

$
E[X] = integral_0^infinity x f_X (x) dif x quad &>= quad integral_a^infinity x f_X (x) dif x quad &>= quad integral_a^infinity a f_X (x) dif x quad = quad a P(X >= a)\
$
$
P(X <= a) <= E[X] / a
$

_So how good is the Markov Bound?_

- $E[X] = 5$
- Let's say we want to compute $P(X >= 9)$
- Use Markov bound, set $a = 9$
- The Markov bound tells us that $P(X >= 9) <= E[X] / 9 = 5/9$

Let's test it on a simple example.

- Let $X$ be a uniform r.v. on $[0,10]$
- We know that $P(X >= 9) = 1/10$

$
1/10 <= 5/9
$

#pagebreak()

== Chebyshev Bound

- In addition to the mean, what if we also know the *variance* of $X$?
- What can we say about the probability that $X$ is far from the mean?

$
P(abs(X - mu) >= c) <= sigma^2/c^2 "for all" c > 0
$

_proof._

$
P(abs(X - mu) >= c) = P((X - mu)^2 >= c^2)
$

Use the Markov bound, with $a = c^2$

$
P((X - mu)^2 >= c^2) <= E[(X - mu)^2]/c^2 = sigma^2/c^2
$
$
P(abs(X - mu) >= c) <= sigma^2/c^2
$

_So how good is the Chebyshev Bound?_

Same example,

- $X$ is a uniform r.v. on $[0,10]$
- $mu = 5$ and $sigma^2 = 10^2/12 = 100/12 = 8.33$
- Let's say we want to compute $P(X <= 1) + P(X >= 9)$, so $c = 4$

$
P(abs(X - 5) >= 4) <= sigma^2/c^2 = 8.3/16 = 0.52
$

$
P(X <= 1) + P(X >= 9) = 1/10 + 1/10 = 0.2
$

= Weak Law of Large Numbers

- Consider a random variable $X$, with $E[X] = mu$, and $"var"(X) = sigma^2$
- You make $n$ independent observations of this r.v. $X_1, X_2, dots , X_n$
- $X_1, X_2, dots, X_n$ are *i* ndependent, *i* dentically *d* istributed (i.i.d.)
  random variables

Examples:

- Lab measurement of voltage
- Quality metric of a product, e.g., turn-on time of an iPhone
- Polling of a sample population

The sample mean $M_n$ is defined as 

$
M_n = (X_1 + X_2 + dots + X_n) / n
$

$
M_n -> E[X] "as" n -> infinity
$

_proof._

$
E[M_n] = E[(X_1 + X_2 + dots + X_n) / n] = 1/n (E[X_1] + E[X_2] + dots + E[X_n]) = 1/n n mu = mu
$

Now look at variance of $M_n$

$
"var"(M_n) = "var"((X_1 + X_2 + dots + X_n) / n) = ("var"(X_1) + "var"(X_2) + dots + "var"(X_n))/n^2 = (n sigma^2)/n^2 = sigma^2 / n
$

Apply Chebyshev Bound

$
P(abs(M_n - mu) >= epsilon) <= sigma^2/(n epsilon^2) "for any" epsilon > 0 "and" sigma^2/(n epsilon^2)
$

== Polling Problem

- Let's say we poll a population sample of $n$ people about a candidate
- Let the "true" probability of the candidate be $p$, which is unknown
- We create a Bernoulli r.v. $X_i$ by assigning

$
X_i = cases(
  1 "if the ith person sampled likes the candidate",
  0 "if the ith person sampled does not like the candidate"
)
$

- Therefore, $p_X_i (1) = p$, and $p_X_i (0) = 1 - p$
- From Bernoulli r.v.s, we know that $E[X_i] = p$, and $"var"(X_i) = p(1 - p)$
- We can then create an estimate of the popularity of the candidate by
  computing the sample mean

$
M_n = (X_1 + X_2 + dots + X_n) / n
$

_So how close can we get to the real number? $n$_

$
E[M_n] = (n E[X])/n = p
$

$
"var"(M_n) = (n "var"(X))/n^2 = (p (1 - p))/n
$

- The Weak Law of Large Numbers tells us that as $n -> oo$, $M_n -> p$
- But how large does $n$ need to be for $M_n$ to get "close to" $p$
- Say we wanted $M_n$ to be within 3% of the actual $p$ with at least 95%
  probability

$
P(abs(M_n - p) <= 0.03) >= 0.95
$

Recall the Chebyshev form,

$
P(abs(X - mu) >= c) <= sigma^2/c^2
$

$
P(abs(M_n - p) <= 0.03) &>= 0.95 \
1 - P(abs(M_n - p) <= 0.03) &<= 1 - 0.95 \
P(abs(M_n - p) >= 0.03) &<= 0.05
$

Substitute

$
mu &= p \
sigma^2 &= (p (1 - p)) / n \
c &= 0.03
$

This gives us,

$
P(abs(M_n - p) >= 0.03) &<= ((p (1 - p))/ n)/0.03^2 \
P(abs(M_n - p) >= 0.03) &<= 0.05 \
P(abs(M_n - p) >= 0.03) &<= ((p (1 - p))/ n)/0.03^2 <= 0.05\
$

$
((p (1 - p))/ n)/0.03^2 &<= 0.05 \
n &>= 22222 p(1 - p)
$

_note._ Our answer for $n$ still depends on the unkown $p$.

#image("p1p.png", width: 70%)

$
n >= 22222 dot 0.25 = 5556
$

= The Central Limit Theorem

Recall:

$
M_n &= (X_1 + X_2 + dots + X_n) / n \
E[M_n] &= mu \
"var"(M_n) &= sigma^2/n
$

*Define $Z_n$ as the "standardized" form of $M_n$*

$
Z_n = (M_n - mu) / (sigma / sqrt(n))
$

$
E[Z_n] &= 0 \
"var"(Z_n) &= 1
$

If $X_1, X_2, dots, X_n$ are i.i.d. r.v.s, and $Z_n = (X_1 + X_2 + dots + X_n - n mu) / (sigma sqrt(n))$

$
F_Z (z) = integral_(-oo)^z 1 / sqrt(2 pi) e ^(- x^2 / 2) dif x
$

_example._ *Package Loading*

We want to load 100 packages on a plane, and the weight of each package is a
continuous r.v. uniformly distributed between 5 and 50 lbs

What is the probability that the total weight exceeds the capacity of the
plane, which is 3000 lbs?

Without the CLT, we would need to convolve the uniform distribution 99 times,
to find the combined PDF, and then compute the probability

100 > 30, assume normal.

For each package $X_i$

$
mu &= 27.5 \
sigma^2 &= 168.75
$

We want to compute: $P(S_100 > 3000)$

$
P(S_100 > 3000) &= P((S_100 - n mu) / (sqrt(n) sigma) > (3000 - n mu)/(sqrt(n) sigma)) \
&= P(Z_100 > 1.92)
$

= Bayesian Inference

#image("bayesian.png", width: 70%)

- Assumption: _a priori_ probability model of input: $P(X)$
- Knowledge: Process model, i.e. $P(Y | X)$
- Observation: $Y$
- Inference: _a posteriori_ probability model of the input
  $P(X | Y)$

_example._ *Virus Testing*

- Assumption: $P(X)$: Infection rate
  - 5% of population is infected (we don't know who)
- Knowledge: $P(Y | X)$: Test accuracy
  - Prob(person *with* the infection will test positive) = 99%
  - Prob(person *without* the infection will test positive) = 3%
- Observation: $Y$: test result: positive or negative
- Inference: $P(X | Y)$: How sure are we of result?
  - Given that the test is positive, does the person really have the infection?

== Bayesian Inference Process

Recall Bayes' Rule when both the observation and inference are
* _events_ *:

$
P(A_i | B) = (P(A_i)P(B | A_i))/ (sum_j P(A_j)P(B | A_j))
$

== Point Estimates

- The output of the Bayes Inference process is the _a posteriori
  *probability model*_ for the input: $p_(X|Y) (x | y)$ or $f_(X|Y) (x|y)$

- But it is more meaningful to create an *estimate $hat(x)$ of
  the input* given a specific observation $y$,

  $
  hat(x) = f(y)
  $

- This is known as the _ *point estimate*_

- Two types of point estimators:
  - Maximum a posteriori probability (MAP): $hat(x) = "max"_x P_(X | Y) (x|y)$
  - Least Mean Squared Error (LMS): $hat(x) = E[X | Y]$

== Continuous $X$, Continuous $Y$

- The input $X$ can take an infinite number of continuous values with $f_X (x)$
- The output $Y$ can take an infinite number of continuous values
- We know the probability law that maps $X$ to $Y$: $f_(Y|X) (y|x)$
- Use this variant of Bayes' rule:

$
f_(X|Y) (x|y) = (f_X (x) f_(Y|X) (y|x))/(integral_(-oo)^(oo) f_X (t) f_(Y|X) (y|t) dif t)
$

#image("cont-cont.png", width: 50%)

#show math.equation: set text(fill: blue)
$
hat(x) = "max"_x f_(X|Y) (x|y)
$


#show math.equation: set text(fill: green)
$
hat(x) = E[X|Y]
$

#show math.equation: set text(fill: black)

== Discrete $X$, Discrete $Y$

= Finite-State Markov Chains

A _ *random process*_ is a probabilistic experiment that
_evolves in time_, and generates a _sequence of outcomes_.

- this sequencing is what makes it a *process*

Examples:

- stock market (over many days)
- weather pattern
- data packet arrival in a computer network
- gambler's stash of chips as he plays blackjack

A *random variable* is a snapshot of a *random process* at some
moment in time.

- *Bernoulli Process* - discrete inter-arrival time based on
  geometric r.v.
- *Poisson Process* - continuous inter-arrival time based on
  exponential r.v.
- *Markov Process* - future is dependent _ *ONLY*_ on the
  current state.

#image("checkout-counter.png", width: 70%)

== Definitions

- State $X_n$: Number of customers at time $n$
- $X_n$ belongs to a _ *finite set*_ $S = {0, 1, 2, dots , m - 1}$. $m = 6$ in our example
- Transition probability $p_(i j) = P(X_(n + 1) = j | X_n = i)$
- In our example,
  $

  $
- For a Markov model you only need to know
  - States
  - State transitions
  - State transition probabilities

== Properties

+ Transition probability _ *only depends on the current state*_, and _ *does not depend on previous history*_, i.e., how the current state is reached
+ The sum of all probabilities _ *exiting*_ a state is 1.
  $
  sum_(j = 1)^m p_(i j) = 1
  $
+ Probability of _ *entering*_ any state is given by the weighted sum of the arcs
  $
  P(X_(n + 1) = j) = sum_(i = 1)^m p_(i j) P(X_n = i)
  $

