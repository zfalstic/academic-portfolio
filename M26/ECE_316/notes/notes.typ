#import "@preview/ilm:2.1.1": *

#set text(lang: "en")

#show: ilm.with(
  title: [ECE 316: Digital Logic Design],
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

= Introduction to Digital Logic

Analog signals take on an infinite number of possible values.
- Magnitude of voltage on a wire created by a microphone

Digital signals take on finite possible values
- _Binary_ is only one example of digital
- _Hexadecimal_ is also digital
- _Octal_ as well and so is _Quad_

Binary takes on two values *0* and *1*. You can think of them
as two states.

== Benefits of Digitization

- Analog signal may lose quality
  - Noise
  - Voltage levels not saved/copied/transmitted perfectly
- Digital version enables near-perfect save/copy/transmission
  - _Sample_ voltage at a particular rate, save sample using
    bit encoding (ADC)
  - Voltage levels still not kept perfectly
  - But we can distinguish between 1s and 0s

#blockquote[
  Dr. Telang gives a great example of Analog signal to digital
  encoding.
]

== Forms of Encoding

- ASCII (8-bit)
- Unicode (16-bit)

= Boolean Algebra

In traditional algebra, variables represent real numbers $(x, y, z, dots)$.
Operators operate on these variables and return real numbers.

In *Boolean Algebra*
- Variables can only be 0 or 1
- Operators return only 0 or 1
- Basic operators:
  - AND: $a$ AND $b$ returns 1 only when both inputs are 1
  - OR: $a$ OR $b$ returns 1 when either or both inputs are 1
  - NOT: NOT $a$ inverts the input. $1 arrow 0$ or $0 arrow 1$

== Boolean Expressions

Boolean expressions look like algebraic expressions.

$ A B' + C $

- Multiplication is AND
- Addition is OR

Parantheses #math.arrow NOT #math.arrow AND #math.arrow OR

_Example._

$ F(a, b, c) = a' b c + a b c' + a b  + c $

- A *literal* is the apearance of a variable in true or complemented
  form.
- Corresponds to gate input
- In the first term, $a', b, c$ are literals

A *sum-of-products* form is a two-level circuit, AND and OR.

== Truth Tables

A *truth table* specifies values of a boolean expression for
every combination of input variable values.

== Basic Theorems

- Operations with 0 and 1
  - $X + 0 = X$
  - $X + 1 = 1$
  - $X dot 1 = X$
  - $X dot 0 = 0$
- Idempotent Laws
  - $X + X = X$
  - $X dot X = X$
- Involution Law
  - $(X')' = X$
- Laws of Complementarity
  - $X + X' = 1$
  - $X dot X' = 0$
- Commutative
  - $a + b = b + a$
  - $a dot b = b dot a$
- Associative
  - $(a + b) + c = a + (b + c)$
  - $(a dot b) dot c = a dot (b dot c)$
- Distributive
  - $a dot (b + c) = a dot b + a dot c$
  - $a + (b dot c) = (a + b) dot (a + c)$

== Simplification Theorems

- Uniting Theorem: $X Y + X Y' = X$
- Absorption Theorem: $X + X Y = X$
- Elimination Theorem: $X + X' Y = X + Y$
- DeMorgan's Laws:
  - $(X + Y)' = X' Y'$
  - $(X Y)' = X' + Y'$

== Canonical Forms

- Sum of minterms
- Product of maxterms

#table(
  columns: 4,
  align: (center, center, left, left),
  stroke: none,
  inset: (x: 12pt, y: 5pt),

  [Row No.], table.vline(), [$A B C$], table.vline(), [Minterms], table.vline(), [Maxterms],
  table.hline(),

  [0], [$0 0 0$], [$A'B'C' = m_0$], [$A + B + C = M_0$],
  [1], [$0 0 1$], [$A'B'C = m_1$],  [$A + B + C' = M_1$],
  [2], [$0 1 0$], [$A'B C' = m_2$], [$A + B' + C = M_2$],
  [3], [$0 1 1$], [$A'B C = m_3$],  [$A + B' + C' = M_3$],
  [4], [$1 0 0$], [$A B'C' = m_4$], [$A' + B + C = M_4$],
  [5], [$1 0 1$], [$A B'C = m_5$],  [$A' + B + C' = M_5$],
  [6], [$1 1 0$], [$A B C' = m_6$], [$A' + B' + C = M_6$],
  [7], [$1 1 1$], [$A B C = m_7$],  [$A' + B' + C' = M_7$],
)

= Verilog for Combinational Logic Design

Verilog is a c-like hardware description language (HDL).

#figure(
  image("typical-design-flow.png", width: 70%),
  caption: [
    Typical Hardware Design Flow
  ],
)

== Verilog Basics

Numeric literals have the form

```verilog
4'b10_11
```

== Structural Module

Here is what a 4-bit adder module definition looks like in
verilog.

```verilog
module adder (
  input [3:0] A, B,
  output cout,
  output [3:0] sum
);

endmodule
```

A module can use other modules. In a 4-bit adder we may use
multiple full adders that are defined as,

```verilog
module FA (
  input a, b, cin,
  output cout, sum
);

endmodule
```

In our 4-bit adder, we need to connect our full adders together

```verilog
module adder (
  input [3:0] A, B,
  output cout,
  output [3:0] sum
);

wire c0, c1, c2;
FA fa0( A[0], B[0], 0, c0, S[0] ); // 4 instances of full adder
FA fa1( A[1], B[1], c0, c1, S[1] );
FA fa2( A[2], B[2], c1, c2, S[2] );
FA fa3( A[3], B[3], c2, cout, S[3] );

endmodule
```

== Behavioral Module

= Karnaugh Maps

Tool for boolean logic simplification. The motivation behind
simplifying boolean logic is to end up with smaller circuits.
Fewer gates = less transistors = smaller and more efficient
circuits.

#table(
  columns: 4,
  table.header[a][b][c][$f_1$],
  [0], [0], [0], [1],
  [0], [0], [1], [1],
  [0], [1], [0], [0],
  [0], [1], [1], [0],
  [1], [0], [0], [1],
  [1], [0], [1], [0],
  [1], [1], [0], [0],
  [1], [1], [1], [1],
)

$
f_1 &= a' b' c' + a' b' c + a b' c' + a b c \
f_1 &= a' b' + b' c' + a b c
$

= Latches and Flip-Flops

= Finite State Machines

- Need
  - A way to _capture_ desired sequential behavior
  - A way to _convert_ such behavior to a sequential circuit
- *Finite State Machine (FSM)*
  - Describes desired behavior of sequential circuit

#figure(
  image("fsm-example-1.png", width: 50%),
  caption: [
    FSM Frequency 2-Divider
  ],
)

#figure(
  image("fsm-example-2.png", width: 50%),
  caption: [
    FSM Frequency 4-Divider
  ],
)

_example._ Design a divide by 5 frequency divider circuit.
