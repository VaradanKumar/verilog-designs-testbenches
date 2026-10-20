# Project notes

This repository is a recreated portfolio version of an ASIC/digital-design project, intended to make the concepts in the resume description concrete as reviewable source files.

## Suggested review sequence

1. Read each combinational design and identify its truth table.
2. Run the combinational testbenches and review the input/output waveforms.
3. Review asynchronous active-low reset behavior in the sequential circuits.
4. Trace the ring counter and Johnson counter states over a full cycle.
5. Trace the FSM through inputs `1, 0, 1` and confirm that the Moore output asserts for one state cycle.
6. Record the Vivado version and the tests actually run before publishing results.
