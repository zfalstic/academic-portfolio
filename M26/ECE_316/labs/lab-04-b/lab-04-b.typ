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
      Lab 4
    ]
  ],
  //bibliography: bibliography("refs.bib"),
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  paper-size: "us-letter",
)

#set math.equation(numbering: none)

= Deliverables

== All Verilog Source Files and Module Hierarchy

- datapath_top
  - clk_20 : clkdiv_20
  - fsm : fsm_controller
  - c_ed : rising_edge_detector
  - user_submit_ed : rising_edge_detector
  - timer : down_counter
  - leds : led_top
    - pulse_controller : led_pulse_controller
    - left_shift : pulse_left_shift
  - idle : idle_top
  - level : level_top
    - lfsr : lfsr_3bit
    - mux : mux_14bit_8to1
  - game : game_top
    - u_ed : rising_edge_detector
    - d_ed : rising_edge_detector
    - l_ed : rising_edge_detector
    - e_ed : rising_edge_detector
    - game : game_controller
  - user_timer : up_counter
  - score : score_top
    - bin2bcd : bin_to_bcd_11bits
    - thou_bcd2sseg : bcd_to_sseg
    - hund_bcd2sseg : bcd_to_sseg
    - tens_bcd2sseg : bcd_to_sseg
    - ones_bcd2sseg : bcd_to_sseg
    - mux : mux_28bit_2to1
  - seg_mux : mux_28bit_4to1
  - sseg : seven_segment_top
    - disp_clk : clkdiv_disp
    - fsm : time_mux_state_machine

_See submission attachment for source code._

#pagebreak()

== AI Prompts and Conversation Links for Every Testbench

```
I want you to make testbenches for the following modules:

* The top level datapath: datapath_top
* fsm_controller
* Main 4 fsm states:
   * idle_top
   * level_top
   * game_top
   * score_top (include bin_to_bcd and bcd_to_sseg)
* up_counter
* down_counter
* seven_segment_top
* led_top


Implement any "variable" timing changes necessary to be able to have the testbench simulation execute within 1,000,000 ns. The existing simulation can also be ignored/discarded if necessary. 
```

_Link not available in Claude Code session. Check attachments
for testbench files._

== Unit-Test Simulation Waveforms

#figure(
  image("idle-state-tb.png", width: 100%),
  caption: [
    Idle State TB
  ],
)

#figure(
  image("level-state-tb.png", width: 100%),
  caption: [
    Level State TB
  ],
)

#figure(
  image("game-state-tb.png", width: 100%),
  caption: [
    Game State TB
  ],
)

#figure(
  image("score-state-tb.png", width: 100%),
  caption: [
    Score State TB
  ],
)

#figure(
  image("down-counter-tb.png", width: 100%),
  caption: [
    Down Counter TB
  ],
)

#figure(
  image("up-counter-tb.png", width: 100%),
  caption: [
    Up Counter TB
  ],
)

#figure(
  image("sseg-tb.png", width: 100%),
  caption: [
    Seven Segment TB
  ],
)

#figure(
  image("led-tb.png", width: 100%),
  caption: [
    LED TB
  ],
)

== Integration-Test Simulation Waveforms

#figure(
  image("fsm-controller-tb.png", width: 100%),
  caption: [
    FSM Controller TB
  ],
)

#pagebreak()

== Synthesis and Implementation Reports

