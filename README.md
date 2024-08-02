# Implementation of a 16-bit Instruction Size RISC -V Processor

This processor has been designed to handle a 16-bit instruction size. 

The processor consists of:

## 16-bit ALU
The Arithmetic Logic Unit (ALU) performs arithmetic and logical operations on 16-bit binary numbers. It supports operations such as addition, subtraction, bitwise AND, OR, XOR, and NOT.

## 16-bit Register
This is a storage unit that holds 16-bit binary data. It is used to store intermediate results and data required by the CPU during processing.

## 256x16 RAM (Xilinx IP)
This is a Random Access Memory module with 256 words, each 16 bits wide. The Xilinx Intellectual Property (IP) core provides the RAM functionality, allowing for data storage and retrieval during program execution.

## 16-bit Instruction Register
The Instruction Register holds the current instruction being executed. It is 16 bits wide and is used to decode and execute instructions fetched from memory.

## Control Unit
The Control Unit orchestrates the operations of the CPU by generating control signals. It interprets instructions from the Instruction Register and directs other components (like the ALU, registers, and memory) to perform the necessary tasks.

## 16-bit Program Counter
The Program Counter (PC) holds the address of the next instruction to be fetched and executed. It is 16 bits wide, allowing for addressing up to 65536 memory locations.

## Commenting about the Program
The program is further divided as follows:

- **Top Module (16-bit Processor)**
  - **16-bit Processor Unit**
    - **Control Unit**
    - **Execute Unit**
      - **Instruction Register**
      - **Program Counter**
      - **Integer Datapath**
        - **Register**
          - **Decoder 3x8**
          - **16-bit Register**
        - **ALU**
  - **256x16 RAM**
  - **Address Counter**
