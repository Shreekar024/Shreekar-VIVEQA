# Verilog Implementations (2026-06-12)

This directory contains Verilog implementations of various Random Access Memory (RAM) components.

## Files Overview

### 1. `block_ram.v`
- **Description:** Implements a Single-Port (SP) RAM.
- **Features:** 32-bit data width, 1024 depth.
- **Logic:**
  - Synchronous Write: On the positive edge of `clk`, if `we` is high, data (`write_data`) is stored at the memory location pointed by `addr`.
  - Asynchronous Read: Continuous assignment (`assign read_data = mem[addr]`) ensures the output immediately reflects the contents at `addr` without clock dependency.

### 2. `sdp.v`
- **Description:** Implements a Simple Dual-Port (SDP) RAM.
- **Features:** 32-bit data width, 1024 depth, independent read and write addresses.
- **Logic:**
  - Synchronous Write: On the positive edge of `clk`, if `we` is high, data is written to the memory location specified by `w_addr`.
  - Asynchronous Read: Output `read_data` continuously mirrors the memory data at `r_addr`.

### 3. `fifo.v`
- **Description:** Placeholder for a FIFO module.
- **Details:** The current implementation contains an empty module declaration (`module fifo#(parameter N=16)();`) and does not feature any functional logic yet.
