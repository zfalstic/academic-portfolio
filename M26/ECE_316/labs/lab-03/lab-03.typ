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

= Ripple Carry Adder with Register

== Verilog Source (Given)

```verilog
//full_adder.v
`timescale 1ns / 1ps
module full_adder(
  input wire A, B, Cin,
  output wire S, Cout
);
    assign S = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule
```

```verilog
//register_logic.v
`timescale 1ns / 1ps
module register_logic(
    input wire clk,
    input wire enable,
    input wire [4:0] Data,
    output reg [4:0] Q
);
    always @(posedge clk) begin
        if (enable) Q <= Data;
    end
endmodule
```

```verilog
//RCA_4bits.v
`timescale 1ns / 1ps
module RCA_4bits(
    input wire clk,
    input wire enable,
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output wire [4:0] Q,
    output wire enable_led
);
    wire [3:0] S;
    wire [3:0] C; // C[i] is the carry into bit i+1 from full_adder i (i=0..2)
    wire Cout;
    
    full_adder fa0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(C[0]));
    full_adder fa1(.A(A[1]), .B(B[1]), .Cin(C[0]), .S(S[1]), .Cout(C[1]));
    full_adder fa2(.A(A[2]), .B(B[2]), .Cin(C[1]), .S(S[2]), .Cout(C[2]));
    full_adder fa3(.A(A[3]), .B(B[3]), .Cin(C[2]), .S(S[3]), .Cout(Cout));
    
    register_logic reg5(
        .clk(clk),
        .enable(enable),
        .Data({Cout, S}),
        .Q(Q)
    );
    
    assign enable_led = enable;
endmodule
```

== Testbench Source

```verilog
//RCA_4bits_tb.v
`timescale 1ns / 1ps
//======================================================================
// Testbench for RCA_4bits
//   - No ports
//   - Instantiates RCA_4bits as "uut"
//   - Generates a 100 MHz clock (10 ns period)
//   - Drives enable high for one full clock cycle per vector so the
//     result latches into the register before inputs change
//   - $display prints the inputs and resulting Q for each vector
//   - Self-checks Q against the expected {Cout, S} and $finish-es
//======================================================================
module RCA_4bits_tb;

    // ---- DUT connections ----
    reg        clk;
    reg        enable;
    reg  [3:0] A;
    reg  [3:0] B;
    reg        Cin;
    wire [4:0] Q;          // Q[4] = Cout, Q[3:0] = S
    wire       enable_led;

    // ---- Unit under test ----
    RCA_4bits uut (
        .clk        (clk),
        .enable     (enable),
        .A          (A),
        .B          (B),
        .Cin        (Cin),
        .Q          (Q),
        .enable_led (enable_led)
    );

    // ---- 100 MHz clock: 10 ns period (5 ns high / 5 ns low) ----
    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors;

    // Apply one test vector, latch it, print it, and check it.
    task run_vector;
        input [3:0] a_in;
        input [3:0] b_in;
        input       cin_in;
        input [4:0] expected;      // {Cout, S}
        begin
            // Set inputs while enable is low so nothing latches mid-change
            enable = 1'b0;
            A      = a_in;
            B      = b_in;
            Cin    = cin_in;

            // Hold enable high across one rising edge -> register latches
            @(negedge clk);
            enable = 1'b1;
            @(posedge clk);        // Q <= {Cout, S} scheduled here
            #1;                    // let the NBA update settle before reading

            $display("A=%b B=%b Cin=%b | Q=%b (Cout=%b S=%b) | expected=%b_%b | %s",
                     A, B, Cin, Q, Q[4], Q[3:0],
                     expected[4], expected[3:0],
                     (Q === expected) ? "PASS" : "FAIL");

            if (Q !== expected) errors = errors + 1;

            // Drop enable before moving to the next vector
            @(negedge clk);
            enable = 1'b0;
        end
    endtask

    initial begin
        // Optional waveform dump (useful under Icarus Verilog)
        $dumpfile("RCA_4bits_tb.vcd");
        $dumpvars(0, RCA_4bits_tb);

        // Initialize
        errors = 0;
        enable = 1'b0;
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;
        @(negedge clk);

        //          A        B       Cin    expected {Cout,S}
        run_vector(4'b0001, 4'b0101, 1'b0,  5'b0_0110);
        run_vector(4'b0111, 4'b0111, 1'b0,  5'b0_1110);
        run_vector(4'b1000, 4'b0111, 1'b1,  5'b1_0000);
        run_vector(4'b1100, 4'b0100, 1'b0,  5'b1_0000);
        run_vector(4'b1000, 4'b1000, 1'b1,  5'b1_0001);
        run_vector(4'b1001, 4'b1010, 1'b1,  5'b1_0100);
        run_vector(4'b1111, 4'b1111, 1'b0,  5'b1_1110);

        if (errors == 0)
            $display("\nAll 7 vectors PASSED.");
        else
            $display("\n%0d vector(s) FAILED.", errors);

        $finish;
    end

endmodule
```

