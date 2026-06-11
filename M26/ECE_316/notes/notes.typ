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
