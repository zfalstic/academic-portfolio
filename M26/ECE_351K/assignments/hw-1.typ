#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW1"
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

#prob(title: "Set Relationships and Operations")[
  Fill in the blanks using the following word bank.

  Subset, Equal, Universal, Complement, Union, Intersection,
  Disjoint, Partition

  + Two events that share no outcomes in common are #blank(2cm).
  + Set C, which contains every element that belongs to set A,
    to set B, or to both, is the #blank(2cm) of sets A and B.
  + If every element of A also belongs to B, then A is a #blank(2cm)
    of B; if in addition every element of B belongs to A, the two
    sets are #blank(2cm).
  + The #blank(2cm) set contains every outcome that can occur in
    a space.
  + The #blank(2cm) of a set with its own complement is the empty set.
  + The set of all outcomes in the space that do not belong to set A
    is the #blank(2cm) of set A.
  + Sorting all students in a class into the groups "passed" and
    "failed" forms a #blank(2cm) of the class.
]

+ Two events that share no outcomes in common are *Disjoint*.
+ Set C, which contains every element that belongs to set A,
  to set B, or to both, is the *Union* of sets A and B.
+ If every element of A also belongs to B, then A is a *Subset*
  of B; if in addition every element of B belongs to A, the two
  sets are *Equal*.
+ The *Universal* set contains every outcome that can occur in
  a space.
+ The *Intersection* of a set with its own complement is the empty set.
+ The set of all outcomes in the space that do not belong to set A
  is the *Complement* of set A.
+ Sorting all students in a class into the groups "passed" and
  "failed" forms a *Partition* of the class.

#prob(title: "Set Algebra")[
  Show that both parts are true using algebraic properties 
  (set identities). State each property as you use it.

  + $A inter (B union C) = (A inter B) union (A inter C)$
  + $(A union B)^complement = A^complement inter B^complement$
]

+ Solve by distributing $A inter$ over $B union C$.

  $A inter (B union C) = (A inter B) union (A inter C)$

+ Solve by applying DeMorgan's Law

  $(A union B)^complement = A^complement inter B^complement$

#prob(title: "Sum of Series and Integration Review")[
  Evaluate each expression and show work for full credit. 
  Write the name of a property whenever you use one.

  + $integral_0^infinity 4 x e^(-x/2) dif x$
  + $sum_(n = 1)^infinity (2/3)^n + sum_(n = 0)^infinity (1/5)^n$
  + $1 + 3 + 9 + 27 + 3^(10)$
  + $14 + 17 + 20 + 23 + dots + 89$
]

+ Pick $u = 4x, dif v = e^(-1/2 x)$. First take derivatives
  till zero.

  $
  u &= 4x \
  u' &= 4 \
  u'' &= 0
  $

  Then, take the same number of integrals.

  $
  dif v &= e^(-1/2 x) \
  v &= -2e^(-1/2 x) \
  integral v &= 4 e^(-1/2 x)
  $

  Match terms using the table method and solve.

  $
  integral_0^infinity 4 x e^(-x / 2) dif x &= u v - u' integral v \
  &= -8 x e^(-1/2 x) - 16 e^(-1/2 x) \
  &= lr(-8 x e^(-1/2 x) - 16 e^(-1/2 x) |)_0^infinity \
  &= 0 - (-8(0) - 16) \
  &= 16
  $

+ Simplify both summations as geometric series and add.

  $
  sum_(n = 1)^infinity (2/3)^n = (2/3)/(1 - 2/3) = (2/3)/(1/3)
  &= 2 \
  sum_(n = 0)^infinity (1/5)^n = (1)/(1 - 1/5) = (1)/(4/5)
  &= 5/4 \
  2 + 5/4 = 13/4
  $

+ Apply finite geometric series properties.

  $
  sum_(k = 0)^n r^k = (r^(n+1) - 1)/(r-1), r=3, n=10
  $

  $
  (3^(11) - 1)/(3 - 1) = (177147 - 1)/(3 - 1) = 88573
  $

+ Apply arithmetic series properties.

  $
  S_n = n/2(a_1 + a_n)
  $

  We know that $14$ is the first term and $89$ is the last term.
  Therefore, the difference divided by $3$, $(89 - 14)/3 = 75/3
  = 25$ is the amount of terms after the first term where $89$
  occurs. Thus, term $26$.

  $
  S_n = 26/2(14 + 89) = 1339
  $
