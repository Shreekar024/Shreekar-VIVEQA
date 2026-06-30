# Verilog Implementations (2026-06-15)

This directory contains implements a 16-to-4 priority/one-hot encoder, as well as simple combinatorial logic modules mapped to FPGA board I/O.

## Files Overview


### 1. `encoder.v`
- **Description:** Implements a 16-to-4 priority/one-hot encoder.
- **Logic:** 
  - Takes a 16-bit input (`btn`), presumably from 16 buttons.
  - Uses a `case` statement to map a single active-high bit in the 16-bit input to a corresponding 4-bit binary output (`led`).
  - If multiple buttons are pressed or no buttons match the specific one-hot patterns, it defaults to outputting `0000`.

### 2. `led_swith.v`
- **Description:** A simple pass-through module connecting switches directly to LEDs.
- **Logic:** 
  - Takes an 8-bit input (`switch`) and continuously assigns it to an 8-bit output (`led`).
  - Useful for basic board testing (e.g., toggling a switch turns on the corresponding LED).
