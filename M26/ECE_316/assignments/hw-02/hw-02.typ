#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW2"
#let author = "Dawson Zhang" 
#let collaborators = []
#let course-id = "ECE 316: Digital Logic Design"
#let instructor = "Prof. Nina Telang"
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

#prob()[
  Perform two-level logic minimization for the following
  functions using (a) algebraic methods, (b) a K-map. Express
  the answers in sum-of-products form.

  + $F(a, b, c) = a' b' c' + a' b c' + a' b' c + a b' c'$
  + $G(a, b, c, d) = b c d' + a b d + a' b c d$
]

+
  *Algebraic Method:*

  $
  F &= a' b' c' + a' b c' + a' b' c + a b' c' \
  &= a' b' (c + c') + a' c' (b + b') + b' c' (a + a') \
  &= a' b' + a' c' + b' c'
  $

  *K-map:*
  #figure(
    image("1-a.png", width: 40%),
  )
  $
  F &= a' b' + a' c' + b' c'
  $
+
  *Algebraic Method:*

  $
  G &= b c d' + a b d + a' b c d \
  &= b c (d' + a' d) + b d (a + a' c) \
  &= a' b c + b c d' + a b d + b c d \
  &= b c (d + d') + a' b c + a b d \
  &= b c + a' b c + a b d \
  &= b(c + a' c + a d) \
  &= b(c + a d) \
  &= b c + a b d
  $

  *K-map:*
  #figure(
    image("1-b.png", width: 40%),
  )
  $
  G &= b c + a b d
  $

#prob()[
  Find the minimum SOP for the following expressions. Note that
  $d(k)$ refers to a don't-care in a minterm with the decimal
  index k.

  + $F(a, b, c, d) = sum m(0, 2, 3, 5, 6, 7, 11, 12, 13)$
  + $F(a, b, c, d) = sum m(1, 5, 6, 7, 13) + sum d(4, 8)$
  + $F(a, b, c, d) = sum m(0, 2, 6, 9, 13, 14) + sum d(3, 8, 10)$
]

+
  #figure(
    image("2-a.png", width: 40%),
  )
  $
  F = a' c + a' b' d' + b' c d + a' b d + a b c'
  $
+
  #figure(
    image("2-b.png", width: 40%),
  )
  $
  F = a' b + a' c' d + b c' d
  $
+
  #figure(
    image("2-c.png", width: 40%),
  )
  $
  F = b' d' + c d' + a c' d
  $

#prob()[
  Given $F(a, b, c) = sum m(0, 5, 6, 7)$, do the following:
  + Find, $F_1$, the minimum SOP expression for $F$
  + Draw the corresponding SOP gate design.
  + Find, $F_2$, the minimum POS expression for $F$
  + Draw the corresponding POS gate design.
  + Prove, algebraically, that $F_2 = F_1$
]

+
  #figure(
    image("3-a.png", width: 40%),
  )
  $
  F_1 = a b + a c + a' b' c' 
  $
+
  #figure(
    image("3-b.png", width: 40%),
  )
+ 
  #figure(
    image("3-c.png", width: 40%),
  )
  $
  F_2 = (a + b')(a + c')(a' + b + c)
  $
+
  #figure(
    image("3-d.png", width: 40%),
  )
+
  $
  F_2 &= (a + b')(a + c')(a' + b + c) \
  &= (a a + a c' + a b' + b' c')(a' + b + c) \
  &= (a + a c' + a b' + b' c')(a' + b + c) \
  &= a a' + a a'c' + a a' b' + a' b' c' + a b + a b c' + a b b' + b b' c' + a c + a c c' + a b' c + b' c c' \
  &= 0 + 0 + 0 + a'b'c' + a b + a b c' + 0 + 0 + a c + 0 + a b' c + 0 \
  &= a' b' c' + a b + a b c' + a c + a b' c \
  &= a' b' c' + a b (1 + c') + a c (1 + b') \
  &= a b + a c + a' b' c' \
  F_2 &= F_1
  $

#prob()[
  Consider the gate design below.

  #figure(
    image("4.png", width: 70%),
  )

  + Convert the design to a NAND-only gate design.
  + Convert the design to a NOR-only gate design.

  In both cases, explicit inverters can be used when needed. You can assume both a variable and its complement are available
  as inputs (you don’t need to use an explicit inverter to invert the circuit inputs).
]

+
  #figure(
    image("4-a.png", width: 100%),
  )
+
  #figure(
    image("4-b.png", width: 100%),
  )

#pagebreak()

#prob()[
  Repeat Problem 2 above, except now find the minimum POS
  expressions for each function.
]

+
  #figure(
    image("5-a.png", width: 40%),
  )
  $
  F = (b + c + d')(a' + b + d)(a' + b' + c')(a + b' + c + d)
  $
+
  #figure(
    image("5-b.png", width: 40%),
  )
  $
  F = (c + d)(a' + b)(a' + c')(b + c')
  $
+
  #figure(
    image("5-c.png", width: 40%),
  )
  $
  F = (a + d')(c' + d')(b' + c + d)
  $
