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
      Lab 1 A
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

= Sprinkler Valve Controller

== Truth Table

_The truth table was given by the lab document._

#let sprinkler-tt = table(
  columns: 12,
  table.vline(x: 4, stroke: 4pt),
  table.header(
    $E$, $A$, $B$, $C$, $d_7$, $d_6$, $d_5$, $d_4$, $d_3$, $d_2$, $d_1$, $d_0$,
  ),
  [0], [x], [x], [x], [0], [0], [0], [0], [0], [0], [0], [0],
  [1], [0], [0], [0], [0], [0], [0], [0], [0], [0], [0], [1],
  [1], [0], [0], [1], [0], [0], [0], [0], [0], [0], [1], [0],
  [1], [0], [1], [0], [0], [0], [0], [0], [0], [1], [0], [0],
  [1], [0], [1], [1], [0], [0], [0], [0], [1], [0], [0], [0],
  [1], [1], [0], [0], [0], [0], [0], [1], [0], [0], [0], [0],
  [1], [1], [0], [1], [0], [0], [1], [0], [0], [0], [0], [0],
  [1], [1], [1], [0], [0], [1], [0], [0], [0], [0], [0], [0],
  [1], [1], [1], [1], [1], [0], [0], [0], [0], [0], [0], [0],
)

#figure(caption: [Sprinker Valve Controller Truth Table], sprinkler-tt)

== SOP Equations

_These equations were given by the lab document._

$
d_0 &= E A' B' C' \
d_1 &= E A' B' C \
d_2 &= E A' B C' \
d_3 &= E A' B C \
d_4 &= E A B' C' \
d_5 &= E A B' C \
d_6 &= E A B C' \
d_7 &= E A B C \
$

== Gate-level Schematic

#figure(
  image("sprinkler-circuit.png", width: 30%),
  caption: [
    Hand Drawn Gate-Level Circuit
  ],
)

#figure(
  image("sprinkler-schematic.png", width: 70%),
  caption: [
    Gate-Level Sprinkler Schematic
  ],
)

== Structural Verilog

_This code was given by the lab document._

#let sprinkler-module = ```verilog
module sprinkler_decoder(
    input wire E, A, B, C,
    output wire d0, d1, d2, d3, d4, d5, d6, d7
);
    wire nA, nB, nC;
    
    not (nA, A);
    not (nB, B);
    not (nC, C);
    
    and (d0, E, nA, nB, nC);
    and (d1, E, nA, nB, C);
    and (d2, E, nA, B, nC);
    and (d3, E, nA, B, C);
    and (d4, E, A, nB, nC);
    and (d5, E, A, nB, C);
    and (d6, E, A, B, nC);
    and (d7, E, A, B, C);
endmodule
```

#figure(caption: [Sprinkler Verilog Module], sprinkler-module)

== Testbench Source

_This code was given by the lab document._

#let sprinkler-tb = ```verilog
`timescale 1ns / 1ps
module sprinkler_decoder_tb;
    reg E, A, B, C;
    wire d0, d1, d2, d3, d4, d5, d6, d7;
    
    sprinkler_decoder uut(
        .E(E), .A(A), .B(B), .C(C),
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .d4(d4), .d5(d5), .d6(d6), .d7(d7)
    );
    
    integer i;
    initial begin
        // Sweep all 16 combinations of {E, A, B, C}.
        for (i = 0; i < 16; i = i + 1) begin
            {E, A, B, C} = i[3:0];
            #10;
        end
        $finish;
    end
endmodule
```

#figure(caption: [Sprinkler Testbench], sprinkler-tb)

== Waveform Simulation

#figure(
  image("sprinkler-waveform.png", width: 70%),
  caption: [
    Waveform Simulation Screenshot
  ],
)

= 4-to-1 MUX Design

== Truth Table

We are already basically given the information we need to know
to develop a condensed form truth table in the following 
equation:

$
d = cases(
  i_0 & "if" s_1 s_0 = 00,
  i_1 & "if" s_1 s_0 = 01,
  i_2 & "if" s_1 s_0 = 10,
  i_3 & "if" s_1 s_0 = 11
)
$

The truth table equivalent of this equation is:

#let four-to-one-mux-tt = table(
  columns: 3,
  table.vline(x: 2, stroke: 3pt),
  table.header[$s_0$][$s_1$][$d$],
  [0], [0], [$i_0$],
  [0], [1], [$i_1$],
  [1], [0], [$i_2$],
  [1], [1], [$i_3$]
)

#figure(caption: [4-to-1 MUX Condensed Truth Table], four-to-one-mux-tt)

== Algebraic Expression for $d$

From the truth table, we can derive the SOP form alebraic
expression for $d$.

