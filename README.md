# Iterative Divider – RTL to GDSII (SKY130)

This project implements an iterative 32-bit unsigned divider with a clean
control–datapath separation.

The objective is to achieve timing closure on the SKY130 PDK using OpenLane,
with a focus on:
- Static Timing Analysis (STA)
- Multicycle path constraints
- Post-CTS timing effects

**Status:** Work in progress

## Week 1 Status
- Iterative 32-bit unsigned divider
- Restoring division algorithm
- Clear control–datapath separation
- Fixed latency (32 cycles, 1 bit per cycle)
- Verified using SystemVerilog testbench (Icarus Verilog)
