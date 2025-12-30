# Traffic Light Controller FSM (Verilog)

Clock-enabled Verilog FSM traffic light controller with pedestrian request handling
and minimum green time enforcement.

This project implements a **synthesizable Moore FSM** for a traffic light controller,
designed with real hardware constraints in mind and verified through simulation
and Vivado synthesis.

---

## Features
- Clock-enable based FSM (no gated clocks)
- Minimum GREEN time guarantee (`MIN_GREEN`)
- Pedestrian request latching for short button presses
- Dynamic RED time extension after pedestrian crossing
- BLINK state for GREEN warning
- Fully synthesizable RTL

---

## FSM States
- **RED**
- **GREEN**
- **BLINK**
- **YELLOW**

---

## Design Highlights
- FSM updates occur only on a slow enable signal (`clk_en`) derived from a clock divider
- State-local timer resets automatically on state transitions
- Pedestrian requests are latched to avoid missed pulses
- GREEN state cannot terminate before the minimum safety time
- Clean separation of:
  - state register
  - next-state logic
  - timing logic
  - output decoding

---

## Repository Structure
rtl/ - RTL design files
tb/ - Testbench
docs/ - Simulation and synthesis results


---

## Simulation
The design was verified using **Icarus Verilog** and **GTKWave**.
Simulation confirms:
- Correct state sequencing
- Proper handling of pedestrian requests
- Enforcement of minimum GREEN time

Simulation waveform is available in `docs/waveform.png`.

---

## Synthesis
The design was synthesized and implemented using **Vivado 2025.2**.
The synthesized schematic confirms:
- Proper inference of registers and combinational logic
- No gated clocks
- Hardware-realizable FSM implementation

The synthesis schematic is available in `docs/vivado_schematic.png`.

---

## Tools Used
- Icarus Verilog
- GTKWave
- Vivado 2025.2

---

## Author
Lokesh
