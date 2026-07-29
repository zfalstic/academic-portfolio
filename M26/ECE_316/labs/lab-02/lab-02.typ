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
      Lab 2
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

= Flight Attendant Call System

== State Transition Table

#table(
  columns: 4,
  table.vline(x: 3, stroke: 3pt),
  table.header(
    [call],[cancel],[$Q$],[$D$]
  ),
  [0],[0],[0],[0],
  [0],[0],[1],[1],
  [0],[1],[0],[0],
  [0],[1],[1],[0],
  [1],[0],[0],[1],
  [1],[0],[1],[1],
  [1],[1],[0],[1],
  [1],[1],[1],[1],
)

== Procedural and Dataflow Verilog

*Procedural Verilog*

```verilog
`timescale 1ns / 1ps

module flight_attendant_call_system (
    input wire clk,
    input wire call_button,
    input wire cancel_button,
    output reg light_state
);
    reg next_state;
    
    // Combinational block: next state from current state + inputs.
    always @(*) begin
        case ({call_button, cancel_button, light_state})
            3'b000: next_state = 1'b0;
            3'b001: next_state = 1'b1;
            3'b010: next_state = 1'b0;
            3'b011: next_state = 1'b0;
            3'b100: next_state = 1'b1;
            3'b101: next_state = 1'b1;
            3'b110: next_state = 1'b1;
            3'b111: next_state = 1'b1;
            default: next_state = 1'b0;
        endcase
    end
    
    // Sequential block: latch next state on rising clock edge.
    always @(posedge clk) begin
        light_state <= next_state;
    end
endmodule
```

*Dataflow Verilog*

```verilog
`timescale 1ns / 1ps
module flight_attendant_call_system_dataflow (
    input wire clk,
    input wire call_button,
    input wire cancel_button,
    output reg light_state
);
    wire next_state;
    
    // Combinational block: one assign replacing the entire case statement.
    assign next_state = call_button | ~cancel_button & light_state;
    
    // Sequential block.
    always @(posedge clk) begin
        light_state <= next_state;
    end
endmodule
```

== AI Testbench Prompt

#link("https://claude.ai/share/c7ada5df-d694-4564-9ede-f5689e1bc40f")[Click Here]

```
Follow the instructions in the screenshot carefully and create a simple-but-effective testbench that meets the criteria for the module.
```

#image("ai-testbench-sc.png", width: 70%)

== AI Testbench Code

