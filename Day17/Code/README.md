# Verilog Implementations (2026-06-17)

This directory contains an Arithmetic Logic Unit (ALU) alongside a top-level module designed for hardware debugging using Vivado's Integrated Logic Analyzer (ILA) and Virtual Input/Output (VIO) IPs.

## Files Overview

### 1. `alu.v`
- **Description:** Implements a 32-bit Arithmetic Logic Unit (ALU).
- **Logic:**
  - Performs 4 operations based on a 3-bit `alu_ctrl` input: Addition (`000`), Subtraction (`001`), Bitwise AND (`010`), and Bitwise OR (`011`).
  - Defaults the output to high-impedance (`32'bz`) for undefined control codes.
  - Generates a `zero` flag when the result is precisely zero.

### 2. `top.v`
- **Description:** A top-level wrapper module integrating the ALU with Xilinx hardware debugging IPs.
- **Logic:**
  - Instantiates the `alu` module.
  - Instantiates a **VIO (Virtual Input/Output)** IP (`vio_0`) to provide software-driven inputs (`a`, `b`, and `alu_ctrl`) to the ALU, and to read back the ALU's `result` and `zero` flag.
  - Instantiates an **ILA (Integrated Logic Analyzer)** IP (`ila_0`) to actively probe and monitor the `result` and `zero` signals in real-time hardware on the board.
  
### 3. `uart.v`
- **Description:** An empty module declaration (`module uart(); ... endmodule`) likely intended as a placeholder for a future UART (Universal Asynchronous Receiver-Transmitter) implementation.
