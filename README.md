Implementation of a 19-bit instruction size processor

This processor has been designed accordingly to handle 19-bit instruction size.

The processor consists of -

16-bit ALU
16-bit register
256x16 RAM (Xilinx IP)
16-bit Instruction Register
Control Unit
16-bit Program Counter


Commenting about the program the program is further divided as

- Top Module (16-bit Processor)
  - 16-bit processor unit
    - Control unit
    - Execute unit
      - Instruction Register
      - Program Counter
      - Integer Datapath 
        - Register
          - Decoder 3x8
          - 16b register
        - ALU
  - 256x16 RAM
  - Address Counter

