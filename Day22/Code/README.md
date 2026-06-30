# Verilog Implementations (2026-06-22)

This directory contains an implementation for a 7-segment display driver.

## Files Overview

### 1. `seg_display.v`
- **Description:** Implements a stopwatch controller communicating with a MAX7219 LED display driver via SPI.
- **Logic:**
  - **Stopwatch Counters:** Generates a 100 ms tick from a 24 MHz clock. Uses cascading counters to track tenths of a second (`d3`), seconds (`d2`), tens of seconds (`d1`), and hundreds of seconds/hours (`d0`).
  - **SPI State Machine:** Generates a 1 MHz SPI clock and drives `seg_cs`, `seg_clk`, and `seg_din` to communicate with the MAX7219 IC.
  - **MAX7219 Initialization & Refresh:**
    - Sends initialization commands on power-up (e.g., Shutdown mode off, Decode mode B, Intensity setting, Scan limit).
    - Continuously loops through digits 0 to 3 to refresh the 7-segment display with the live stopwatch counter values.
