#import "@preview/ilm:2.1.1": *

#set text(lang: "en")

#show: ilm.with(
  title: [ECE 316: Digital Logic Design],
  authors: ("Dawson Zhang"),
  date: datetime.today(),
  abstract: [
  ],
  preface: [
    #align(center + horizon)[
      HW 5
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

#set math.equation(numbering: none)

= RTL Design

#figure(
  image("01-01.png", width: 100%),
  caption: [
    HLSM
  ],
)

#figure(
  image("01-02.png", width: 100%),
  caption: [
    Datapath / Controller
  ],
)

The problem asks us to sample every few clock cycles. Instead,
we could just sample every clock cycle but have the clock input
to this entire module be on a slow clock. This approach is
superior because it could either

+ reduce states (whereas otherwise there would need to be delay states)
+ simplify state transitions (not dependent on some down counter TC i.e.)

One mechanical nuance though is that this approach would require
a little more time for alarm to update, since it updates on the
next SLOW clock edge. But in the scale of a few clock cycles
(assuming 100 MHz), that is unnoticable.

= Prime and Essential Prime Implicants

Essential primes are bolded.

*Equation 1*

#figure(
  image("02-01.png", width: 30%),
  caption: [
    Equation 1 K-Map
  ],
)

- bd'
- bc'
- a'b
- ad'
- ac'
- *ab'* ($m_11$)

SOPs

- ab' + bc' + ad'
- ab' + bc' + bd'
- ab' + bd' + ac'

#pagebreak()

*Equation 2*

#figure(
  image("02-02.png", width: 30%),
  caption: [
    Equation 2 K-Map
  ],
)

- *a'b* ($m_4$)
- *c'd* ($m_1$)
- *cd'* ($m_2$)
- ab'c'
- ab'd'

SOPs

- a'b + c'd + cd'

#pagebreak()

*Equation 3*

#figure(
  image("02-03.png", width: 30%),
  caption: [
    Equation 3 K-Map
  ],
)

- bd'
- bc'
- a'b
- ad'
- ac'
- ab'

SOPs

- a'b
- bc'
- bd'

#pagebreak()

*Equation 4*

#figure(
  image("02-04.png", width: 30%),
  caption: [
    Equation 4 K-Map
  ],
)

- a'd'
- a'c'
- a'b
- b'c'
- b'd'
- *bcd* ($m_15$)

SOPs

- bcd + a'b
- bcd + a'c'
- bcd + a'd'

= Moore #math.arrow Mealy

#figure(
  image("03.png", width: 100%),
  caption: [
    Converted Mealy FSM
  ],
)

_note._ There is an argument being made to keep state Red2, but
have it be unconditional arrow to wait with output zero. 
Without it, we lose a clock cycle that exists in the moore
machine. I chose to exlcude it because then there would be no
benefit to converting to Mealy if not for
saving a state at the cost of potential timing issues.

= FSM Encodings

#figure(
  image("04-01.png", width: 40%),
  caption: [
    Binary Encoding TT
  ],
)

$
N_1 &= S_1 ' S_0 + S_1 S_0 ' + S_1 S_0 = S_1 + S_0 \
N_0 &= S_1 'S_0 ' + S_1 S_0 ' + S_1 S_0 = S_1 + S_0' \
W &= S_1 ' S_0 ' \
X &= S_1 ' S_0 \
Y &= S_1 S_0 '
$

#figure(
  image("04-02.png", width: 40%),
  caption: [
    Output Encoding TT
  ],
)

$
N_2 &= 0 \
N_1 &= S_2 \
N_0 &= S_1 \
W &= S_2 \
X &= S_1 \
Y &= S_0
$

#figure(
  image("04-03.png", width: 40%),
  caption: [
    One-Hot Encoding TT
  ],
)

$
N_3 &= S_3 + S_2 \
N_2 &= S_1 \
N_1 &= S_0 \
N_0 &= 0 \
W &= S_0 \
X &= S_1 \
Y &= S_2
$

_note._ I'm treating the irrelevant input combinations as don't
cares.

Comparison between encoding types:

Number of literals in minimum SOPs

- Binary: 10
- Output: 5
- One-Hot: 7

We can see that in this example, the simplest logic comes from
output encoding. Each combinational output term is exactly
an input term. In a way, there's actually no logic, and it's
just wires.
