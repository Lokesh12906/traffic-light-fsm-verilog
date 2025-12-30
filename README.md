# Traffic Light Controller FSM (Verilog)

Clock-enabled Verilog FSM traffic light controller with pedestrian request handling
and minimum green time enforcement.

## Features
- Clock-enable based Moore FSM (no gated clocks)
- Minimum GREEN time guarantee
- Pedestrian request latching
- Dynamic RED time extension
- BLINK state for GREEN warning
- Fully synthesizable RTL

## FSM States
- RED
- GREEN
- BLINK
- YELLOW

## Tools Used
- Icarus Verilog + GTKWave (simulation)
- Vivado 2025.2 (synthesis & implementation)

## Repository Structure
rtl/ - RTL design files
tb/ - Testbench
docs/ - Design notes


## Author
Lokesh