```
#-----------------------------------------------------------
# Vivado v2025.2 (64-bit)
# SW Build 6299465 on Fri Nov 14 19:35:11 GMT 2025
# IP Build 6300035 on Fri Nov 14 10:48:45 MST 2025
# SharedData Build 6298862 on Thu Nov 13 04:50:51 MST 2025
# Start of session at: Thu Jul 23 23:41:27 2026
# Process ID         : 14684
# Current directory  : C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.runs/synth_1
# Command line       : vivado.exe -log datapath_top.vds -product Vivado -mode batch -messageDb vivado.pb -notrace -source datapath_top.tcl
# Log file           : C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.runs/synth_1/datapath_top.vds
# Journal file       : C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.runs/synth_1\vivado.jou
# Running On         : DawsonA14
# Platform           : Windows Server 2016 or Windows 10
# Operating System   : 26200
# Processor Detail   : AMD Ryzen AI 9 HX 370 w/ Radeon 890M           
# CPU Frequency      : 2000 MHz
# CPU Physical cores : 12
# CPU Logical cores  : 24
# Host memory        : 33413 MB
# Swap memory        : 2147 MB
# Total Virtual      : 35561 MB
# Available Virtual  : 18672 MB
#-----------------------------------------------------------
source datapath_top.tcl -notrace
Command: read_checkpoint -auto_incremental -incremental {C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/utils_1/imports/synth_1/rising_edge_detector.dcp}
INFO: [Vivado 12-5825] Read reference checkpoint from C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/utils_1/imports/synth_1/rising_edge_detector.dcp for incremental synthesis
INFO: [Vivado 12-7989] Please ensure there are no constraint changes
Command: synth_design -top datapath_top -part xc7a35tcpg236-1
Starting synth_design
Attempting to get a license for feature 'Synthesis' and/or device 'xc7a35t'
INFO: [Common 17-349] Got license for feature 'Synthesis' and/or device 'xc7a35t'
INFO: [Device 21-403] Loading part xc7a35tcpg236-1
INFO: [Designutils 20-5440] No compile time benefit to using incremental synthesis; A full resynthesis will be run
INFO: [Designutils 20-4379] Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}
INFO: [Synth 8-7079] Multithreading enabled for synth_design using a maximum of 2 processes.
INFO: [Synth 8-7078] Launching helper process for spawning children vivado processes
INFO: [Synth 8-7075] Helper process launched with PID 21644
---------------------------------------------------------------------------------
Starting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:04 . Memory (MB): peak = 1261.262 ; gain = 541.992
---------------------------------------------------------------------------------
INFO: [Synth 8-6157] synthesizing module 'datapath_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/datapath_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'clkdiv_20' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/clkdiv_20.v:2]
    Parameter BIT bound to: 20 - type: integer 
INFO: [Synth 8-6155] done synthesizing module 'clkdiv_20' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/clkdiv_20.v:2]
INFO: [Synth 8-6157] synthesizing module 'fsm_controller' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/fsm_controller.v:2]
INFO: [Synth 8-6155] done synthesizing module 'fsm_controller' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/fsm_controller.v:2]
INFO: [Synth 8-6157] synthesizing module 'rising_edge_detector' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/rising_edge_detector.v:2]
INFO: [Synth 8-6155] done synthesizing module 'rising_edge_detector' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/rising_edge_detector.v:2]
INFO: [Synth 8-6157] synthesizing module 'down_counter' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/down_counter.v:2]
INFO: [Synth 8-6155] done synthesizing module 'down_counter' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/down_counter.v:2]
INFO: [Synth 8-6157] synthesizing module 'led_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/led_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'led_pulse_controller' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/led_pulse_controller.v:2]
INFO: [Synth 8-6155] done synthesizing module 'led_pulse_controller' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/led_pulse_controller.v:2]
INFO: [Synth 8-6157] synthesizing module 'pulse_left_shift' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/pulse_left_shift.v:2]
INFO: [Synth 8-6155] done synthesizing module 'pulse_left_shift' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/pulse_left_shift.v:2]
INFO: [Synth 8-6155] done synthesizing module 'led_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/led_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'idle_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/idle_top.v:2]
INFO: [Synth 8-6155] done synthesizing module 'idle_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/idle_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'level_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/level_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'lfsr_3bit' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/lfsr_3bit.v:2]
INFO: [Synth 8-6155] done synthesizing module 'lfsr_3bit' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/lfsr_3bit.v:2]
INFO: [Synth 8-6157] synthesizing module 'mux_14bit_8to1' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_14bit_8to1.v:2]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_14bit_8to1.v:9]
INFO: [Synth 8-6155] done synthesizing module 'mux_14bit_8to1' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_14bit_8to1.v:2]
INFO: [Synth 8-6155] done synthesizing module 'level_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/level_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'game_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/game_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'game_controller' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/game_controller.v:2]
INFO: [Synth 8-6155] done synthesizing module 'game_controller' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/game_controller.v:2]
INFO: [Synth 8-6155] done synthesizing module 'game_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/game_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'up_counter' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/up_counter.v:2]
INFO: [Synth 8-6155] done synthesizing module 'up_counter' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/up_counter.v:2]
INFO: [Synth 8-6157] synthesizing module 'score_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/score_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'bin_to_bcd_11bits' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/bin_to_bcd_11bit.v:2]
INFO: [Synth 8-6155] done synthesizing module 'bin_to_bcd_11bits' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/bin_to_bcd_11bit.v:2]
INFO: [Synth 8-6157] synthesizing module 'bcd_to_sseg' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/bcd_to_sseg.v:2]
INFO: [Synth 8-6155] done synthesizing module 'bcd_to_sseg' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/bcd_to_sseg.v:2]
INFO: [Synth 8-6157] synthesizing module 'mux_28bit_2to1' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_2to1.v:2]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_2to1.v:9]
INFO: [Synth 8-6155] done synthesizing module 'mux_28bit_2to1' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_2to1.v:2]
INFO: [Synth 8-6155] done synthesizing module 'score_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/score_top.v:2]
INFO: [Synth 8-6157] synthesizing module 'mux_28bit_4to1' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_4to1.v:2]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_4to1.v:9]
INFO: [Synth 8-6155] done synthesizing module 'mux_28bit_4to1' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/mux_28bit_4to1.v:2]
INFO: [Synth 8-6157] synthesizing module 'seven_segment_top' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/seven_segment_top.v:3]
INFO: [Synth 8-6157] synthesizing module 'clkdiv_disp' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/clkdiv_disp.v:2]
    Parameter BIT bound to: 17 - type: integer 
INFO: [Synth 8-6155] done synthesizing module 'clkdiv_disp' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/clkdiv_disp.v:2]
INFO: [Synth 8-6157] synthesizing module 'time_mux_state_machine' [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/time_mux_state_machine.v:2]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/time_mux_state_machine.v:12]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/time_mux_state_machine.v:23]
INFO: [Synth 8-226] default block is never used [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/time_mux_state_machine.v:34]
INFO: [Synth 8-6155] done synthesizing module 'time_mux_state_machine' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/imports/new/time_mux_state_machine.v:2]
INFO: [Synth 8-6155] done synthesizing module 'seven_segment_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/seven_segment_top.v:3]
INFO: [Synth 8-6155] done synthesizing module 'datapath_top' (0#1) [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/sources_1/new/datapath_top.v:2]
WARNING: [Synth 8-7129] Port clk in module score_top is either unconnected or has no load
WARNING: [Synth 8-7129] Port reset in module score_top is either unconnected or has no load
WARNING: [Synth 8-7129] Port clk in module idle_top is either unconnected or has no load
WARNING: [Synth 8-7129] Port reset in module idle_top is either unconnected or has no load
---------------------------------------------------------------------------------
Finished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1382.832 ; gain = 663.562
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Handling Custom Attributes
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1382.832 ; gain = 663.562
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1382.832 ; gain = 663.562
---------------------------------------------------------------------------------
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.006 . Memory (MB): peak = 1382.832 ; gain = 0.000
INFO: [Project 1-570] Preparing netlist for logic optimization

Processing XDC Constraints
Initializing timing engine
Parsing XDC File [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/constrs_1/imports/Vivado/Basys-3-Master.xdc]
Finished Parsing XDC File [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/constrs_1/imports/Vivado/Basys-3-Master.xdc]
INFO: [Project 1-236] Implementation specific constraints were found while reading constraint file [C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.srcs/constrs_1/imports/Vivado/Basys-3-Master.xdc]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [.Xil/datapath_top_propImpl.xdc].
Resolution: To avoid this warning, move constraints listed in [.Xil/datapath_top_propImpl.xdc] to another XDC file and exclude this new file from synthesis with the used_in_synthesis property (File Properties dialog in GUI) and re-run elaboration/synthesis.
Completed Processing XDC Constraints

Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1456.164 ; gain = 0.000
INFO: [Project 1-111] Unisim Transformation Summary:
No Unisim elements were transformed.

Constraint Validation Runtime : Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.005 . Memory (MB): peak = 1456.164 ; gain = 0.000
INFO: [Designutils 20-5440] No compile time benefit to using incremental synthesis; A full resynthesis will be run
INFO: [Designutils 20-4379] Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}
---------------------------------------------------------------------------------
Finished Constraint Validation : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1456.164 ; gain = 736.895
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Loading Part and Timing Information
---------------------------------------------------------------------------------
Loading part: xc7a35tcpg236-1
---------------------------------------------------------------------------------
Finished Loading Part and Timing Information : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1456.164 ; gain = 736.895
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Applying 'set_property' XDC Constraints
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1456.164 ; gain = 736.895
---------------------------------------------------------------------------------
INFO: [Synth 8-802] inferred FSM for state register 'state_reg' in module 'time_mux_state_machine'
---------------------------------------------------------------------------------------------------
                   State |                     New Encoding |                Previous Encoding 
---------------------------------------------------------------------------------------------------
                  iSTATE |                               00 |                               00
                 iSTATE0 |                               01 |                               01
                 iSTATE1 |                               10 |                               10
                 iSTATE2 |                               11 |                               11
---------------------------------------------------------------------------------------------------
INFO: [Synth 8-3354] encoded FSM with state register 'state_reg' using encoding 'sequential' in module 'time_mux_state_machine'
---------------------------------------------------------------------------------
Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:12 . Memory (MB): peak = 1456.164 ; gain = 736.895
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start RTL Component Statistics 
---------------------------------------------------------------------------------
Detailed RTL Component Info : 
+---Adders : 
       2 Input   10 Bit       Adders := 1     
       2 Input    4 Bit       Adders := 21    
+---XORs : 
       2 Input     14 Bit         XORs := 1     
       2 Input      1 Bit         XORs := 1     
+---Registers : 
                   16 Bit    Registers := 1     
                   14 Bit    Registers := 1     
                   10 Bit    Registers := 1     
                    4 Bit    Registers := 1     
                    3 Bit    Registers := 2     
                    2 Bit    Registers := 7     
+---Muxes : 
       2 Input   28 Bit        Muxes := 1     
       4 Input   28 Bit        Muxes := 1     
       2 Input   16 Bit        Muxes := 1     
       2 Input   14 Bit        Muxes := 1     
       2 Input   10 Bit        Muxes := 2     
       4 Input    7 Bit        Muxes := 1     
       2 Input    4 Bit        Muxes := 15    
       4 Input    4 Bit        Muxes := 1     
       7 Input    2 Bit        Muxes := 6     
       4 Input    2 Bit        Muxes := 1     
       7 Input    1 Bit        Muxes := 6     
       2 Input    1 Bit        Muxes := 5     
---------------------------------------------------------------------------------
Finished RTL Component Statistics 
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Part Resource Summary
---------------------------------------------------------------------------------
Part Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
---------------------------------------------------------------------------------
Finished Part Resource Summary
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Cross Boundary and Area Optimization
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:18 . Memory (MB): peak = 1544.598 ; gain = 825.328
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Applying XDC Timing Constraints
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1580.164 ; gain = 860.895
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Timing Optimization
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Timing Optimization : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1580.945 ; gain = 861.676
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Technology Mapping
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Technology Mapping : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1630.770 ; gain = 911.500
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Flattening Before IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Flattening Before IO Insertion
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Final Netlist Cleanup
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Final Netlist Cleanup
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished IO Insertion : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Instances
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Instances : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Rebuilding User Hierarchy
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Ports
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Ports : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Handling Custom Attributes
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Handling Custom Attributes : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Renaming Generated Nets
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Finished Renaming Generated Nets : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
Start Writing Synthesis Report
---------------------------------------------------------------------------------

Report BlackBoxes: 
+-+--------------+----------+
| |BlackBox name |Instances |
+-+--------------+----------+
+-+--------------+----------+

Report Cell Usage: 
+------+-------+------+
|      |Cell   |Count |
+------+-------+------+
|1     |BUFG   |     2|
|2     |CARRY4 |    34|
|3     |LUT1   |     5|
|4     |LUT2   |    66|
|5     |LUT3   |    75|
|6     |LUT4   |    46|
|7     |LUT5   |    44|
|8     |LUT6   |   180|
|9     |FDCE   |    62|
|10    |FDPE   |    20|
|11    |FDRE   |    39|
|12    |IBUF   |     8|
|13    |OBUF   |    27|
+------+-------+------+
---------------------------------------------------------------------------------
Finished Writing Synthesis Report : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
---------------------------------------------------------------------------------
Synthesis finished with 0 errors, 0 critical warnings and 0 warnings.
Synthesis Optimization Runtime : Time (s): cpu = 00:00:16 ; elapsed = 00:00:23 . Memory (MB): peak = 1839.004 ; gain = 1046.402
Synthesis Optimization Complete : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 1839.004 ; gain = 1119.734
INFO: [Project 1-571] Translating synthesized netlist
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.005 . Memory (MB): peak = 1848.230 ; gain = 0.000
INFO: [Netlist 29-17] Analyzing 34 Unisim elements for replacement
INFO: [Netlist 29-28] Unisim Transformation completed in 0 CPU seconds
INFO: [Project 1-570] Preparing netlist for logic optimization
INFO: [Opt 31-138] Pushed 0 inverter(s) to 0 load pin(s).
Netlist sorting complete. Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 1851.910 ; gain = 0.000
INFO: [Project 1-111] Unisim Transformation Summary:
No Unisim elements were transformed.

Synth Design complete | Checksum: db79e5a5
INFO: [Common 17-83] Releasing license: Synthesis
75 Infos, 4 Warnings, 0 Critical Warnings and 0 Errors encountered.
synth_design completed successfully
synth_design: Time (s): cpu = 00:00:25 ; elapsed = 00:00:45 . Memory (MB): peak = 1851.910 ; gain = 1320.781
Write ShapeDB Complete: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.003 . Memory (MB): peak = 1851.910 ; gain = 0.000
INFO: [Common 17-1381] The checkpoint 'C:/Users/dawso/OneDrive/Documents/Vivado Projects/lab-04/lab-04.runs/synth_1/datapath_top.dcp' has been generated.
INFO: [Vivado 12-24828] Executing command : report_utilization -file datapath_top_utilization_synth.rpt -pb datapath_top_utilization_synth.pb
INFO: [Common 17-206] Exiting Vivado at Thu Jul 23 23:42:19 2026...
```

