# Verilog Implementations (2026-06-19)

This directory contains a complete UART (Universal Asynchronous Receiver-Transmitter) module implementation.

## Files Overview

### 1. `uart_tx.v`
- **Description:** Implements the UART Transmitter subsystem.
- **Logic:**
  - Uses an FSM (`S_IDLE`, `S_START`, `S_DATA`, `S_PARITY`, `S_STOP`) to shift out bits at a specified baud rate.
  - Configurable parameters: `CLKS_PER_BIT`, `PARITY_EN`, `PARITY_TYPE` (even/odd).
  - Asserts `tx_busy` during transmission and `tx_done` for one clock cycle upon completion.

### 2. `uart_rx.v`
- **Description:** Implements the UART Receiver subsystem.
- **Logic:**
  - Samples incoming bits at the center of each bit period (`CLKS_PER_BIT / 2`) to ensure data stability.
  - Built-in synchronization (`rx_sync1`, `rx_sync2`) to prevent metastability on the asynchronous `rx` input.
  - Extracts the data byte and flags errors like `parity_err` or `frame_err` (if the stop bit is missing).

### 3. `UART.v`
- **Description:** The top-level wrapper module that integrates both `uart_rx` and `uart_tx`.
- **Logic:**
  - Debounces 4 hardware buttons (`btn`).
  - Interprets specific characters received via UART (`rx_data`) to control LEDs and internal timers (e.g., character `1` sets `led[0]` high for 2 seconds).
  - Contains a transmission state machine that sends back a string message over UART whenever a button is pressed (e.g., "Button X Pressed\r\n").
