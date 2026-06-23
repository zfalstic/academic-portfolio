#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW3"
#let author = "Dawson Zhang" 
#let collaborators = []
#let course-id = "ECE 351K: Probability and Random Processes"
#let instructor = "Prof. Vivek Telang"
#let semester = "Summer 2026"
#let due-time = ""

#show: homework.with(
  title: title,
  author: author,
  collaborators: collaborators,
  course-id: course-id,
  instructor: instructor,
  semester: semester,
  due-time: due-time,

  // Optional setting to change the paper size depending on region
  // (Defaults to A4)
  // paper-size: "us-letter", 
)

// Numbering
#set enum(numbering: "a)")

// Enable to get a latex-like look
// #set text(font: "New Computer Modern")

// #prob(title: "", color: green)[content goes here]
// Default color is green, can be changed to black if you want to print
// Note that title is optional, it can be removed if you just don't set it to anything (just do #prob[content])

#let blank(width) = box(width: width, stroke: (bottom: 0.5pt), inset: (bottom: 2pt))

#prob(title: "Bayes Rule and Independence")[
A campus computer lab buys laptops from two
suppliers. Supplier A provides 80% of the laptops and Supplier B provides the remaining
20%. A laptop from Supplier A needs a repair within the first year with probability 0.05,
while a laptop from Supplier B needs a repair within the first year with probability 0.20. A
laptop is chosen at random.

+ Given that the chosen laptop needed a repair within its first year, what is the
  probability it came from Supplier B?
+ Let $R$ be the event that the laptop needs a repair within its first year, and let $A$ be the
  event that it came from Supplier A. Calculate $P(R inter A)$. Are events $R$ and $A$
  independent?
]

+ We need to find $P(A' | R)$

  $
  P(A' | R) &= P(A' inter R) / P(R) \
  &= (P(A') P(R | A')) / (P(A') P(R | A') + P(A) P(R | A)) \
  &= (0.2 dot 0.2) / (0.2 dot 0.2 + 0.8 dot 0.05) \
  &= 0.5
  $

+ Find $P(R inter A)$

  $
  P(R inter A) &= P(A) P(R | A) \
  &= 0.8 dot 0.05 \
  &= 0.04
  $

  There are a couple of ways to show independence. Consider
  the multiplication rule.

  Independent if and only if $P(R) dot P(A) = P(R inter A)$

  - From part a), $P(R) = 0.2 dot 0.2 + 0.8 dot 0.05 = 0.08$
  - $P(A) = 0.8$

  $P(R) dot P(A) = 0.064 eq.not 0.04 => "not independent"$

#pagebreak()

#prob(title: "Independence")[
You roll a 6-sided die two times and define the following events:

- Event $A$: the first roll is an even number.
- Event $B$: the sum of the two rolls is 7.

+ Calculate $P(A)$, $P(B)$, and $P(A inter B)$. Are events
  $A$ and $B$ independent?
+ Now define Event $C$: the sum of the two rolls is 8. Calculate
  $P(C)$ and $P(A inter C)$. Are events $A$ and $C$ independent?
]

+ Find $P(A)$
  - $Omega_("first roll") = {(1, X), (2, X), (3, X), (4, X), (5, X), (6, X)}$
  - $A = {(2, X), (4, X), (6, X)}$
  - $P(A) = 1/2$

  Find $P(B)$
  #table(
    columns: 6,
    [$1,1$],[$1,2$],[$1,3$],[$1,4$],[$1,5$],[$1,6$],
    [$2,1$],[$2,2$],[$2,3$],[$2,4$],[$2,5$],[$2,6$],
    [$3,1$],[$3,2$],[$3,3$],[$3,4$],[$3,5$],[$3,6$],
    [$4,1$],[$4,2$],[$4,3$],[$4,4$],[$4,5$],[$4,6$],
    [$5,1$],[$5,2$],[$5,3$],[$5,4$],[$5,5$],[$5,6$],
    [$6,1$],[$6,2$],[$6,3$],[$6,4$],[$6,5$],[$6,6$],
  )

  - $B = {(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)}$
  - $P(B) = 1/6$
  
  Find $P(A inter B)$

  - $A inter B = {(2,5),(4,3),(6,1)}$
  - $P(A inter B) = 1/12$

  Independence?

  $
  P(A) dot P(B) &= P(A inter B) \
  1/2 dot 1/6 &= 1/12 \
  1/12 &= 1/12
  $

  _Independent._

+ Find $P(C)$
  
  #table(
    columns: 6,
    [$1,1$],[$1,2$],[$1,3$],[$1,4$],[$1,5$],[$1,6$],
    [$2,1$],[$2,2$],[$2,3$],[$2,4$],[$2,5$],[$2,6$],
    [$3,1$],[$3,2$],[$3,3$],[$3,4$],[$3,5$],[$3,6$],
    [$4,1$],[$4,2$],[$4,3$],[$4,4$],[$4,5$],[$4,6$],
    [$5,1$],[$5,2$],[$5,3$],[$5,4$],[$5,5$],[$5,6$],
    [$6,1$],[$6,2$],[$6,3$],[$6,4$],[$6,5$],[$6,6$],
  )

  - $C = {(2, 6), (3, 5), (4, 4), (5, 3), (6, 2)}$
  - $P(C) = 5/36$
  
  Find $P(A inter C)$

  - $A inter C = {(2,6),(4,4),(6,2)}$
  - $P(A inter C) = 1/12$

  Independence?

  $
  P(A) dot P(C) &= P(A inter C) \
  1/2 dot 5/36 &eq.not 1/12
  $

  _Not Independent._

#prob(title: "Permutations and Combinations")[
  Consider each of the following scenarios.

  + You are generating product serial codes, where each code consists of 3 distinct letters
    (A–Z) followed by 5 digits (0–9) that are allowed to repeat. How many unique serial
    codes are possible? 
  + You are assembling gift boxes from a collection of 15 unique toys, placing 4 toys in
    each box. How many ways can you fill the first box you prepare? How many ways
    for the second box? 
]

+ The problem tells us that the letters are distinct while the
  digits are allowed to repeat.

  $
  26 dot 25 dot 24 dot 10^5 = 1,560,000,000
  $

+ The difference between the first and second box is just that
  after the first 4 are placed in the first box, there are only
  11 remaining toys to be put into the second box.

  In our case of putting toys into boxes, the order of the toys
  in the boxes doesn't matter so we are dealing with a
  combination question.

  $
  vec(15, 4) = 1,365
  $

  $
  vec(11, 4) = 330
  $

  How many different ways could we arrange the first and
  second boxes?

  $
  1,365 dot 330 = 450,450
  $

#pagebreak()

#prob(title: "Probability Mass Function and Expectation")[
  The number of times a student visits
  the campus gym in a week, X, is a random variable with the PMF below.

  $
  p_X (x) = a dot x, "for" x = 1, 2, 3, 4, 5, "and" p_X (x) = 0 "otherwise"
  $

  + Find the value of $a$.
  + Find the expected number of gym visits per week, $E[X]$
]

+ Find $a$ using total probability

  $
  1a + 2a + 3a + 4a + 5a &= 1 \
  15a &= 1 \
  a &= 1/15
  $
+ Now we have our full PMF picture, $p_X (x) = 1/15 x$

  $
  E[X] &= sum_x x p_X (x) \
  &= sum_x 1/15 x^2 \
  &= 1/15 (1 + 4 + 9 + 16 + 25) \
  &= 3.67
  $
