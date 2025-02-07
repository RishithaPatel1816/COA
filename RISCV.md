# RISC-V
## RISCV INSTRUCTION SET
- It is royalty free and license free.
- Simple instructions.
- Expects software to write complicated programs using simple ones.
- There are 32 general purpose registers starting from x0 to x31

## APPLICATION BINARY INTERFACE (ABI)
- It will have readable names like sp(stack pointer) or ra(return address) makes code more readable.
- It is like set of rules.It will standardize naming convention allows different compilers and assemblers to interact without any problem.
- It will also tell how functions recieve parameters , return values and tells about caller and calle saved things.
- Caller : It calls other functions.
- Calle  : It is the function that is being called.

## Program Counter
- It will point to the next instruction that needs to be implemented.
- It usually increases by 4 bytes(i.e 32 bits which is sizwe of 1 instruction.
- In RISC-V 2 byte also poosible (compressed instructions)

```assembly
add x1, x2, x3 #x1=x2+x3
#x1->destination register (rd)
#x2->first source register (rs1)
#x3->second source register (rs2)
```
- Below is the example for how to add with a number (12 bits max)
```assembly
addi x1, x2, 20 #x1=x2+20
#x1->destination register (rd)
#x2->first source register (rs1)
# 20 is a number
#u can add upto 12 bits
```
### INSTRUCTON ENCODING
#### R-type Instructions
![image](https://github.com/user-attachments/assets/aa47ad40-1524-4178-908c-e4258405028e)

- This is format for R-type instruction.
- It is used for basic arithematic operations like add,sub,shift etc..
- funct3 and funct7 are used to tell more about the operation.The same opcode we can represent multiple operations.
- Shift right logical vs Shift right arithematic
   - Logical will not shift with sign but Arithematic is sign extension
![image](https://github.com/user-attachments/assets/0b21d99b-ddda-4457-b7ca-7e8c2d581e38)

#### I-type Instructions
![image](https://github.com/user-attachments/assets/9507c599-ad27-4777-9680-c01aa8ae4c2e)
- immediate is sign extended and is of 12 bits so if we add something like 0xfff (thinking it as positive val but assembly lang will consider it as -1 and subtracts it (since it has sign extension).

## Instructions for Data Transfer
- A command that moves data between memory and registers is data transfer instruction.
- Following are the load instructions:
``` assembly
lw rd,imm(rs1)
# loads word
lb rd,imm(rs1)
# loads byte but signed
lb rd,imm(rs1)
# loads byte unsigned
```
- Immediate is 12 bit and signed i.e it take values from -2048 to 2047
- Also imm is written in bytes
- here rd is the destination registers that stored value present in (rs1+imm) address.
- do note that rs1 is a register containing address.

- Following are the Store Instructions
```assembly
sw rs2,imm(rs1)
#stores word in rs1
sb rs2,imm(rs1)
#stores byte in rs1
sh rs2,imm(rs1)
#stores half word that is 2 bytes
```
![image](https://github.com/user-attachments/assets/4e77af92-7d3e-4eb5-a323-803917db18fe)

- Why we don't have sbu similar to lbu?
- It is because store just copy oasting of things, there will be no sign extension made as in load 🤦‍♀️
```assembly
# Assume x1 has 0xABCDEF00
sw     x1, 0(x2)
lb     x3, 1(x2)
lbu    x4, 1(x2)
```
- After the execution x3 will have 0xffffffef
- where as x4 will have 0x000000ef
- RISC-V use concept of little endian
- 1 from x2 as in 1 byte means 3rd & fourth one from last
- If it was big endian it used to have 3rd and 4th one from the first.
  
![hi](https://github.com/user-attachments/assets/a3587319-c513-47a8-b98a-7fe842a72170)

## Aligned vs Non-aligned memory access
1. For words->if it is multiple of word size(i.e 4 bytes) it is known as *Aligned load*, else it is know as *Non-aligned load*
2. For half words->if it is a multiple of half word size(i.e 2 bytes) it is known to be *Aligned* else it is known as *Non-aligned*.

## Branch Instructions
- bne x4, x5, label
- If x4!=x5 then it will go to the label
- Usually label will have offset with respect to pc.
- 12-bits so that will be better that giving the absolute address.(Compact Instruction Encoding)
- so using offset will also make the code to be position independent.(Code Relocation)
  
![image](https://github.com/user-attachments/assets/60fccb54-b78b-4308-b7b9-814bafec914b)

- **blt vs bltu** : 0xffffffff < 0x0000001 according to blt (since it is a signed comparision)
- But for bltu it would be greater than.
- Have to be careful while implementing this one.
- 12 bits for immediate offset and 1 bit always 0 i.e lsb as Isa allows to jump only to even addresses.
- This jumbing with + or - 4KiB
```pseudo code
if branch is taken{
  pc=pc+4
}
else{
  pc=pc+2*imm
}
```
## Pseudo Instructions
- Not specified in ISA.
- Psedo Instructions make code readable.
- Example 1: Copy register from rs1 to rd
  - Pseudo instruction:   mv rd, rs1
  - RISC-V instruction : addi rd, rs1, 0
- Example 2: Load (12-bit) immediate into registers
  - Pseudo instruction: li rd, Imm
  - RISC-V instruction :  addi rd, x0, Imm
- Example 3: Load (32-bit) constants
  - Pseudo instruction: li rd, CONSTANT
  - RISC-V instruction:
    - lui rd, CONSTANT[31:12] (load upper immediate)
    - addi rd, rd, CONSTANT[11:0]

## An Assembly Program
```assembly
    .section .data
str:    .ascii "Rishitha Patel"   # Define a string in the data section

    .section .text
    .global main   # Declare main as global
    .global strlen # Declare strlen as global (not used in this code)

main:
    la a1, str      # Load the address of the string into a1
    li t1, 'a'      # Load ASCII value of 'a' into t1
    li t2, 'e'      # Load ASCII value of 'e' into t2
    li t3, 'i'      # Load ASCII value of 'i' into t3
    li t4, 'o'      # Load ASCII value of 'o' into t4
    li t5, 'u'      # Load ASCII value of 'u' into t5
    addi a0, a0, 0  # Initialize vowel count to 0

func:
    lb t0, 0(a1)    # Load byte from string (current character)
    beqz t0, end    # If null terminator is reached, exit loop
    
    # Check if the character matches any vowel
    beq t0, t1, add 
    beq t0, t2, add 
    beq t0, t3, add 
    beq t0, t4, add 
    beq t0, t5, add 
    
    addi a1, a1, 1  # Move to the next character in the string
    j func          # Repeat loop

add:
    addi a0, a0, 1  # Increment vowel count
    addi a1, a1, 1  # Move to the next character
    j func          # Repeat loop

end:
    ret             # Return from the function

```
- **.section derivative**
  - It has 2 parts: .text -to write the code part and .data to write values(like initializing variables)
- **.global derivartive**
  - make symbols visible to the linker so if i call this function from other object file also it will come here
- RISC-V has temporary registers(t0-t6) for local computations & augmented registers (a0-a7) for passing arguments and returning values from functions.
- Both are caller saved -> like across the function calls they are not preserved. 

### Linker Descriptor File














