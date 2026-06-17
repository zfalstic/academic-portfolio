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
      Lab 1 B
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

= 2-Input AND Gate

== Screenshot of Synthesized Schematic

#figure(
  image("and-gate-schematic.png", width: 70%),
  caption: [
    Screenshot of Synthesized Schematic
  ],
)

== Video Demonstration

#link("https://drive.google.com/file/d/1wM2-M7C29_VaxpRohxAqnxXQMSv6Vy30/view?usp=sharing")[
Click Here
]

== Written Response

Synthesis #math.arrow Implementation #math.arrow Generate
Bitstream is the chronological flow of how verilog description
(code) gets converted to gate-level netlists, assigned to 
board-specific connections, and converted to a final executable
that can be flashed.

Each of these stages is part of the critical execution path.
The output of synthesis is used in implementation. The output
of implmentation is used in the input of generate bitstream.
This order can't be rearranged and substituted.

Each level is a step in getting verilog code closer to something
a FPGA can take in as an input. Synthesis takes abstract
hardware descriptions and creates a list of gate-level connections.
Implementation optimizes those connections and configures it
to be specific to a particular FPGA board model and make. Generate
Bitstream is the final step that outputs an executable that 
can be read by a FPGA board.

= Sprinkler Valve Controller on Hardware

== Video Demonstration

#link("https://drive.google.com/file/d/1uLDI76IGjkmhSbQxJg8No78UxeIQRwrF/view?usp=sharing")[
Click Here
]

= BCD-to-7-Segment Decoder

== Truth Table

#let seven-segment-tt = table(
  columns: 11,
  table.vline(x: 4, stroke: 3pt),
  table.header(
    [$w$], [$x$], [$y$], [$z$], [$a$], [$b$], [$c$], [$d$], [$e$], [$f$], [$g$],
  ),
  [0],[0],[0],[0],  [0],[0],[0],[0],[0],[0],[1],
  [0],[0],[0],[1],  [1],[0],[0],[1],[1],[1],[1],
  [0],[0],[1],[0],  [0],[0],[1],[0],[0],[1],[0],
  [0],[0],[1],[1],  [0],[0],[0],[0],[1],[1],[0],
  [0],[1],[0],[0],  [1],[0],[0],[1],[1],[0],[0],
  [0],[1],[0],[1],  [0],[1],[0],[0],[1],[0],[0],
  [0],[1],[1],[0],  [0],[1],[0],[0],[0],[0],[0],
  [0],[1],[1],[1],  [0],[0],[0],[1],[1],[1],[1],
  [1],[0],[0],[0],  [0],[0],[0],[0],[0],[0],[0],
  [1],[0],[0],[1],  [0],[0],[0],[1],[1],[0],[0],
) 

#figure(caption: [Complete Seven Segment Truth Table], seven-segment-tt)

== SOP Equations

