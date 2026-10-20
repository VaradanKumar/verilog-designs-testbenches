# ASIC Digital Designs using Verilog

A small portfolio repository of synthesizable Verilog RTL and simulation testbenches for common combinational and sequential digital circuits. The source files are recreated examples based on the project topics listed in the resume description; they are not recovered copies of the original project files.

## Designs included

| Design | RTL file | Main behavior |
|---|---|---|
| 4-to-1 multiplexer | `rtl/mux4to1.v` | Selects one of four inputs |
| 8-to-3 encoder | `rtl/encoder_8to3.v` | Encodes a one-hot input and flags invalid patterns |
| 8-to-3 priority encoder | `rtl/priority_encoder_8to3.v` | Highest asserted input bit wins |
| 8-bit shift register | `rtl/shift_register_8bit.v` | Serial-in shift register with reset and enable |
| 4-bit up-counter | `rtl/up_counter_4bit.v` | Enabled modulo-16 counter |
| 4-bit ring counter | `rtl/ring_counter_4bit.v` | Rotating one-hot sequence |
| 4-bit Johnson counter | `rtl/johnson_counter_4bit.v` | Twisted-ring counter with eight states |
| 101 sequence detector | `rtl/sequence_detector_101.v` | Moore FSM with overlap support |

Each RTL design has a corresponding testbench in `tb/`. The testbenches contain checks and print `PASS` or `FAIL` messages. Run each testbench separately.

## Repository layout

```text
asic-digital-designs-verilog/
├── rtl/       # Synthesizable Verilog modules
├── tb/        # Simulation testbenches
├── docs/      # Project notes
├── README.md
└── .gitignore
```

## Run in Xilinx Vivado

1. Open Vivado and create a new RTL project. You do not need to add an FPGA board or constraints to run behavioral simulation.
2. Add the files from `rtl/` as **Design Sources**.
3. Add the testbench you want to run from `tb/` as a **Simulation Source**.
4. In **Simulation Sources**, right-click the chosen testbench module (for example, `tb_mux4to1`) and select **Set as Top**.
5. Select **Run Simulation → Run Behavioral Simulation**.
6. Check the Tcl console for the testbench's `PASS` or `FAIL` output and inspect the waveform signals.
7. Repeat with another testbench by setting that testbench as the simulation top.

The testbenches use plain Verilog constructs and `timescale`; no UVM or vendor-specific primitives are required.

## Testbench list

| Testbench | What it checks |
|---|---|
| `tb/tb_mux4to1.v` | All 16 data patterns for all 4 select values |
| `tb/tb_encoder_8to3.v` | Each one-hot input, zero input, and a multi-hot input |
| `tb/tb_priority_encoder_8to3.v` | All 256 possible input patterns and priority behavior |
| `tb/tb_shift_register_8bit.v` | Reset, shifting, and enable hold behavior |
| `tb/tb_up_counter_4bit.v` | Reset, count progression, rollover, and enable hold |
| `tb/tb_ring_counter_4bit.v` | Ring rotation sequence |
| `tb/tb_johnson_counter_4bit.v` | Johnson-counter sequence and repeated cycle |
| `tb/tb_sequence_detector_101.v` | Detection of `101` in a serial stream, including overlap |

## Notes before publishing

- These are clean reconstructed examples based on a short project description. Review them and run the testbenches in your own Vivado installation before treating the results as verified.
- Do not state that simulation passed unless you have run it and confirmed the console output and waveforms.
- If you adapt the code, update this README to reflect the exact design and tests you completed.