== Simulation Transcript

```
source RCA_4bits_tb.tcl
# set curr_wave [current_wave_config]
# if { [string length $curr_wave] == 0 } {
#   if { [llength [get_objects]] > 0} {
#     add_wave /
#     set_property needs_save false [current_wave_config]
#   } else {
#      send_msg_id Add_Wave-1 WARNING "No top level signals found. Simulator will start without a wave window. If you want to open a wave window go to 'File->New Waveform Configuration' or type 'create_wave_config' in the TCL console."
#   }
# }
# run 1000ns
A=0001 B=0101 Cin=0 | Q=00110 (Cout=0 S=0110) | expected=0_0110 | PASS
A=0111 B=0111 Cin=0 | Q=01110 (Cout=0 S=1110) | expected=0_1110 | PASS
A=1000 B=0111 Cin=1 | Q=10000 (Cout=1 S=0000) | expected=1_0000 | PASS
A=1100 B=0100 Cin=0 | Q=10000 (Cout=1 S=0000) | expected=1_0000 | PASS
A=1000 B=1000 Cin=1 | Q=10001 (Cout=1 S=0001) | expected=1_0001 | PASS
A=1001 B=1010 Cin=1 | Q=10100 (Cout=1 S=0100) | expected=1_0100 | PASS
A=1111 B=1111 Cin=0 | Q=11110 (Cout=1 S=1110) | expected=1_1110 | PASS

All 7 vectors PASSED.
```

== Waveform Screenshot

#figure(
  image("part1-wf.png", width: 100%),
  caption: [
    RCA Waveform
  ],
)

== Demonstration (Live)

= Carry Lookahead Adder

== Derived Expanded Equations for $C_i$

*General Form*

$
C_(n + 1) = G_n + P_n C_n
$

i.e.

$
C_1 &= G_0 + P_0 C_0 \
C_2 &= G_1 + P_1 C_1 \
C_3 &= dots \
$

The fully expanded form,

$
C_1 &= G_0 + P_0 C_0 \
C_2 &= G_1 + P_1 G_0 + P_1 P_0 C_0 \
C_3 &= G_2 + P_2 G_1 + P_2 P_1 G_0 + P_2 P_1 P_0 C_0 \
C_4 &= G_3 + P_3 G_2 + P_3 P_2 G_1 + P_3 P_2 P_1 G_0 + P_3 P_2 P_1 P_0 C_0
$

== Verilog Source

```verilog
//CLA_4bits.v
`timescale 1ns / 1ps
module CLA_4bits(
    input wire clk,
    input wire enable,
    input wire [3:0] A,
    input wire [3:0] B,
    input wire Cin,
    output wire [4:0] Q,
    output wire enable_led
);
    // Your implementation here.
    
    wire [3:0] G;
    wire [3:0] P;
    wire [4:1] C;
    
    assign G = A & B;
    assign P = A ^ B;
    
    assign C[1] = G[0] | (P[0] & Cin);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);
    
    wire [3:0] S;
    wire Cout;
    
    assign S[0] = Cin ^ P[0];
    assign S[1] = C[1] ^ P[1];
    assign S[2] = C[2] ^ P[2];
    assign S[3] = C[3] ^ P[3];
    assign Cout = C[4];
        
    register_logic reg5(
        .clk(clk),
        .enable(enable),
        .Data({Cout, S}),
        .Q(Q)
    );
    
    assign enable_led = enable;