$
d = i_0 s_1 ' s_0 ' + i_1 s_1 ' s_0 + i_2 s_1 s_0 ' + i_3 s_1 0_2
$

== Gate-level Schematic

From the SOP equation, we can directly derive a two-tiered MUX
circuit using ANDs and ORs.

#figure(
  image("4-to-1-schematic.png", width: 70%),
  caption: [
    Gate-level 4-to-1 MUX Schematic
  ],
)

= Verilog Integration

== Structural Verilog Module

#let structural-verilog-module = ```verilog
// mux4to1_struct.v

module mux4to1_struct(
    input wire i0, i1, i2, i3, s0, s1,
    output wire d
);
    wire ns0, ns1;
    not (ns0, s0);
    not (ns1, s1);
    
    wire a0, a1, a2, a3;
    and (a0, i0, ns0, ns1);
    and (a1, i1, s0, ns1);
    and (a2, i2, ns0, s1);
    and (a3, i3, s0, s1);
    
    or (d, a0, a1, a2, a3);
endmodule
```

#figure(caption: [Structural Verilog Module], structural-verilog-module)

== Behavioral Verilog Module

#let behavioral-verilog-module = ```verilog
// mux4to1_behav.v

module mux4to1_behav(
    input wire i0, i1, i2, i3, s0, s1,
    output wire d
);
    reg temp_d;
    assign d = temp_d;
    always @(*) begin
        case ({s1, s0})
            2'b00: temp_d = i0;
            2'b01: temp_d = i1;
            2'b10: temp_d = i2;
            2'b11: temp_d = i3;
        endcase
    end
endmodule
```

#figure(caption: [Behavioral Verilog Module], behavioral-verilog-module)

== Single Testbench Exercising Both Modules

#let testbench = ```verilog
// mux4to1_tb.v

module mux4to1_tb;
    reg i0, i1, i2, i3, s0, s1;
    wire ds, db;

    mux4to1_struct uuts (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .s0(s0), .s1(s1),
        .d(ds)
    );
    
    mux4to1_behav uutb (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .s0(s0), .s1(s1),
        .d(db)
    );
    
    integer i, j;
    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            {s1, s0} = i[1:0];
            for (j = 0; j < 16; j = j + 1) begin
                {i3, i2, i1, i0} = j[3:0];
                #10;
            end
        end
        $finish;
    end
endmodule
```

#figure(caption: [Single Testbench Exercising Both Modules], testbench)

== Simulation Waveform Screenshots (of both modules)

#figure(
  image("test-waveform.png", width: 100%),
  caption: [
    Simulation Waveform for Both Structural and Behavioral
  ],
)

This testbench is implemented using two for loops. The outer
loop iterates through all combinations of the select line, while
the inner loop iterates through all combinations of the input
lines. This approach takes into account all 64 combinations of
the two select and four input lines.

During the first $160 "ns"$ ($10 "ns"$ for each of the 16 
possible input combinations), $s_1 = s_0 = 0$ so both outputs
$d_s$ (structural) and $d_b$ (behavioral) _mirror_ the input
on $i_0$.

In the next $160 "ns"$ ($s = 01$), the outputs mirror $i_1$.
Then, $i_2$ and $i_3$.

= Written Reflection

_Question 1._ Which model was easier to write?

In my opinion, I think that the structural model was easier to
write: possibly because the sprinkler example was in structural
syntax, and it felt more comfortable to translate that syntax
to the MUX. In the future, I can see how behavioral verilog may
actually become easier than structural it takes considerably
less written code. I
'm just not comfortable with the syntax *yet*.

_Question 2._ Which model is easier to read?

Without a doubt the behavioral model is easier to read.
Behavioral reads a lot like a programming language and abstracts
away the underlying gate-level connections.

_Question 3._ Describe the differences between _structural_ 
Verilog, _behavioral_ Verilog, and a _testbench_.

Structural and behavioral verilog are *used* for actually designing
a physical circuit (connections between logic gates) that can
be implemented on site or through prototyping hardware like
FPGAs. Testbenches on the other hand are used before synthesis to
fully test a design before it is created physically which 
consumes time and money.

There are some very distinct *visual* differences between
the three. In structural verilog, you can directly see the gates
and their connections. In behavioral verilog, there are no
direct gate connections and we as designers use expressions and
conditionals to logically connect gates. In testbenches, a 
clear giveaway is that the module will not have any inputs or
outputs. It encapsulates either a structural or behavioral model
and runs tests on the inputs while checking for the right outputs.

On the *synthesis* side, behavioral and structural verilog
result in actual gates being created on the FPGAs physical
components. With testbenches, nothing happens since they don't
even reside in the environment where synthesis operates. It
doesn't make sense to synthesize something that doesn't describe
an actual layout.
