# Verilog Implementations (2026-06-23)

This directory contains a clock generation module.

## Files Overview

### 1. `clk_gen.v`
- **Description:** A simple wrapper module for a Clocking Wizard IP core.
- **Logic:**
  - Instantiates a Xilinx IP core (`clk_wiz_0`).
  - Takes a base input clock (`clk_in1`) and a `reset` signal.
  - Outputs four distinct generated clocks (`clk_out1`, `clk_out2`, `clk_out3`, `clk_out4`) along with a `locked` signal indicating when the Phase-Locked Loop (PLL) or Mixed-Mode Clock Manager (MMCM) has stabilized.
