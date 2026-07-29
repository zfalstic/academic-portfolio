#import "@preview/ilm:2.1.1": *

#set text(lang: "en")

#show: ilm.with(
  title: [ECE 316: Digital Logic Design],
  authors: ("Dawson Zhang", "David Gong"),
  date: datetime.today(),
  abstract: [
  ],
  preface: [
    #align(center + horizon)[
      Lab 3
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

#set math.equation(numbering: none)

= HLSM Design

== Top-level Block Diagram

#image("high-level-path.png", width: 100%)

_note._ There is a bit of this diagram that is still
incomplete. That is, the circuit inputs of the down counter. We
are still in the process of finalizing the amount of time
that should be allocated for

+ presenting the level (AKA how much time the user has to 
  remember the pattern)
+ user inputting their response (AKA how much time the user has
  to input a response)

There should be some connection between the counter and the LED
register, along with a MUX that selects some LOAD constants
for the counter itself.

#pagebreak()

== Detailed Datapath Diagram

_note._ From the top-level block diagram, most of the blocks are
either *outputs* or *storage registers*. The game controller is
the only block that isn't an elementary element.

#image("game-controller.png", width: 100%)

This is the state machine for controlling the _traversal_
directions between each LED segment.

The output of this game-controller circuit:

- A 2x7 wire representing the position of the player. i.e.
  0010000 0000000. Only one bit will be 1, the position.
- A 2x7 wire representing the player input. This wire
  is the *XOR* of the position and current player input. It
  will flip the bit where the player currently is.

We have deliberately not drawn out a datapath for this block
as 95% of the logic is captured in the state transition graph.

== Detailed Controller FSM Diagram

#image("controller-fsm.png", width: 70%)

== Signal Table

#table(
  columns: 4,
  table.header[Name][Width][Direction][Purpose],
  [start],[1],[datapath #math.arrow controller],[+ transition from IDLE to level-display
                                                 + transition from score-display to IDLE
                                                 + flip the position bit of the user input],
  [TC],[1],[datapath #math.arrow controller],[+ transition from level-display to user-input
                                              + transition from user-input to score-display],
  [up],[1],[datapath #math.arrow controller],[traverse up in game controller],
  [down],[1],[datapath #math.arrow controller],[traverse down in game controller],
  [left],[1],[datapath #math.arrow controller],[traverse left in game controller],
  [right],[1],[datapath #math.arrow controller],[traverse right in game controller],
  [SSEG],[4x7],[controller #math.arrow datapath],[seven segment output],
  [LED],[16],[controller #math.arrow datapath],[LED output],
)

= Module Hierarchy and Port Lists

== Module Hierarchy Diagram

== Per-Module Port List

== Per-Module Submodule List

- *Game Top*
- INPUTS
  - start
  - up, down, left, right
- OUTPUTS
  - SSEG (4x7 bits)
  - LED (16 bits)
- SUBMOUDLES
  - *Game Controller*
  - INPUTS
    - up, down, left, right
  - OUTPUTS
    - position (2x7 bits)
    - user-input (2x7 bits)

_note._ I'm questioning my intuition of converting the datapath
to modules. Will probably figure out easier as we're actually
creating the modules.
