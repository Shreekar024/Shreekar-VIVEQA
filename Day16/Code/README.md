# Verilog Implementations (2026-06-16)

This directory contains implementations for timing and frequency-related modules.

## Files Overview

### 1. `adjustable_blink.v`
- **Description:** Implements a blinking LED with an adjustable frequency controlled by hardware buttons.
- **Logic:**
  - Uses two buttons (`btn_inc`, `btn_dec`) to increase or decrease a `speed_sel` variable (values 0 to 4).
  - A lookup table (multiplexer) maps `speed_sel` to a clock divider value, providing frequencies from 0.5 Hz to 8 Hz (assuming a 50 MHz base clock).
  - An internal counter (`count`) increments on every positive clock edge. When it reaches the `divider`, the LED state toggles.

### 2. `freq_counter.v`
- **Description:** Implements a simple 4-bit up-counter, often used for testing basic clock signal frequencies.
- **Logic:**
  - Uses a synchronous clock (`clk`) and an active-high reset (`rst`).
  - Upon reset, the 4-bit `led` output is cleared to `0`.
  - Otherwise, the output increments by `1` continuously on every positive clock edge.