```
Copyright 1986-2022 Xilinx, Inc. All Rights Reserved. Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
---------------------------------------------------------------------------------------------------------------------------------------------
| Tool Version : Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
| Date         : Thu Jul 23 23:42:19 2026
| Host         : DawsonA14 running 64-bit major release  (build 9200)
| Command      : report_utilization -file datapath_top_utilization_synth.rpt -pb datapath_top_utilization_synth.pb
| Design       : datapath_top
| Device       : xc7a35tcpg236-1
| Speed File   : -1
| Design State : Synthesized
---------------------------------------------------------------------------------------------------------------------------------------------

Utilization Design Information

Table of Contents
-----------------
1. Slice Logic
1.1 Summary of Registers by Type
2. Memory
3. DSP
4. IO and GT Specific
5. Clocking
6. Specific Feature
7. Primitives
8. Black Boxes
9. Instantiated Netlists

1. Slice Logic
--------------

+-------------------------+------+-------+------------+-----------+-------+
|        Site Type        | Used | Fixed | Prohibited | Available | Util% |
+-------------------------+------+-------+------------+-----------+-------+
| Slice LUTs*             |  340 |     0 |          0 |     20800 |  1.63 |
|   LUT as Logic          |  340 |     0 |          0 |     20800 |  1.63 |
|   LUT as Memory         |    0 |     0 |          0 |      9600 |  0.00 |
| Slice Registers         |  121 |     0 |          0 |     41600 |  0.29 |
|   Register as Flip Flop |  121 |     0 |          0 |     41600 |  0.29 |
|   Register as Latch     |    0 |     0 |          0 |     41600 |  0.00 |
| F7 Muxes                |    0 |     0 |          0 |     16300 |  0.00 |
| F8 Muxes                |    0 |     0 |          0 |      8150 |  0.00 |
| Unique Control Sets     |    8 |       |          0 |      8150 |  0.10 |
+-------------------------+------+-------+------------+-----------+-------+
* Warning! The Final LUT count, after physical optimizations and full implementation, is typically lower. Run opt_design after synthesis, if not already completed, for a more realistic count.
Warning! LUT value is adjusted to account for LUT combining.
Warning! For any ECO changes, please run place_design if there are unplaced instances
** Note: Available Control Sets calculated as Slice * 1, Review the Control Sets Report for more information regarding control sets.


1.1 Summary of Registers by Type
--------------------------------

+-------+--------------+-------------+--------------+
| Total | Clock Enable | Synchronous | Asynchronous |
+-------+--------------+-------------+--------------+
| 0     |            _ |           - |            - |
| 0     |            _ |           - |          Set |
| 0     |            _ |           - |        Reset |
| 0     |            _ |         Set |            - |
| 0     |            _ |       Reset |            - |
| 0     |          Yes |           - |            - |
| 20    |          Yes |           - |          Set |
| 62    |          Yes |           - |        Reset |
| 0     |          Yes |         Set |            - |
| 39    |          Yes |       Reset |            - |
+-------+--------------+-------------+--------------+


2. Memory
---------

+----------------+------+-------+------------+-----------+-------+
|    Site Type   | Used | Fixed | Prohibited | Available | Util% |
+----------------+------+-------+------------+-----------+-------+
| Block RAM Tile |    0 |     0 |          0 |        50 |  0.00 |
|   RAMB36/FIFO* |    0 |     0 |          0 |        50 |  0.00 |
|   RAMB18       |    0 |     0 |          0 |       100 |  0.00 |
+----------------+------+-------+------------+-----------+-------+
* Note: Each Block RAM Tile only has one FIFO logic available and therefore can accommodate only one FIFO36E1 or one FIFO18E1. However, if a FIFO18E1 occupies a Block RAM Tile, that tile can still accommodate a RAMB18E1


3. DSP
------

+-----------+------+-------+------------+-----------+-------+
| Site Type | Used | Fixed | Prohibited | Available | Util% |
+-----------+------+-------+------------+-----------+-------+
| DSPs      |    0 |     0 |          0 |        90 |  0.00 |
+-----------+------+-------+------------+-----------+-------+


4. IO and GT Specific
---------------------

+-----------------------------+------+-------+------------+-----------+-------+
|          Site Type          | Used | Fixed | Prohibited | Available | Util% |
+-----------------------------+------+-------+------------+-----------+-------+
| Bonded IOB                  |   35 |     0 |          0 |       106 | 33.02 |
| Bonded IPADs                |    0 |     0 |          0 |        10 |  0.00 |
| Bonded OPADs                |    0 |     0 |          0 |         4 |  0.00 |
| PHY_CONTROL                 |    0 |     0 |          0 |         5 |  0.00 |
| PHASER_REF                  |    0 |     0 |          0 |         5 |  0.00 |
| OUT_FIFO                    |    0 |     0 |          0 |        20 |  0.00 |
| IN_FIFO                     |    0 |     0 |          0 |        20 |  0.00 |
| IDELAYCTRL                  |    0 |     0 |          0 |         5 |  0.00 |
| IBUFDS                      |    0 |     0 |          0 |       104 |  0.00 |
| GTPE2_CHANNEL               |    0 |     0 |          0 |         2 |  0.00 |
| PHASER_OUT/PHASER_OUT_PHY   |    0 |     0 |          0 |        20 |  0.00 |
| PHASER_IN/PHASER_IN_PHY     |    0 |     0 |          0 |        20 |  0.00 |
| IDELAYE2/IDELAYE2_FINEDELAY |    0 |     0 |          0 |       250 |  0.00 |
| IBUFDS_GTE2                 |    0 |     0 |          0 |         2 |  0.00 |
| ILOGIC                      |    0 |     0 |          0 |       106 |  0.00 |
| OLOGIC                      |    0 |     0 |          0 |       106 |  0.00 |
+-----------------------------+------+-------+------------+-----------+-------+


5. Clocking
-----------

+------------+------+-------+------------+-----------+-------+
|  Site Type | Used | Fixed | Prohibited | Available | Util% |
+------------+------+-------+------------+-----------+-------+
| BUFGCTRL   |    2 |     0 |          0 |        32 |  6.25 |
| BUFIO      |    0 |     0 |          0 |        20 |  0.00 |
| MMCME2_ADV |    0 |     0 |          0 |         5 |  0.00 |
| PLLE2_ADV  |    0 |     0 |          0 |         5 |  0.00 |
| BUFMRCE    |    0 |     0 |          0 |        10 |  0.00 |
| BUFHCE     |    0 |     0 |          0 |        72 |  0.00 |
| BUFR       |    0 |     0 |          0 |        20 |  0.00 |
+------------+------+-------+------------+-----------+-------+


6. Specific Feature
-------------------

+-------------+------+-------+------------+-----------+-------+
|  Site Type  | Used | Fixed | Prohibited | Available | Util% |
+-------------+------+-------+------------+-----------+-------+
| BSCANE2     |    0 |     0 |          0 |         4 |  0.00 |
| CAPTUREE2   |    0 |     0 |          0 |         1 |  0.00 |
| DNA_PORT    |    0 |     0 |          0 |         1 |  0.00 |
| EFUSE_USR   |    0 |     0 |          0 |         1 |  0.00 |
| FRAME_ECCE2 |    0 |     0 |          0 |         1 |  0.00 |
| ICAPE2      |    0 |     0 |          0 |         2 |  0.00 |
| PCIE_2_1    |    0 |     0 |          0 |         1 |  0.00 |
| STARTUPE2   |    0 |     0 |          0 |         1 |  0.00 |
| XADC        |    0 |     0 |          0 |         1 |  0.00 |
+-------------+------+-------+------------+-----------+-------+


7. Primitives
-------------

+----------+------+---------------------+
| Ref Name | Used | Functional Category |
+----------+------+---------------------+
| LUT6     |  180 |                 LUT |
| LUT3     |   75 |                 LUT |
| LUT2     |   66 |                 LUT |
| FDCE     |   62 |        Flop & Latch |
| LUT4     |   46 |                 LUT |
| LUT5     |   44 |                 LUT |
| FDRE     |   39 |        Flop & Latch |
| CARRY4   |   34 |          CarryLogic |
| OBUF     |   27 |                  IO |
| FDPE     |   20 |        Flop & Latch |
| IBUF     |    8 |                  IO |
| LUT1     |    5 |                 LUT |
| BUFG     |    2 |               Clock |
+----------+------+---------------------+


8. Black Boxes
--------------

+----------+------+
| Ref Name | Used |
+----------+------+


9. Instantiated Netlists
------------------------

+----------+------+
| Ref Name | Used |
+----------+------+
```

== Live Demonstration

_During Checkout_

#pagebreak()

== Written Response

We explicitly left out a large portion of the port-list and
module hierarchy in Lab 4-A because we knew going in that there
would be so many changes that made much more sense to tackle
during the 4-B portion. There were a couple new integrations
in our datapath as well, for example an up-counter, SSEG
multiplexer, and binary-to-BCD components.

We don't particularly think that this conclusion means Lab 4-A
_deserved_ more time. A lot of time was put into the ideation
and dataflow portions of 4-A that enabled 4-B in the first
place. In the context of a Lab assignment, similar amounts
of time were put into both parts of the lab.
