# Verilog Implementations (2026-06-10)

This directory contains Verilog implementations of finite state machines (FSMs).

## Files Overview

### 1. `mealy_1001.v`
- **Description:** Implements a Mealy State Machine designed to detect the sequence "1001" from a serial input bitstream.
- **Logic:** 
  - Structural modeling using two instances of a D Flip-Flop (`dff`).
  - Next-state logic equations derive the inputs `d0` and `d1` based on current state bits (`q[0]`, `q[1]`) and the serial input (`ip`).
  - The output `op` goes high when the sequence "1001" is successfully detected.

### 2. `vending_machine.v`
- **Description:** Implements a Vending Machine controller using a Finite State Machine (FSM).
- **Logic:**
  - Uses two `always` blocks: one for state transitions (synchronous) and one for next-state/output logic (combinational).
  - The machine accepts two coin denominations: `01` and `10`.
  - Transitions through states `IDLE`, `S1`, `S2`, `S3`, and `S4` depending on cumulative coins inserted.
  - **Outputs:** Dispenses the product (`D=1`) when sufficient coins are collected, and also dispenses change (`C=1`) if excess coins are inserted (e.g., reaching state `S4`).