endmodule
```

== Extended Testbench Source

```verilog
//RCA_CLA_equiv_tb.v
`timescale 1ns / 1ps
//======================================================================
// Testbench Extension: RCA vs CLA equivalence
//
//   - Instantiates BOTH adders in parallel:
//         uut_rca : RCA_4bits  (golden model, validated in Part 1)
//         uut_cla : CLA_4bits  (design under test)
//     Both share clk, enable, A, B, Cin; each drives its own Q
//     (Q_rca / Q_cla).
//
//   - A concurrent checker runs on every rising clock edge and fires
//     $error whenever Q_rca and Q_cla disagree. It uses !== so that
//     uninitialized X bits count as matching only when BOTH sides are X.
//     The message prints $time and both Q values so the failing cycle
//     is identifiable.
//
//   - Drives the Part 1 (Table 1) vectors through both DUTs. If the CLA
//     equations are correct, no $error fires.
//======================================================================
module RCA_CLA_equiv_tb;

    // ---- Shared stimulus ----
    reg        clk;
    reg        enable;
    reg  [3:0] A;
    reg  [3:0] B;
    reg        Cin;

    // ---- Separate result buses ----
    wire [4:0] Q_rca;
    wire [4:0] Q_cla;
    wire       led_rca;
    wire       led_cla;

    // ---- Golden model: ripple-carry adder ----
    RCA_4bits uut_rca (
        .clk        (clk),
        .enable     (enable),
        .A          (A),
        .B          (B),
        .Cin        (Cin),
        .Q          (Q_rca),
        .enable_led (led_rca)
    );

    // ---- Design under test: carry-lookahead adder ----
    CLA_4bits uut_cla (
        .clk        (clk),
        .enable     (enable),
        .A          (A),
        .B          (B),
        .Cin        (Cin),
        .Q          (Q_cla),
        .enable_led (led_cla)
    );

    // ---- 100 MHz clock: 10 ns period ----
    initial clk = 1'b0;
    always #5 clk = ~clk;

    //------------------------------------------------------------------
    // Equivalence check (same if/$error form as Lab 2 Part 1).
    // Runs every rising edge. !== so X matches only X on both sides.
    //------------------------------------------------------------------
    always @(posedge clk) begin
        if (Q_rca !== Q_cla)
            $error("Q mismatch at t=%0t ns : Q_rca=%b  Q_cla=%b",
                   $time, Q_rca, Q_cla);
    end

    // ---- Optional golden-model self-check vs Table 1 ----
    integer errors;

    // Apply one vector, hold enable across one rising edge so both
    // DUTs latch, print both results, and re-verify the RCA vs Table 1.
    task run_vector;
        input [3:0] a_in;
        input [3:0] b_in;
        input       cin_in;
        input [4:0] expected;      // {Cout, S}
        begin
            enable = 1'b0;
            A      = a_in;
            B      = b_in;
            Cin    = cin_in;

            @(negedge clk);
            enable = 1'b1;
            @(posedge clk);        // both registers latch here
            #1;                    // let the NBA updates settle

            $display("A=%b B=%b Cin=%b | Q_rca=%b Q_cla=%b | expected=%b_%b | %s",
                     A, B, Cin, Q_rca, Q_cla,
                     expected[4], expected[3:0],
                     (Q_rca === expected) ? "RCA-OK" : "RCA-BAD");

            if (Q_rca !== expected) errors = errors + 1;

            @(negedge clk);
            enable = 1'b0;
        end
    endtask

    initial begin
        // Waveform dump (useful under Icarus Verilog)
        $dumpfile("RCA_CLA_equiv_tb.vcd");
        $dumpvars(0, RCA_CLA_equiv_tb);

        errors = 0;
        enable = 1'b0;
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;
        @(negedge clk);

        //          A        B       Cin    expected {Cout,S}
        run_vector(4'b0001, 4'b0101, 1'b0,  5'b0_0110);
        run_vector(4'b0111, 4'b0111, 1'b0,  5'b0_1110);
        run_vector(4'b1000, 4'b0111, 1'b1,  5'b1_0000);
        run_vector(4'b1100, 4'b0100, 1'b0,  5'b1_0000);
        run_vector(4'b1000, 4'b1000, 1'b1,  5'b1_0001);
        run_vector(4'b1001, 4'b1010, 1'b1,  5'b1_0100);
        run_vector(4'b1111, 4'b1111, 1'b0,  5'b1_1110);

        // Let the last latched value be seen by the posedge checker
        repeat (2) @(posedge clk);

        if (errors == 0)
            $display("\nGolden model (RCA) matched all 7 Table-1 vectors.");
        else
            $display("\nGolden model (RCA) mismatched %0d vector(s).", errors);

        $display("Equivalence run complete: if no $error printed above, RCA == CLA every cycle.");
        $finish;
    end

endmodule
```

