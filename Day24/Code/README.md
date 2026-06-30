# Verilog Implementations (2026-06-24)

This directory contains an I2C master controller and a top-level wrapper used to interface with an MPU6050 accelerometer/gyroscope sensor.

## Files Overview

### 1. `i2c_master.v`
- **Description:** Implements a robust I2C Master controller.
- **Logic:**
  - Employs a prescaler to subdivide the system clock and manage the four I2C bit phases (driving SDA, raising SCL, sampling SDA, ending bit period).
  - Uses an FSM to handle I2C protocol states including `START`, `WR_ADDR`, `WR_REG`, `WR_DATA`, `REP_START`, `RD_DATA`, `STOP`, and `ACK/NACK` handling.
  - Supports both standard write sequences and repeated-start read sequences.
  - Splits the bi-directional SDA line into `sda_out`, `sda_oe`, and `sda_in` for proper integration with an `IOBUF` primitive at the top level.

### 2. `mpu6050_top.v`
- **Description:** A top-level hardware debugging environment for the I2C Master controller to interact with an MPU6050 sensor.
- **Logic:**
  - Instantiates an `IOBUF` primitive to correctly handle the bi-directional `sda` pin.
  - Instantiates the `i2c_master` module, hardcoding the MPU6050 slave address (`0x68`).
  - Uses a **Virtual Input/Output (VIO)** core (`vio_0`) to allow a user to manually trigger I2C reads and writes from Vivado, setting the register address (`vio_reg_addr`) and data (`vio_data_wr`).
  - Uses an **Integrated Logic Analyzer (ILA)** core (`ila_0`) to probe the I2C lines (`scl`, `sda_in`) and the internal FSM state in real-time hardware.
