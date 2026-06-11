#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW1"
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

#prob()[
  Convert each of the following equations directly to gate-level circuits. Do not minimize before drawing the
  circuit. Assume that inputs are available only in true form, not complemented form.

  + $F = a b' + b c + c'$
  + $F = a b + b' c' d'$
  + $F = ((a + b') * (c' + d)) + (c + d + e')$
]

+ #figure(
    image("1a.png", width: 70%),
  )
+ #figure(
    image("1b.png", width: 70%),
  )
+ #figure(
    image("1c.png", width: 70%),
  )

#pagebreak()

#prob()[
  A museum has three rooms, each with a motion sensor (m0,m1, and m2) that outputs 1 when motion is
  detected. At night, the only person in the museum is one security guard who walks from room to room.
  Create a circuit that sounds an alarm (by setting an output A to 1) if motion is ever detected in more than one
  room at a time, meaning there must be at least one intruder. Start with a truth table.
]

#table(
  columns: 4,
  [$m_0$], [$m_1$], [$m_2$], [$F$],
  [0], [0], [0], [0],
  [0], [0], [1], [0],
  [0], [1], [0], [0],
  [0], [1], [1], [1],
  [1], [0], [0], [0],
  [1], [0], [1], [1],
  [1], [1], [0], [1],
  [1], [1], [1], [1],
)

#figure(
  image("2.png", width: 70%),
)

#pagebreak()

#prob()[
  Convert the following Boolean equations to the canonical sum-of-minterms form.

  + $F(a, b, c) = a b c + a'$
  + $F(a, b, c) = a' + b' + c'$
  + $F(a, b, c, d) = a' c + a' b d + a b c d$
]

+ $m_0 + m_1 + m_2 + m_3 + m_7$
+ $m_0 + m_1 + m_2 + m_3 + m_4 + m_5 + m_6$
+ $m_2 + m_3 + m_5 + m_6 + m_7 + m_15$

#prob()[
  Given the truth table below, convert the function $F$ to sum-of-products equation.
]

#table(
  columns: 4,
  [$a$], [$b$], [$c$], [$F$],
  [0], [0], [0], [1],
  [0], [0], [1], [0],
  [0], [1], [0], [1],
  [0], [1], [1], [0],
  [1], [0], [0], [1],
  [1], [0], [1], [1],
  [1], [1], [0], [0],
  [1], [1], [1], [0],
)

$ F = a' b' c' + a' b c' + a b' c' + a b' c $

#pagebreak()

#prob()[
  A network router connects multiple computers together and allows them to send messages to each other. If two
  or more computers send simultaneously, the messages "collide" and must be re-sent. Create a collision
  detection circuit for a router that connects 4 computers (m0, m1, m2, and m3) that are 1 when the corresponding
  computer is sending a message. The circuit has one output $C$ that is 1 when a collision is detected.
]

#figure(
  image("5.png", width: 70%),
)

#pagebreak()

#prob()[
  Design a 3x8 decoder using AND, OR and NOT gates.
]

#figure(
  image("6.png", width: 70%),
)

#pagebreak()

#prob()[
  Design an 8x1 multiplexer using AND, OR and NOT gates.
]

#figure(
  image("7.png", width: 70%),
)