== Simulation Transcript

#figure(
  image("part2-wf.png", width: 100%),
  caption: [
    RCA + CLA Waveforms
  ],
)

```
source RCA_CLA_equiv_tb.tcl
# set curr_wave [current_wave_config]
# if { [string length $curr_wave] == 0 } {
#   if { [llength [get_objects]] > 0} {
#     add_wave /
#     set_property needs_save false [current_wave_config]
#   } else {
#      send_msg_id Add_Wave-1 WARNING "No top level signals found. Simulator will start without a wave window. If you want to open a wave window go to 'File->New Waveform Configuration' or type 'create_wave_config' in the TCL console."
#   }
# }
# run 1000ns
A=0001 B=0101 Cin=0 | Q_rca=00110 Q_cla=00110 | expected=0_0110 |  RCA-OK
A=0111 B=0111 Cin=0 | Q_rca=01110 Q_cla=01110 | expected=0_1110 |  RCA-OK
A=1000 B=0111 Cin=1 | Q_rca=10000 Q_cla=10000 | expected=1_0000 |  RCA-OK
A=1100 B=0100 Cin=0 | Q_rca=10000 Q_cla=10000 | expected=1_0000 |  RCA-OK
A=1000 B=1000 Cin=1 | Q_rca=10001 Q_cla=10001 | expected=1_0001 |  RCA-OK
A=1001 B=1010 Cin=1 | Q_rca=10100 Q_cla=10100 | expected=1_0100 |  RCA-OK
A=1111 B=1111 Cin=0 | Q_rca=11110 Q_cla=11110 | expected=1_1110 |  RCA-OK

Golden model (RCA) matched all 7 Table-1 vectors.
Equivalence run complete: if no $error printed above, RCA == CLA every cycle.
```

== Demonstration (Live)

= Comparison: Speed and Area

== Annotated Schematic Screenshots Showing Critical Path

#figure(
  image("rca-schem.png", width: 100%),
  caption: [
    RCA Annotated Critical Path
  ],
)

#figure(
  image("lca-schem.png", width: 100%),
  caption: [
    CLA Annotated Critical Path
  ],
)

== Delay Calculation for Each Design

*RCA*

- 4 AND
- 8 OR

12 total.

$
4 dot 3 + 8 dot 2 = 28 "ns"
$

*CLA*

- 2 XOR
- 1 OR
- 3 AND

6 total.

$
2 dot 3 + 1 dot 2 + 3 dot 3 = 17 "ns"
$

== Area Calculation for Each Design

*RCA*

$
A_("RCA") &= 4 "FA" dot (2 "XOR" + 2 "AND" + 1 "OR") \ 
&= 4 dot (2 dot 6 + 2 dot 4 + 1 dot 4) \
&= 96
$

_note._ this calculation is done using the FA gate-level
description provided in the lab document.

*CLA*

$
A_("CLA") &= 5 "XOR" + 17 "AND" + 10 "OR" \
&= 5 dot 6 + 17 dot 4 + 10 dot 4 \
&= 138
$

== Comparison Table

#table(
  columns: 3,
  table.header[Design][Critical Delay (ns)][Area],
  [RCA],[28],[96],
  [CLA],[17],[138]
)

== Written Conclusion

The trade-off between these two designs are associated with
area and delay. RCA is slower but uses less gates while CLA
is is faster but uses more gates. _We also explored in class
a design involving the naive CLA which is technically the
fastest but uses an unsustainable amount of gates._ As our
bit width increases, we can expect the CLA design to
outperform the RCA in time. A true best solution will
likely involve a hybrid approach, where instead of rippling
each bit, we can ripple the carry between 4-bit or 8-bit 
segments.
