#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW3"
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
  For a circuit of three level-sensitive D latches connected in series (see
  below, the output of one is connected to the input of the next). Complete a
  timing diagram below showing values of $Q_1$, $Q_2$, and $Q_3$. Assume the
  initial values of $Q_1$, $Q_2$, and $Q_3$ are all 0. Assume that the latch
  has a non-zero delay, much smaller than the clock period.

  #image("problem-1-question.png", width: 70%)
]

#image("problem-1.png", width: 70%)

_Note._ taking into account the latch delay, every subsequent
$Q_n$ after $Q_1$ would be offset to the right a little bit
from the previous $Q_(n-1)$

#pagebreak()
#prob()[
  For a circuit of three edge-triggered D flip-flops connected in series (see
  below, the output of one is connected to the input of the next). Complete a
  timing diagram below showing values of $Q_1$, $Q_2$, and $Q_3$. Assume the
  initial values of $Q_1$, $Q_2$, and $Q_3$ are all 0. Assume that the
  flip-flop has a non-zero delay, much smaller than the clock period.

  #image("problem-2-question.png", width: 70%)
]

#image("problem-2.png", width: 70%)

#pagebreak()
#prob()[
  Draw a state diagram for an FSM with an input $g c n t$ and three outputs,
  $x$, $y$ and $z$. The $x y z$ outputs generate a sequence called a Gray code
  in which exactly one of the three outputs changes from 0 to 1 or from 1 to 0.
  The Gray code sequence that the FSM should output is 000, 010, 011, 001, 101,
  111, 110, 100, repeat. The output should change only on a rising clock edge
  when the input $g c n t = 1$. Make the initial state 000.
]

#image("problem-3.png", width: 70%)

#pagebreak()
#prob()[
  Create an FSM that has an input $X$ and an output $Y$. Whenever $X$ changes
  from 0 to 1, $Y$ should become 1 for five clock cycles and then return to 0
  --- even if $X$ is still 1. Using the process for designing a controller,
  convert the FSM to a controller, stopping once you have created combinational
  logic for the controller.
]

#image("problem-4-fsm.png", width: 70%)

#table(
  columns: 8,
  table.header[$S_2$][$S_1$][$S_0$][$X$][$N_2$][$N_1$][$N_0$][$Y$],
  table.vline(x: 4, stroke: 2pt),
  [0],[0],[0],[0],[0],[0],[0],[0],
  [0],[0],[0],[1],[0],[0],[1],[0],
  [0],[0],[1],[0],[0],[1],[0],[1],
  [0],[0],[1],[1],[0],[1],[0],[1],
  [0],[1],[0],[0],[0],[1],[1],[1],
  [0],[1],[0],[1],[0],[1],[1],[1],
  [0],[1],[1],[0],[1],[0],[0],[1],
  [0],[1],[1],[1],[1],[0],[0],[1],
  [1],[0],[0],[0],[1],[0],[1],[1],
  [1],[0],[0],[1],[1],[0],[1],[1],
  [1],[0],[1],[0],[0],[0],[0],[1],
  [1],[0],[1],[1],[1],[1],[0],[1],
  [1],[1],[0],[0],[0],[0],[0],[0],
  [1],[1],[0],[1],[1],[1],[0],[0],
)

#image("problem-4-controller.png", width: 70%)