```verilog
`timescale 1ns / 1ps
//============================================================================
// Testbench: flight_attendant_call_system  (+ dataflow variant)
//
// Drives the SAME stimulus into two implementations of the FSM:
//   * flight_attendant_call_system           (behavioral, case-based)
//   * flight_attendant_call_system_dataflow  (single continuous assign)
// Each check verifies both outputs against the expected value AND confirms
// the two implementations agree with each other (equivalence check).
//
// Verifies the latching call-light FSM:
//   - a call press latches the light ON and it holds after release
//   - a cancel (no call) clears the light
//   - call WINS over cancel when both are pressed
//   - cancelling while the light is already OFF causes no spurious transition
//
// Clock: 100 MHz (10 ns period). Inputs are driven on the negedge so they are
// stable through the sampling posedge; the registered output is checked one
// time-step after the posedge. Simulation ends with $finish.
//============================================================================
module tb_flight_attendant_call_system;

    // ---- DUT connections ----
    reg  clk;
    reg  call_button;
    reg  cancel_button;
    wire light_state;      // behavioral (case-based) DUT output
    wire light_state_df;   // dataflow (single-assign) DUT output

    integer errors = 0;   // running count of failed checks

    // ---- Instantiate the Devices Under Test (same stimulus, both checked) ----
    flight_attendant_call_system dut (
        .clk          (clk),
        .call_button  (call_button),
        .cancel_button(cancel_button),
        .light_state  (light_state)
    );

    flight_attendant_call_system_dataflow dut_df (
        .clk          (clk),
        .call_button  (call_button),
        .cancel_button(cancel_button),
        .light_state  (light_state_df)
    );

    // ---- 100 MHz clock: toggle every 5 ns -> 10 ns full period ----
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // ---- Optional waveform dump (handy for the live demo) ----
    initial begin
        $dumpfile("tb_flight_attendant_call_system.vcd");
        $dumpvars(0, tb_flight_attendant_call_system);
    end

    // ---- Print %t as whole nanoseconds ----
    initial $timeformat(-9, 0, " ns", 8);

    // ------------------------------------------------------------------
    // drive_cycle: apply inputs on the negedge, then advance one full
    // clock so the FSM registers its next state on the posedge.
    // #1 lets the non-blocking update settle before any check runs.
    // ------------------------------------------------------------------
    task drive_cycle(input c, input x);
        begin
            @(negedge clk);
            call_button   = c;
            cancel_button = x;
            @(posedge clk);   // light_state latches next_state here
            #1;               // allow NBA update to settle
        end
    endtask

    // ------------------------------------------------------------------
    // check: verify BOTH implementations against the expected value, and
    // confirm the two agree with each other (behavioral == dataflow).
    // ------------------------------------------------------------------
    task check(input exp, input [639:0] label);
        begin
            if (light_state === exp && light_state_df === exp)
                $display("PASS @%t | %0s | beh=%b df=%b",
                         $time, label, light_state, light_state_df);
            else begin
                $display("FAIL @%t | %0s | beh=%b df=%b (expected %b)",
                         $time, label, light_state, light_state_df, exp);
                errors = errors + 1;
            end
            // Equivalence check: the two designs must never disagree.
            if (light_state !== light_state_df) begin
                $display("   ^ MISMATCH: behavioral and dataflow outputs differ!");
                errors = errors + 1;
            end
        end
    endtask

    // ---- Stimulus ----
    initial begin
        // ---- Establish a known state (no reset port exists) ----
        // light_state powers up as X. A cancel press forces light OFF in
        // BOTH designs: behavioral hits default->0; dataflow gives
        // 0 | (~1 & X) = 0. Idling alone would NOT clear the dataflow X,
        // because its X feeds back through (~cancel & light_state).
        drive_cycle(1'b0, 1'b1);   // cancel -> forces known light = 0
        drive_cycle(1'b0, 1'b0);   // release; light holds at 0
        check(1'b0, "init: cancel establishes known light=0");

        // ---- Scenario 1: clean call, then release (light must HOLD) ----
        drive_cycle(1'b1, 1'b0);   // press call
        check(1'b1, "S1: call press -> light ON");
        drive_cycle(1'b0, 1'b0);   // release call
        check(1'b1, "S1: call released -> light HOLDS ON");

        // ---- Scenario 2: clean cancel after a call (light must clear) ----
        drive_cycle(1'b0, 1'b1);   // press cancel while light is on
        check(1'b0, "S2: cancel press -> light OFF");
        drive_cycle(1'b0, 1'b0);   // release cancel
        check(1'b0, "S2: cancel released -> light stays OFF");

        // ---- Scenario 3: call while cancel is still pressed (CALL WINS) ----
        drive_cycle(1'b0, 1'b1);   // cancel held, light currently off
        check(1'b0, "S3: cancel held, light still OFF");
        drive_cycle(1'b1, 1'b1);   // assert call while cancel STILL pressed
        check(1'b1, "S3: call+cancel -> CALL WINS, light ON");
        drive_cycle(1'b1, 1'b1);   // keep both pressed
        check(1'b1, "S3: both held -> light STAYS ON (call wins)");
        drive_cycle(1'b0, 1'b1);   // drop call, keep cancel -> clears
        check(1'b0, "S3: cleanup, cancel-only -> light OFF");
        drive_cycle(1'b0, 1'b0);   // release everything

        // ---- Scenario 4: press/release cancel while light already 0 ----
        //      (must produce NO spurious transition)
        check(1'b0, "S4: precondition, light is OFF");
        drive_cycle(1'b0, 1'b1);   // press cancel with light off
        check(1'b0, "S4: cancel press, light OFF -> no spurious change");
        drive_cycle(1'b0, 1'b0);   // release cancel
        check(1'b0, "S4: cancel release -> still OFF, no spurious change");

        // ---- Summary ----
        $display("----------------------------------------------------");
        if (errors == 0)
            $display("ALL CHECKS PASSED");
        else
            $display("%0d CHECK(S) FAILED", errors);
        $display("----------------------------------------------------");

        $finish;
    end

endmodule
```

== Live Testbench Walkthrough (Checkout)

== Written Response

This check tests whether the procedural and dataflow ever
disagree.

- != is the logical inequality operator
- !== is the case inequality operator

!= can return 3 different values: 0, 1, or X. If either of the
operands have X or Z bits, the operator returns X.

!== can return only 0 or 1. It compares bitwise every bit, even
X and Z bits.

== Simulation Waveforms

#image("call-waveform.png", width: 100%)

== Live Demonstration (Checkout)

= Rising Edge Detector with Slow Clock

== Three-state FSM Diagram

#image("rising-edge-fsm.png", width: 40%)

== Verilog Modules

*Rising Edge FSM Driver*

```verilog
`timescale 1ns / 1ps
module rising_edge_detector (
    input wire clk,
    input wire signal,
    input wire reset,
    output reg outedge
);
    wire slow_clk;
    reg [1:0] state, next_state;
    
    clkdiv c1(.clk(clk), .reset(reset), .clk_out(slow_clk));
    
    // Combinational logic: next state + output.
    always @(*) begin
        // Hint: use a case statement on the current state.
        case ({state, signal})
            3'b000: begin next_state = 2'b00; outedge = 1'b0; end
            3'b001: begin next_state = 2'b01; outedge = 1'b0; end
            3'b010: begin next_state = 2'b00; outedge = 1'b1; end
            3'b011: begin next_state = 2'b10; outedge = 1'b1; end
            3'b100: begin next_state = 2'b00; outedge = 1'b0; end
            3'b101: begin next_state = 2'b10; outedge = 1'b0; end
            //3'b110: begin next_state = 2'b00; outedge = 1'b0; end
            //3'b111: begin next_state = 2'b00; outedge = 1'b0; end
            default: begin next_state = 2'b00; outedge = 1'b0; end
        endcase
    end
    
    // Sequential logic on the slow clock with asynchronous reset.
    always @(posedge slow_clk or posedge reset) begin
        // Hint: don't forget about the reset signal, which can be handled with an if-statement.
        if (reset) state <= 2'b00;
        else state <= next_state;
    end
endmodule
```

*Clock Divider*

```verilog
`timescale 1ns / 1ps
module clkdiv (
    input wire clk,
    input wire reset,
    output wire clk_out
);
    reg [2:0] COUNT;
    
    assign clk_out = COUNT[2];
    
    always @(posedge clk) begin
        if (reset) COUNT <= 0;
        else COUNT <= COUNT + 1;
    end
endmodule
```

== AI Testbench Prompt

#link("https://claude.ai/share/ad3f1cc6-5936-4f3c-9450-c60f3aac4eb7")[Click Here]

Generate a testbench with your AI tool. Cover at least one full 0 → 1 → 0 cycle on signal and confirm outedge pulses for exactly one slow-clock cycle

== AI Testbench Code

```verilog
`timescale 1ns / 1ps
//============================================================================
// Testbench for rising_edge_detector
//
// Goal (assignment): drive at least one full 0 -> 1 -> 0 cycle on `signal`
// and confirm `outedge` pulses high for EXACTLY one slow-clock cycle.
//
// Strategy:
//   * 100 MHz fast clock (10 ns period).
//   * Pulse async reset, then let the FSM settle in idle (state 00).
//   * Move `signal` 0->1 on a slow-clock NEGEDGE (away from the sampling
//     edge), hold it high several slow clocks, then move it 1->0.
//   * Self-check three independent ways that the pulse is one slow cycle:
//       (a) number of outedge rising edges                == 1
//       (b) number of slow cycles sampled with outedge=1  == 1
//       (c) measured outedge high-time == measured slow-clock period
//============================================================================
module tb_rising_edge_detector;

    // ---- DUT I/O ----
    reg  clk;
    reg  signal;
    reg  reset;
    wire outedge;

    rising_edge_detector dut (
        .clk    (clk),
        .signal (signal),
        .reset  (reset),
        .outedge(outedge)
    );

    // ---- Internal observation taps (hierarchical references) ----
    wire       slow_clk = dut.slow_clk;
    wire [1:0] state    = dut.state;

    // ---- Fast clock: 10 ns period ----
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // ---- Measure the slow-clock period (interval between its posedges) ----
    time t_prev_slow = 0;
    time slow_period = 0;
    always @(posedge slow_clk) begin
        if (t_prev_slow != 0) slow_period = $time - t_prev_slow;
        t_prev_slow = $time;
    end

    // ---- Self-check (b): count slow cycles where outedge is high. ----
    // Sample at the NEGEDGE (mid-cycle) to dodge the combinational race at
    // the active edge where state is updating.
    integer high_cycles = 0;
    always @(negedge slow_clk)
        if (outedge === 1'b1) high_cycles = high_cycles + 1;

    // ---- Self-check (a)+(c): count outedge pulses and measure high-time. ----
    integer out_pulses   = 0;
    time     t_out_rise  = 0;
    time     out_high_ns = 0;
    always @(posedge outedge) begin
        out_pulses = out_pulses + 1;
        t_out_rise = $time;
    end
    always @(negedge outedge)
        out_high_ns = $time - t_out_rise;

    // ---- Helper: advance N slow-clock rising edges ----
    task wait_slow(input integer n);
        integer i;
        begin
            for (i = 0; i < n; i = i + 1) @(posedge slow_clk);
        end
    endtask

    // ---- Stimulus ----
    initial begin
        $timeformat(-9, 0, " ns", 8);   // print %t values in whole ns
        $dumpfile("tb_red.vcd");
        $dumpvars(0, tb_rising_edge_detector);

        // Reset (async on the detector, holds COUNT/state at 0)
        reset  = 1'b1;
        signal = 1'b0;
        repeat (4) @(posedge clk);
        reset = 1'b0;
        $display("[%t] reset released   | state=%b signal=%b outedge=%b",
                 $time, state, signal, outedge);

        // Settle in idle so the rising edge below is a clean 0->1
        wait_slow(2);
        $display("[%t] idle settled     | state=%b signal=%b outedge=%b",
                 $time, state, signal, outedge);

        // ---- Rising edge: signal 0 -> 1 ----
        @(negedge slow_clk);
        signal = 1'b1;
        $display("[%t] signal 0->1      | state=%b signal=%b outedge=%b",
                 $time, state, signal, outedge);

        // Next slow edge samples the edge: 00 -> 01, outedge asserts.
        // Sample just past the edge (#1) so the FSM update is visible.
        @(posedge slow_clk); #1;
        $display("[%t] +1 slow clk      | state=%b signal=%b outedge=%b  <-- PULSE",
                 $time, state, signal, outedge);
        // Following slow edge: 01 -> 10, outedge de-asserts.
        @(posedge slow_clk); #1;
        $display("[%t] +1 slow clk      | state=%b signal=%b outedge=%b  <-- pulse over",
                 $time, state, signal, outedge);
        wait_slow(2);
        $display("[%t] held high        | state=%b signal=%b outedge=%b",
                 $time, state, signal, outedge);

        // ---- Falling edge: signal 1 -> 0 ----
        @(negedge slow_clk);
        signal = 1'b0;
        $display("[%t] signal 1->0      | state=%b signal=%b outedge=%b",
                 $time, state, signal, outedge);
        wait_slow(3);

        // ---- Report / self-check ----
        $display("----------------------------------------------------------------");
        $display("slow-clock period           = %t", slow_period);
        $display("outedge rising-edge count   = %0d (expect 1)", out_pulses);
        $display("slow cycles with outedge=1  = %0d (expect 1)", high_cycles);
        $display("outedge high-time           = %t (expect == slow period)", out_high_ns);
        if (out_pulses == 1 && high_cycles == 1 && out_high_ns == slow_period)
            $display("RESULT: PASS -- outedge pulsed once for exactly one slow-clock cycle.");
        else
            $display("RESULT: FAIL -- see counts above.");
        $display("----------------------------------------------------------------");
        $finish;
    end

    // Safety timeout
    initial begin
        #50000;
        $display("RESULT: FAIL -- timeout (slow_clk never toggled?).");
        $finish;
    end
endmodule
```

== Live Testbench Walkthrough (Checkout)

== Simulation Waveforms

#image("rising-edge-waveform.png", width: 100%)

== Written Response

Chose a 27-bit counter for implementation because it is
approximately $1 "Hz"$. 

Chose a 2-bit counter for simulation because we need it fast
enough to be able to finish all the cases before the $1000 "ns"$
simulation ending.

== Live Demonstration (Checkout)

= Time Multiplexed 4-Digit Display

== Verilog Modules

*Hex to 7 Segment*

```verilog
`timescale 1ns / 1ps
module hexto7segment (
    input  wire [3:0]   in,
    output reg  [6:0]   out
);
    always @(*) begin
        case (in)
            4'd0:  out = 7'b0000001;
            4'd1:  out = 7'b1001111;
            4'd2:  out = 7'b0010010;
            4'd3:  out = 7'b0000110;
            4'd4:  out = 7'b1001100;
            4'd5:  out = 7'b0100100;
            4'd6:  out = 7'b0100000;
            4'd7:  out = 7'b0001111;
            4'd8:  out = 7'b0000000;
            4'd9:  out = 7'b0000100;
            4'd10: out = 7'b0001000;
            4'd11: out = 7'b1100000;
            4'd12: out = 7'b0110001;
            4'd13: out = 7'b1000010;
            4'd14: out = 7'b0110000;
            4'd15: out = 7'b0111000;
            default: out = 7'b1111110;
        endcase
    end
endmodule
```

*State Machine*

```verilog
`timescale 1ns / 1ps
module time_mux_state_machine (
    input  wire         clk, reset,
    input  wire [6:0]   in0, in1, in2, in3,
    output reg  [3:0]   an,
    output reg  [6:0]   sseg
);
    reg [1:0] state, next_state;
    
    // State Transition Combinational
    always @(*) begin
        case (state)
            2'd0:       next_state = 2'd1;
            2'd1:       next_state = 2'd2;
            2'd2:       next_state = 2'd3;
            2'd3:       next_state = 2'd0;
            default:    next_state = 2'd0;
        endcase
    end
    
    // Anode Output Combinational
    always @(*) begin
        case (state)
            2'd0:       an = 4'b1110;
            2'd1:       an = 4'b1101;
            2'd2:       an = 4'b1011;
            2'd3:       an = 4'b0111;
            default:    an = 4'b1111;
        endcase
    end
    
    // SSEG Output Combinational
    always @(*) begin
        case (state)
            2'd0:       sseg = in0;
            2'd1:       sseg = in1;
            2'd2:       sseg = in2;
            2'd3:       sseg = in3;
            default:    sseg = 7'b1111111;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) state <= 2'd0;
        else state <= next_state;
    end
endmodule
```

*Top Module*

```verilog
`timescale 1ns / 1ps
module time_multiplexing_main (
    input  wire         clk, reset,
    input  wire [15:0]  sw,
    output wire [3:0]   an,
    output wire [6:0]   sseg,
    output wire         slow_clk
);
    wire [6:0] in0, in1, in2, in3;
    
    hexto7segment h0 (.in(sw[3:0])  , .out(in0));
    hexto7segment h1 (.in(sw[7:4])  , .out(in1));
    hexto7segment h2 (.in(sw[11:8]) , .out(in2));
    hexto7segment h3 (.in(sw[15:12]), .out(in3));
    
    clkdiv_disp c0 (.clk(clk), .reset(reset), .clk_out(slow_clk));
    
    time_mux_state_machine fsm (
        .clk(slow_clk), .reset(reset),
        .in0(in0), .in1(in1), .in2(in2), .in3(in3),
        .an(an), .sseg(sseg)
    );
endmodule
```

== AI Testbench Prompt

#link("https://claude.ai/share/84953150-ffaa-47f4-abcb-375ed7d5aed6")[Click Here]

```
Generate a testbench with your AI tool. The testbench should hold the 16 switches at a
recognizable pattern (e.g. 0x1234) and run long enough for the FSM to cycle through all four
states twice.
```

== AI Testbench Code

```verilog
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench: tb_time_multiplexing_main
//
// Drives the TOP module (time_multiplexing_main) so the 16 switches flow through
// the hexto7segment decoders into the FSM, exactly like on the board.
//
//   * Holds sw = 0x1234 (a recognizable pattern) for the whole run.
//   * Lets the real clkdiv_disp generate slow_clk (= COUNT[19]).
//   * Follows the FSM through 8 rising edges of slow_clk = all four states twice.
//   * Self-checks an[] and sseg[] against an in-testbench reference model and
//     prints a PASS/FAIL summary, so you do NOT need to read the waveform.
//
// NOTE ON RUNTIME: slow_clk toggles every 2^19 fast-clock cycles, so a single
// slow_clk rising edge is ~2^20 = 1,048,576 clk cycles apart. Eight edges is
// ~7.9 million clk cycles (~79 ms of sim time at 100 MHz). The run finishes on
// its own via $finish; just read the console log.
//////////////////////////////////////////////////////////////////////////////////

module tb_time_multiplexing_main;

    // ---------------- DUT I/O ----------------
    reg         clk;
    reg         reset;
    reg  [15:0] sw;
    wire [3:0]  an;
    wire [6:0]  sseg;
    wire        slow_clk;

    // Recognizable switch pattern (change this and the checker still follows)
    localparam [15:0] SW_PATTERN = 16'h1234;

    // ---------------- Device Under Test ----------------
    time_multiplexing_main uut (
        .clk(clk), .reset(reset), .sw(sw),
        .an(an), .sseg(sseg), .slow_clk(slow_clk)
    );

    // ---------------- 100 MHz clock (10 ns period) ----------------
    initial clk = 1'b0;
    always  #5 clk = ~clk;

    // ---------------- Reference models (mirror the RTL) ----------------
    // 7-segment decode, identical to hexto7segment.v
    function [6:0] seg7;
        input [3:0] h;
        begin
            case (h)
                4'd0:  seg7 = 7'b0000001;
                4'd1:  seg7 = 7'b1001111;
                4'd2:  seg7 = 7'b0000010;
                4'd3:  seg7 = 7'b0000110;
                4'd4:  seg7 = 7'b1001100;
                4'd5:  seg7 = 7'b0100100;
                4'd6:  seg7 = 7'b1100000;
                4'd7:  seg7 = 7'b0001111;
                4'd8:  seg7 = 7'b0000000;
                4'd9:  seg7 = 7'b0000100;
                4'd10: seg7 = 7'b0001000;
                4'd11: seg7 = 7'b1100000;
                4'd12: seg7 = 7'b0110001;
                4'd13: seg7 = 7'b1000010;
                4'd14: seg7 = 7'b1001111;
                4'd15: seg7 = 7'b0111000;
                default: seg7 = 7'b1111110;
            endcase
        end
    endfunction

    // The nibble of SW_PATTERN that a given state displays
    function [3:0] nibble_of;
        input [1:0] s;
        begin
            case (s)
                2'd0: nibble_of = SW_PATTERN[3:0];
                2'd1: nibble_of = SW_PATTERN[7:4];
                2'd2: nibble_of = SW_PATTERN[11:8];
                2'd3: nibble_of = SW_PATTERN[15:12];
                default: nibble_of = 4'hF;
            endcase
        end
    endfunction

    // Expected anode pattern per state (active-low one-cold)
    function [3:0] exp_an;
        input [1:0] s;
        begin
            case (s)
                2'd0: exp_an = 4'b1110;
                2'd1: exp_an = 4'b1101;
                2'd2: exp_an = 4'b1011;
                2'd3: exp_an = 4'b0111;
                default: exp_an = 4'b1111;
            endcase
        end
    endfunction

    // Expected sseg per state
    function [6:0] exp_sseg;
        input [1:0] s;
        begin
            exp_sseg = seg7(nibble_of(s));
        end
    endfunction

    // ---------------- Bookkeeping ----------------
    integer edge_count;
    integer errors;
    reg [1:0] exp_state;

    // Compare DUT outputs against the reference for an expected state
    task check_outputs;
        input [1:0] s;
        begin
            if (an !== exp_an(s) || sseg !== exp_sseg(s)) begin
                errors = errors + 1;
                $display("  [MISMATCH] state=%0d  an=%b (exp %b)  sseg=%b (exp %b)",
                          s, an, exp_an(s), sseg, exp_sseg(s));
            end else begin
                $display("  [OK]  state=%0d  an=%b  sseg=%b  -> digit 0x%0h",
                          s, an, sseg, nibble_of(s));
            end
        end
    endtask

    // ---------------- Stimulus ----------------
    initial begin
`ifdef DUMP
        // Optional VCD. Heavy at this clock rate -- enable with -DDUMP only if
        // you really want a waveform. Dumps just the FSM internals + tb signals.
        $dumpfile("tb_time_multiplexing_main.vcd");
        $dumpvars(1, tb_time_multiplexing_main);
        $dumpvars(1, uut.fsm);
`endif

        $timeformat(-3, 3, " ms", 10);   // print times in milliseconds

        errors     = 0;
        exp_state  = 2'd0;
        sw         = SW_PATTERN;   // hold switches for the entire simulation

        // Apply reset for a few clocks, release on a falling edge
        reset = 1'b1;
        repeat (4) @(posedge clk);
        @(negedge clk);
        reset = 1'b0;

        $display("\n==============================================================");
        $display(" Holding sw = 0x%h   (expected display walks: 1 2 3 4)", SW_PATTERN);
        $display(" Reset released; FSM should start in state 0.");
        $display("==============================================================\n");

        // State 0 is shown immediately after reset, before any slow_clk edge.
        #1;
        $display("Post-reset (state 0):");
        check_outputs(2'd0);

        // Follow 8 slow_clk rising edges => states 1,2,3,0,1,2,3,0
        // (combined with the post-reset state 0, every state is seen twice).
        for (edge_count = 1; edge_count <= 8; edge_count = edge_count + 1) begin
            @(posedge slow_clk);
            #1;                                 // let combinational outputs settle
            exp_state = exp_state + 2'd1;       // 0->1->2->3->0 ...
            $display("slow_clk edge #%0d (t = %t):", edge_count, $realtime);
            check_outputs(exp_state);
        end

        $display("\n==============================================================");
        if (errors == 0)
            $display(" RESULT: PASS - FSM cycled through all four states twice; "
                     , "all an/sseg outputs correct.");
        else
            $display(" RESULT: FAIL - %0d mismatch(es) detected.", errors);
        $display("==============================================================\n");

        $finish;
    end

    // Safety net: never hang forever (covers > 10 slow_clk periods worth of time)
    initial begin
        #120_000_000;  // 120 ms in ns
        $display("TIMEOUT: simulation ran too long without finishing.");
        $finish;
    end

endmodule
```

== Live Testbench Walkthrough (Checkout)

== Simulation Waveforms

#image("sseg-waveform.png", width: 100%)

== Written Response

The way we found our ideal counter width is the following:

- We know that Basys3 clock is $100 dot 10^6 "Hz"$
- Clock divide's time period is equal to $2^"bits"$
- 4 States in state machine, so an entire time period of the
  state machine would be $2^"bits" dot 4$

With this, we can arrive at the following:

$
"Desired Frequency" = (100 dot 10^6) / (2^"bits" dot 4)
$

#table(
  columns: 2,
  table.header(
    [bits],[frequency]
  ),
  [16],[381.47],
  [17],[190.73],
  [18],[95.37],
)

We chose a width of 17, feels about right between too fast and
too slow.

== Live Demonstration (Checkout)