#table(
  columns: 3,
  table.header[Output][k-map][Simplified Equation],
  [$a$], image("a.png", width: 2in), [$x y' z' + w' x' y' z$],
  [$b$], image("b.png", width: 2in), [$x y' z + x y z'$],
  [$c$], image("c.png", width: 2in), [$x' y z'$],
  [$d$], image("d.png", width: 2in), [$x y' z' + x' y' z + x y z$],
  [$e$], image("e.png", width: 2in), [$z + x y'$],
  [$f$], image("f.png", width: 2in), [$w' x' z + y z + w' x' y$],
  [$g$], image("g.png", width: 2in), [$w' x' y' + x y z$],
)

== Verilog Source

#let seven-seg-module = ```verilog
// seven_segment.v

module seven_segment(
    input wire w, x, y, z,
    output wire seg_a, seg_b, seg_c, seg_d, 
    seg_e, seg_f, seg_g, an0, an1, an2, an3
);
    
reg [6:0]temp_out;    
assign {seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g} = temp_out;

assign an0 = 1'b1;
assign an1 = 1'b0;
assign an2 = 1'b1;
assign an3 = 1'b1;

always @(*) begin
    case ({w, x, y, z})
        4'b0000: temp_out = 7'b0000001;
        4'b0001: temp_out = 7'b1001111;
        4'b0010: temp_out = 7'b0010010;
        4'b0011: temp_out = 7'b0000110;
        4'b0100: temp_out = 7'b1001100;
        4'b0101: temp_out = 7'b0100100;
        4'b0110: temp_out = 7'b0100000;
        4'b0111: temp_out = 7'b0001111;
        4'b1000: temp_out = 7'b0000000;
        4'b1001: temp_out = 7'b0001100;
        default: temp_out = 7'b1111111;
    endcase
end
endmodule
```

#figure(caption: [Seven Segment Module], seven-seg-module)

== Testbench Source

```verilog
// seven_segment_tb.v

module seven_segment_tb;

    // ----- DUT connections -----
    reg  w, x, y, z;
    wire a, b, c, d, e, f, g;

    // Pack the DUT outputs for convenient comparison/printing.
    wire [6:0] actual = {a, b, c, d, e, f, g};

    // ----- Bookkeeping -----
    integer i;
    integer errors;
    reg [6:0] expected;

    // ----- Instantiate the Device Under Test -----
    seven_segment dut (
        .w(w), .x(x), .y(y), .z(z),
        .a_seg(a), .b_seg(b), .c_seg(c), .d_seg(d), .e_seg(e), .f_seg(f), .g_seg(g)
    );

    // ----- Golden model: expected active-low pattern for each value -----
    function [6:0] ref_segments;
        input [3:0] value;
        begin
            case (value)
                4'd0: ref_segments = 7'b0000001; // 0
                4'd1: ref_segments = 7'b1001111; // 1
                4'd2: ref_segments = 7'b0010010; // 2
                4'd3: ref_segments = 7'b0000110; // 3
                4'd4: ref_segments = 7'b1001100; // 4
                4'd5: ref_segments = 7'b0100100; // 5
                4'd6: ref_segments = 7'b0100000; // 6
                4'd7: ref_segments = 7'b0001111; // 7
                4'd8: ref_segments = 7'b0000000; // 8
                4'd9: ref_segments = 7'b0001100; // 9
                default: ref_segments = 7'b1111111; // A..F -> blank
            endcase
        end
    endfunction

    initial begin
        // Optional waveform dump (works in xsim / iverilog).
        $dumpfile("seven_segment_tb.vcd");
        $dumpvars(0, seven_segment_tb);

        errors = 0;

        $display("");
        $display(" time | wxyz | dec | abcdefg | expected | result");
        $display("------+------+-----+---------+----------+-------");

        for (i = 0; i < 16; i = i + 1) begin
            {w, x, y, z} = i[3:0];   // drive the next combination
            expected = ref_segments(i[3:0]);
            #10;                     // let the combinational logic settle

            if (actual === expected) begin
                $display("%5t | %b%b%b%b |  %2d | %b | %b |  PASS",
                          $time, w, x, y, z, i, actual, expected);
            end else begin
                errors = errors + 1;
                $display("%5t | %b%b%b%b |  %2d | %b | %b |  FAIL <--",
                          $time, w, x, y, z, i, actual, expected);
            end
        end

        $display("------+------+-----+---------+----------+-------");
        if (errors == 0)
            $display("RESULT: all 16 input combinations PASSED.");
        else
            $display("RESULT: %0d of 16 input combinations FAILED.", errors);
        $display("");

        $finish;
    end

endmodule
```

== Testbench Generation

_Prompt._ 

```
Generate a testbench for this seven-segment display. Test relevant cases for the input combinations.
```

_Conversation._

#link("https://claude.ai/share/1f2a0fc5-ed82-483a-b447-6e835aef0d02")[
Click Here
]

== Waveform Simulation

#figure(
  image("seven-seg-waveform.png", width: 100%),
  caption: [
    Seven Segment Testbench Waveform
  ],
)

== Video Demonstration

#link("https://drive.google.com/file/d/13J7m2ad99YUZdNnUF3RxBJ730TWKLAw6/view?usp=sharing")[
  Click Here
]
