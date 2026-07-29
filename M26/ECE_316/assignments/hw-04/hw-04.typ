#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW4"
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
  Design an 8-bit register with 2 control inputs $s_1$ and $s_0$, 8 data inputs
  $I_7 . . I_0$, and 8 data outputs $Q_7 . . Q_0$. $s_1 s_0 = 00$ means maintain
  the present value, $s_1 s_0 = 01$ means load, and $s_1 s_0 = 10$ means clear.
  $s_1 s_0 = 11$ means to swap the high nibble with the low nibble (a nibble is
  4 bits), so 11110000 would become 00001111, and 11000101 would become 01011100.
]

#image("problem-1.png", width: 100%)

#prob()[
  Assuming all gates have a delay of 1ns, compute the longest time required to
  add two numbers using an 8-bit ripple carry adder. Assume the full adder
  implementation below:

  #image("problem-2-question.png", width: 50%)
]

_Note._ I'm making the assumption that the wording of "all gates
have a delay of 1ns applies to _literally_ all the gates, i.e.,
multi-input, different gate types, *ALL* 1ns.

The critical path in each full adder is the path to $c_o$,
which in each full-adder is 2ns.

With 8-full adders, the critical path would be *16ns*.

#pagebreak()

#prob()[
  Design a human body temperature indicator system for a hospital bed. Your
  system takes an 8-bit input representing a person's body temperature, which
  can range from 0 to 255. If the measured temperature is 95 or less, set output
  $A$ to 1. If the temperature is 96 to 104, set output $B$ to 1. If the
  temperature is 105 or above, set output $C$ to 1. Use an 8-bit magnitude
  comparator and additional logic as required.
]

#image("problem-3.png", width: 50%)

#prob()[
  Create an absolute value component _abs()_ with an 8-bit input $A$ that is a
  signed binary number, and an 8-bit output $Q$ that is unsigned and that is the
  absolute value of $A$. So if the input is 00001111 (+15) then the output is
  also 00001111 (+15), but if the input is 11111111 (-1) then the output is
  00000001 (+1).
]

#image("problem-4.png", width: 35%)

#pagebreak()

#prob()[
  Design a circuit whose 16-bit output is nine times its 16-bit input $D$
  representing an unsigned binary number. Ignore overflow issues. What is the
  maximum input value that will not cause an overflow?
]

#image("problem-5.png", width: 35%)

We can work backwards to find the maximum non-overflowing
input value.

$
floor((2^16 - 1)/9) = 7281
$
