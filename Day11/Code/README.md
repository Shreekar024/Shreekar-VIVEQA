# Verilog Implementations (2026-06-11)

This directory contains Verilog implementations of memory elements, signal processing components (edge detectors, delays), and arithmetic operations.

## Files Overview

### 1. `delay_100.v`
- **Description:** Implements a parameterized N-bit shift register acting as a delay line.
- **Logic:**
  - Default parameter `N = 4`.
  - On every positive clock edge, it shifts the input bit `a` into a shift register.
  - The delayed output `a_delay` corresponds to the last bit of the shift register (`shift_reg[N-1]`).

### 2. `edge_detector.v`
- **Description:** Detects any edge (positive or negative) of an input signal.
- **Logic:** Delays the input by one clock cycle using a D flip-flop (`a_d`). XORs the current input `a` with the delayed input `a_d`. Outputs a `pulse` whenever there is a transition.

### 3. `posedge_detecter.v`
- **Description:** Detects only the positive edge of an input signal.
- **Logic:** Delays the input by one clock cycle (`a_d`). Evaluates `a & ~a_d` to output a `pulse` only when the signal transitions from `0` to `1`.

### 4. `negedge_detector.v`
- **Description:** Detects only the negative edge of an input signal.
- **Logic:** Delays the input by one clock cycle (`a_d`). Evaluates `~a & a_d` to output a `pulse` only when the signal transitions from `1` to `0`.

### 5. `mul_18.v`
- **Description:** A simple multiplier block.
- **Logic:** Accepts two 18-bit inputs `A` and `B` and accumulates their product into a 48-bit output `Y` (`Y = Y + A*B`). Note that continuous assignment to `Y` from itself creates a combinational loop.

### 6. `ram.v`
- **Description:** Implements a Synchronous RAM (Single Port).
- **Features:** 32-bit data width, 1024 depth (10-bit address).
- **Logic:** On the positive edge of the clock, if write-enable (`we`) is high, it writes `W_data` to the given `addr`. Otherwise, it reads from `addr` to `R_data` synchronously.

### 7. `tb_delay.v`
- **Description:** Testbench for the `delay_100` module.
- **Functionality:** Generates a clock and applies a sequence of input pulses to verify the N-cycle delay behavior.
