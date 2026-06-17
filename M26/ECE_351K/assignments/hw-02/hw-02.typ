#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW2"
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

#prob(title: "Circular Dart Board")[
  Suppose that darts are being thrown at the circular dart board
  shown below. The dart board has a radius of 3, and the bullseye
  area (in red) has a radius of 1.

  #figure(
    image("dart-board.png", width: 40%),
  )

  + What are the possible outcomes (coordinates) within the
    entire dart board? Provide a continuous range in the form
    of: ${(x, y) | "equation"}$.
  + What is the probability of a dart hitting the board but not
    the bullseye? Assume the probability is uniform across the
    entire dart board.
  + Find the probability of the dart landing in the gray ring.
    Assume the circles that form the gray ring have radii $a$
    and $b$ that satisfy $0 < a < b < 2$. The probability is
    still uniform across the entire dart board.
]

+ The probability doesn't explicity state where the origin of
  the coordinate plane should be.

  _I'm making the assumption that the coordinate plane starts
  at the bottom left, therefore the center of the dart board
  is at $(3, 3)$_

  Our set of possibilities can be represented by the following:

  $
  {(x, y) | sqrt((x - 3)^2 + (y - 3)^2) <= 3}
  $

+ This question can be rephrased as:

  $
  P("not bullseye" | "board")
  $

  This involves finding the proportion of area that is not
  part of the bullseye but part of the board.

  $
  p = (pi 3^2 - pi 1^2)/(pi 3^2) = (9pi - pi) / (9pi) = 8/9
  $

+ 

  Similar to the last question, we want to find the proportion 
  of the board area that is in the gray area.

  $
  "gray"_A = (pi b^2 - pi a^2)
  $

  $
  p = "gray"_A / (pi 3^2) = (pi b^2 - pi a^2) / (9 pi) = (b^2 - a^2) / 9
  $

#prob(title: "Axiom Consequence Proofs")[
  Prove each of the following using Venn diagrams.

  + $P(A) = P(A inter B) + P(A inter B^complement)$
  + $P(A union B) = P(A) + P(B) - P(A inter B)$
]

+ #figure(
    image("zenn-1.png", width: 60%),
  )
+ #figure(
    image("zenn-2.png", width: 60%),
  )

#prob(title: "Conditional Probability")[
  Every morning, Marcus goes to the gym by running (with
  probability 0.3), cycling (with probability 0.5), or taking
  the bus (with probability 0.2). If he runs, he stops for
  coffee with probability 0.6, and if he cycles, he stops for
  coffee with probability 0.3. He never stops for coffee if he
  is taking the bus.

  + What is the probability that on any given day, Marcus will
    cycle and stop for coffee?
  + What is the probability that on any given day, Marcus will
    stop for coffee?
  + If on a particular day Marcus stops for coffee, what is the
    probability that he ran?
  ]

+ $P("cycle" inter "coffee") = P("cycle") dot P("coffee" | "cycle") = 0.5 dot 0.3 = 0.15$
+ 
  $
  P("coffee") &= P("cycle") dot P("coffee" | "cycle") + P("run") dot P("coffee" | "run") + P("bus") dot P("coffee" | "bus") \
  &= 0.5 dot 0.3 + 0.3 dot 0.6 + 0.2 dot 0 \
  &= 0.15 + 0.18 = 0.33
  $
+ 
  $
  P("ran" | "coffee") = P("ran" inter "coffee") / P("coffee") = (P("ran") dot P("coffee" | "ran")) / P("coffee") = (0.3 dot 0.6) / 0.33 = 0.55
  $

#prob(title: "Total Probability")[
  You are told the probability of Ben going to the library each
  day of the week. The table below summarizes this information.
  What is the probability that Ben goes to the library on any
  given day?

  #table(
    columns: 2,
    [MWF], [0.6],
    [TTh], [0.3],
    [Sat], [0.1],
    [Sun], [0.05]
  )
]

$
3/7 dot 0.6 + 2/7 dot 0.3 + 1/7 dot 0.1 + 1/7 dot 0.05 = 0.36
$

#prob(title: "Bayes Rule")[
  You have been surveying students about their music
  preferences. Your data shows that the probability an ECE
  student listens to lo-fi while studying is 0.6, and the
  probability that a non-ECE student listens to lo-fi while
  studying is 0.3. Additionally, 35% of all students are ECE
  majors. What is the probability that a student is an ECE
  major given that you know they listen to lo-fie while
  studying?
]

First find the probability of lo-fi

$
P("lo-fi") &= P("ECE") dot P("lo-fi" | "ECE") + P("not ECE") dot P("lo-fi" | "not ECE") \
&= 0.35 dot 0.6 + 0.65 dot 0.3 = 0.405
$

Find the joint probability of ECE and lo-fi

$
P("ECE" inter "lo-fi") = P("ECE") dot P("lo-fi" | "ECE") = 0.21
$

Find the opposite conditional probability

$
P("ECE" | "lo-fi") = P("ECE" inter "lo-fi") / P("lo-fi") = 0.210/0.405 = 0.52
$
