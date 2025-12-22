# AES-128 Encryption on FPGA

[![FPGA](https://img.shields.io/badge/FPGA-Basys%203-blue)](https://digilent.com/reference/programmable-logic/basys-3/start)
[![Language](https://img.shields.io/badge/Language-VHDL-orange)](https://en.wikipedia.org/wiki/VHDL)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

FPGA implementation of the **AES-128 encryption algorithm** on the Basys 3 development board (Xilinx Artix-7).

## Overview

This project implements a complete AES-128 encryption engine in VHDL, featuring:
- **State machine-based control** for efficient round management
- **Optimized datapath** achieving 1 clock cycle per transformation
- **NIST-validated** implementation using official test vectors
- **Hardware interface** with button controls and 7-segment display

## Features

- Complete 10-round AES-128 encryption
- Modular design with separate components for each transformation
- Comprehensive testbenches for all modules
- Button-controlled operation on Basys 3 board
- Multiple test vector support (4 plaintexts)
- 7-segment display feedback

## Architecture

The encryption engine consists of **4 main transformations**:

| Module | Function | Implementation |
|--------|----------|----------------|
| **AddRoundKey** | XOR with round key | Bitwise XOR operation |
| **SubBytes** | Byte substitution | S-box lookup table (256 entries) |
| **ShiftRows** | Row shifting | Cyclic byte rotation |
| **MixColumns** | Column mixing | Galois field multiplication |

## Project Structure
```
AES-128-Encryption-FPGA/
â”œâ”€â”€ src/                      # VHDL source files
â”œâ”€â”€ testbench/                # VHDL testbenches
â”œâ”€â”€ constraints/              # FPGA constraints
â””â”€â”€ docs/                     # Documentation
```

## Getting Started

### Prerequisites

- Xilinx Vivado (2020.x or later)
- Basys 3 FPGA board (optional, for hardware testing)

### Simulation

1. Clone the repository
```bash
   git clone https://github.com/GlodiSala/AES-128-Encryption-FPGA.git
   cd AES-128-Encryption-FPGA
```

2. Open Vivado and create a new project
   - Add all files from `src/` as design sources
   - Add files from `testbench/` as simulation sources

3. Run simulation
   - Select desired testbench
   - Run behavioral simulation
   - Verify outputs against expected NIST values

### Hardware Implementation

1. Add constraint file (`constraints/Basys-3-Master.xdc`)
2. Run synthesis and implementation
3. Generate bitstream
4. Program the FPGA via USB

### Board Controls

| Button | Function |
|--------|----------|
| btnC | Encrypt test vector 1 |
| btnU | Encrypt test vector 2 |
| btnL | Encrypt test vector 3 |
| btnD | Encrypt test vector 4 |
| btnR | Reset system |

## Validation

All modules validated using **NIST FIPS 197** test vectors.

**Reference**: [NIST FIPS 197](https://csrc.nist.gov/publications/detail/fips/197/final)

## Documentation

- [Full Project Report](docs/AES_Project_Report.pdf)
- Block Diagrams (in `docs/diagrams/`)
- Simulation Waveforms (in `docs/waveforms/`)

## Technologies

- **HDL**: VHDL
- **Tools**: Xilinx Vivado
- **Target**: Basys 3 (Artix-7 XC7A35T-1CPG236C)
- **Validation**: NIST FIPS 197 test vectors

## Authors

**Glodi Sala Mangituka**  
- Email: glodi.sala.mangituka@gmail.com
- LinkedIn: [glodi-sala-mangituka](https://linkedin.com/in/glodi-sala-mangituka)
- GitHub: [GlodiSala](https://github.com/GlodiSala)

**Jian Huo**  
- Email: jian.huo@ulb.be

## Academic Context

**Course**: ELECH-409 - Digital Architectures and Design  
**Institution**: UniversitÃ© Libre de Bruxelles (ULB) / Vrije Universiteit Brussel (VUB)  
**Date**: December 2023

### Supervisors
- Prof. Dragomir Milojevic - Course Instructor
- Oscar Van Slipje - Teaching Assistant
- Muhammad Ali - Teaching Assistant

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- ULB/VUB teaching staff for guidance and support
- NIST for AES specification and test vectors
- Digilent for Basys 3 documentation
- Xilinx for Vivado Design Suite

## References

1. [NIST FIPS 197: Advanced Encryption Standard](https://csrc.nist.gov/publications/detail/fips/197/final)
2. Daemen, J., & Rijmen, V. (2002). *The Design of Rijndael*
3. [Basys 3 Reference Manual](https://digilent.com/reference/programmable-logic/basys-3/reference-manual)
