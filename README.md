# RAM_Verification

## Introduction
The project implements a 1024x8 Synchronous RAM, where:
-1024 memory locations are available.
  -Each location stores 8-bit data.
  -Read and write operations occur on the rising edge of the clock.
  -The design includes an active-low reset (rst_n) to initialize memory.
-Directed verification is performed to validate correct memory functionality.
-Tasks are used in the testbench to improve code density and reusability.

## About the Design (mem1024x8)
-Memory array declared as 1024x8.
-Synchronous write operation when wr = 1.
-Synchronous read operation when wr = 0.
-Reset clears all memory locations.
-Address manipulation is done using:
  wire [9:0] mem_address = {address[9:1],1'b1};
-This forces LSB = 1, which results in:
-Only odd addresses being accessed.
-Even addresses becoming unreachable.
-Incorrect memory mapping behavior.

## About the Testbench
-A structured testbench (tb_memory) was created.
-Clock generation with fixed period.
-Reset sequence applied initially.
-Two reusable tasks were implemented:
  write() – performs synchronous write operation.
  read() – performs synchronous read operation.
-Two directed test modules:
  test_1
        Verifies single address write and overwrite cases.
        Checks correctness using conditional comparisons.
  test_2
        Performs multiple address write-read operations.
        Verifies data integrity across different addresses.
-$monitor, $display, $dumpvars used for observation and waveform generation.

## Verification Results
  Line Coverage
                100% line coverage achieved.
                All executable lines in design and testbench were exercised.
                Indicates no dead code remains.

  Toggle Coverage
                Overall toggle coverage ≈ 50–57%.
                Some signals did not experience full 0→1 and 1→0 transitions.
                Indicates limited stimulus variation.
                test_2 showed very low toggle activity.

  Combinational Logic Coverage
                93% coverage in memory module.
                One logic combination not exercised.
                Overall accumulated coverage ≈ 85%.

## Bugs Identified
-Memory size declared as [0:1024] (1025 locations instead of 1024).
-Address manipulation forces LSB to 1, preventing access to even addresses.
-Full address space not verified due to mapping issue.
-Limited toggle activity indicates incomplete functional stress.

## Conclusion
-Directed verification successfully validated basic read and write functionality.
-Line coverage is complete, showing structural execution.
-However, toggle and combinational coverage reveal incomplete functional exploration.
-Address mapping bug affects correctness of the memory design.
-The design works partially but does not fully meet 1024x8 memory specification.

## Further Improvements
-Correct memory size to [0:1023].
-Remove forced LSB in address mapping.
-Add random stimulus generation.
-Perform boundary testing (address 0 and 1023).
-Add simultaneous read-write stress tests.
-Implement functional coverage metrics.
-Introduce constrained random verification.
-Convert to SystemVerilog assertions for bug detection.
-Develop a scoreboard-based verification model.
-Extend verification to corner cases and stress patterns.
