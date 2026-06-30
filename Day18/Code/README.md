# Verilog Implementations (2026-06-18)

This directory contains an implementation for a cascading LED blinker.

## Files Overview

### 1. `led_blinker.v`
- **Description:** Implements a ripple-counter based 4-bit LED blinker.
- **Logic:**
  - Uses a 24-bit `counter` that increments on every positive edge of the system `clk`.
  - Upon reaching a threshold (`1,499,999`), it toggles `led[0]` and resets the counter. Assuming a base frequency, this creates a specific blink rate for the first LED.
  - The subsequent LEDs (`led[1]`, `led[2]`, `led[3]`) are structured in a ripple configuration. `led[1]` toggles on the positive edge of `led[0]`, `led[2]` toggles on the positive edge of `led[1]`, and so on.
  - *Note:* While this cascading/ripple logic works, it is generally considered a poor practice in synchronous FPGA designs because it introduces significant clock skew by using logic signals as clocks.
