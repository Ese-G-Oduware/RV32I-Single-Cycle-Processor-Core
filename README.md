# RV32I-Single-Cycle-Processor-Core

I built a single-cycle 32 Bit RISC-V processor from scratch in Verilog to deepen my understanding of computer architecture (specifically ISA's) and hardware design. This core successfully executes raw machine code directly on the hardware without any OS overhead.

**Hardware**
* **The Core:** The implementation features a 32-bit processing core wrapped in a multi-stage pipelined datapath.
* **ALU & Registers:** Designed a custom ALU to handle logical and shift operations that are then mapped unto a 32-bit register file.
* **Control Flow:** Engineered a standalone branch unit that evaluates 7 unique conditional branch and jump scenarios to flawlessly redirect the PC.
* **Memory & Decoding:** Implemented lightweight 1024-word instruction and data memory modules, driven by a dedicated instruction decoder and immediate sign-extension unit.

**Testing & Results**
There is an example program that has been pre-compiled and added to the instruction memory of the project.
![Test Code](test_code/RISC_V_Ex_code.cpp)

Moreover, there is 100% accuracy across simulated testbenches. It correctly decodes RV32I base instructions, proving the CPU can manage dynamic memory addressing and resolve unpredictable branching logic without dropping instructions.

**How to run Simulation**
1. Clone this repo and open your terminal.
2. Launch your Verilog simulator (Vivado, ModelSim, or Icarus).
3. Compile the source and testbench files 
4. Run the simulation and monitor the `debug` output wire to verify instruction execution.

*Acknowledgments: The baseline Verilog concepts and architecture routing for this project were learned via bitspinner.com.*
