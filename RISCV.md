# RISC-V
## RISCV INSTRUCTION SET
- It is royalty free and license free.
- Simple instructions.
- Expects software to write complicated programs using simple ones.
- There are 32 general purpose registers starting from x0 to x31
- Some are caller saved and some are callee saved (we will discuss about this later).

## APPLICATION BINARY INTERFACE (ABI)
- It will have readable names like sp(stack pointer) or ra(return address) makes code more readable instead of using x1 for return address,x2 for stack pointer and s0 for framepointer.
- It is like set of rules.It will standardize naming convention allows different compilers and assemblers to interact without any problem.
- It will also tell how functions recieve parameters , return values and tells about caller and calle saved things.
- Caller : It calls other functions.
- Caller saved registers have to save the details in register before calling any function.
- Calle  : It is the function that is being called.
- Where as in callee saved function the details are saved by function that is called and retrieved again by that function only.Ex : stack pointer, frame pointer ,saved registers (s0-s6)

## Program Counter
- It will point to the next instruction that needs to be implemented.
- It usually increases by 4 bytes(i.e 32 bits which is sizwe of 1 instruction.
- In RISC-V 2 byte also possible (compressed instructions)

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
- Opcode for arithematic operations is **0110011**.
- Add/sub or srl/sra will have same funct3 and diff funct7.
- Based on that we will use muxes and know which operations has to be performed.

#### I-type Instructions
![image](https://github.com/user-attachments/assets/9507c599-ad27-4777-9680-c01aa8ae4c2e)
- immediate is sign extended and is of 12 bits so if we add something like 0xfff (thinking it as positive val but assembly lang will consider it as -1 and subtracts it (since it has sign extension).
- Opcode for Immediate type Instructions is **0010011**
- Do note that only the 6th bit from right is different in I-type and R-type (i.e op[5]).
- Various operations like addi,xori,andi,ori,srli,srai,slli can be performed.
- Immediate is sign extended and is of 12 bits.

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
- It is because store just copy pasting of things, there will be no sign extension made as in load 🤦‍♀️
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
- They will be resolved at assembly time so they won't incur hardware complexity.
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

```
riscv64-unknown-elf-gcc -nostdlib -nostartfiles -T ./spike.lds vowcount.s -o vowcount.elf
```
- The above is the command to create executable of code we have written.
- risc64-unknown-elf-gcc : this invokes the ass,bler.
- nostdlib : Tells not to add standard libraries. (useful for embedded systems)
- nostartfile : prevents linking with startup files (we don't want other files to execute)
- -T ./spike.lds : how executable should be placed in memory.
- vowcount.elf  : it is the file name where our code is written.

### Linker Descriptor File
![image](https://github.com/user-attachments/assets/25020f30-adcb-4cfc-943d-3f8469d829ef)
- Inside OUTPUT_ARCH : It is written as riscv - it tells that the target architecture is riscv.
- Inside entry what ever is there the assembly code will jump there and execute it (like specifying start point)
- Inside sections there are 3 parts
   1. At address : start address of program.
   2. .text : where the code there (it will be aligned 4kb from the start)
   3. .data : will have values (this is also aligned in 4kb)
- Why 4kb? Coz it is the page size.
### Executing the program
| With OS      | Without OS |
|----------|------------|
| OS loads the program into memory | It will be done on bare metal    |
| OS sets the start point and program gets executed  | This will maximize memory since we will take up other program only when the current one is terminated |
| Parallel computation can be done  |  Parallel computation cannot be done     |

- In bare metal programming, memory is divided in to two parts.
     1. Flash Memory : will hold .text part of program
     2. Main Memory  : will hold .data part of program
- reset vector will have fixed address (0x800000000)
- PC will start from that
- This address is present in flash memory.

## FUNCTION CALLS
- We will concentrate on 4 points
     1. Invoking Functions : how do we call them
     2. Returning from a function : how do we return
     3. Passing parameters : what reg are used to that
     4. Managing local variables
1. Invoking function calls
   ```Assembly Language
      jal rd, imm
      # jump and link return adress to rd (we will jumb to pc+imm)
      # u can also mention label instead of imm
   ```
- Jumps can be +/-1MB from current position.
- Why? Immediate is of 21 bits which is approximately 2 * 10<sup>6</sup> (so -1MB to +1MB)
- This will be relative to pc (again the same reason - instead of stroing 32 bit it is better to store 20 bits + 1 which lsb (always be 0)
![image](https://github.com/user-attachments/assets/06f9f664-c741-4efb-a4f9-89300d852e97)
- Pseudo Instruction : **j label ** -> jal x0,label
#### Indirect Jumps
```Assembly Language
   jalr rd,rs1,imm
   # jump and li nk but this time we will jump to rs1+imm
```
- Since we got 5 more bits or rs1 we will shrink and also a funct3 our immediate by 8bits.
- This is not relate to pc
- Pseudo Instruction : **ret rs1** -> jalr x0,rs1,0
![image](https://github.com/user-attachments/assets/a679fc16-9d82-436f-90c4-12531ee781fb)

### Function Calls
![image](https://github.com/user-attachments/assets/e08a28fc-e58e-4a55-af27-29818eb80aa6)
- More pseudo Instructions
     1. j label -> jal x0,label
     2. jr rs1  -> jalr x0,rs1,0
     3. ret rs1 == jr rs1
- When multiple functions are invoked ra we stor will be over written.To ensure that this doesnot happen we will introduce the concept of stack pointers.
- **Stack Pointer** : Is used to store return address and some local variable that you want to use later
- It grows from hugh address to low address.
- **sp** : This is used to point lowest address in the stack.
- Stack grows with each function call.
- frame pointer(fp) will point to starting point of this current stack which is also known as _Stack Frame_
- Function calls will have Prologue and Epilogue
```Assembly Language
# PROLOGUE
addi sp,sp,-16
sw ra,12(sp)
sw a1,8(sp)    # u want to store a1 for further purposes
sw a0,4(sp)    # assuming u wanna store a0 too
sw a2,0(sp)    # a2 too
# We are doing whatever we want
# calling other functions
#came back here again
# EPILOGUE
lw ra,12(sp)
lw a1,8(sp)    # get back the values
lw a0,4(sp)
lw a2,0(sp)
addi sp,sp,16
ret     # will jump to ra
```
- U can also store frame pointer if u want.
- Stack shrinks with each return
#### Passing Parameters to Functions
- a0/a1 are return values & function arguments
- a2-a7 are function aruguments
- Both are callee saved.
- If u want pass parameters >8 then u will have to maintain the remaining values in stack.
- **Caller Saved** : temporary data used in functions will be stored. Caller will have to push this data into stack and call the function.After the function return we will have to restore these values.
- **Callee Saved** : Callee's responsibilty to push these data into stack.When the function ends these values are restored.
  
  ![image](https://github.com/user-attachments/assets/f10ff7a9-883f-4b11-bc0e-255acd9e1443)
![image](https://github.com/user-attachments/assets/1463b45b-054e-4ad1-9783-6fe0f35ac8d2)

- We will now discuss about how fetch-decode-execute cycles work in CPU.
## Instruction Fetch
- Program counter will store the address of next instruction to be implemented.
- This PC will send this address to memory and memory returns the instruction(encoded in 32 bits) to the CPU. Along with that PC=PC+4 will be done automatically.
- The instruction is stored in instruction register.This instruction will be executed for every pos edge of the clock cycle.
- Instructions can be of anytye R,I,S-type. We have to decode it and execute it.
## Instruction Decode
- Decoding will be done by control unit. Usually instructions will have opcode,destn register,2 source registers,immediates.
- There will be a **Register File** which consists of registers (32 bit) which are used to store data. Esch register is made of 32/64 D-Flipflops based on its architecture.
- This register file will have 2 read operations and 1 write operations.Why? Because we might add/do any operations that requires 2 register.But final output will be 1 that we want to write.
- Since we have 32  registers it will require 5-bits to determine which is being used(address of register).
- Register File will have muxes and demuxes based on that only it can read or write in a _clock cycle_.
#### R-type Instructions
- Let the instructiob be
```Assembly
add x1,x2,x3
# x1=x2+x3
```
![image](https://github.com/user-attachments/assets/8137a4af-a569-48f3-b8d6-10484bec0f4d)

- Our task : we have to read x2 and x3 and add them using alu then write it in x1 reg.
- Format of R-type Instruction : funct7 rs2 rs1 funct3 rd opcode
- Control unit which has the instruction sends the bits inst[25:21] and inst[20:16] as rs2 and rs1 addresses respectively.This will be sent to register file and we will get those registers.
- Now we will also send inst[31:20] to generation block expecting it to be immediate.We will extend 12 bits to 32 bits and this immediate and 0 are inputs of a mux where select line will be op[5] (to distinguish between R & I-type).
- Assumig we have got 0 in this (since R-type) we will add this with rs1 (if it was I-type we would have added rs2+imm).
- Then we will take x2 and x3 and send it to ALU.
- ALU also comprises of demuxes to decide which operation to be performed.
- Control unit will send opcode,funct3 & funct7 to ALU.
- Inside ALU we will have to decide if whether which operation have to be performed. Suppose let funct7 be 0x20 then it will be doing sub of x2 n x3 and also sra and keep both of them with it.
- Now we have funct3 to decide which of them need to be send.Again demux is used to achieve this
- Note: _Opcode is same for all r-type instructions. funct3 is for individual operations. But add/sub , sra/srl will have same funct3. We can distinguish them only based on funct7._
- Once we have x1 ready we will write it in register file.

### I-type Instructions
```Assembly
addi rd,rs1,imm
# rd=rs1+imm
```
![image](https://github.com/user-attachments/assets/cb518b3c-35a9-4fb8-8a3b-4f5285bc33aa)

- I-type & R-type instructions opcode differ only in one bit i.e 6th bit from right (op[5])
- This bit is used to determine whether it is I-type or R-type.
- We will use op[5] to decide whether we have to send 0 or imm to add with rs1.
- One more purpose it to decide to send rs2 or 0. If it op[5]=0 -> I-type so it will give 0 else rs2.
- I-type instruction 0+imm ->imm, this will be added to rs1-> x1=rs1+imm (same alu will be doing this based on funct3).We won't have a funct7 to distinguish. But in case of shift op imm[5:11] will 0 since we can shift max by 5 bits (after that it will be 0 anyways.)
- This ise where sending opcode to alu comes in use. If op[5] = 0 we will not use funct7 (except for srli and srai) as they will have imm of atmost val 5 so imm[5:11] have to be eithe 0x00 or 0x20.
- And will write it in x1 register (this step is same in both).

### Executing load and store instructions
- Load: imm[31:20] rs1[19:15] funct3[14:12] rd[11:7] opcode[6:0]
- Store imm[7 bits] rs2[24:20] rs1[19:15] funct3[14:12] imm[5bits]opcode[6:0]
- Opcode for Load : 0000011
- Opcode for Store : 0100011
- Immediate is sent to gen block and it is extended and from the opcode op[5] to send imm or 0 (since load and store have op[5] as 0 it will give imm val only)
##### LOAD
- lw x10,imm(x12)
- 0 and rs2 with select line as op[5] will give us 0 again(similar to I-type Instruction)
- Also the address of x1 will be sent and will give that x12 out(first input of alu)
- Imm+0 as the second input of alu
- Similar to I-type instruction everything is done.
- We will have additional mux for distinguishing memoery and alu operations.
- The address x12+imm will be sent to memory and bring back value present in it and store it int x10 reg 
![image](https://github.com/user-attachments/assets/84630025-1f5a-4ec0-a5a8-0545291b8e42)
- Here as we can see one input is direct ans from alu and the second one is from memory operation, now op[4] is the decider tells which one should be the output. if op[4] is 1 then direct output of alu is written in x0
- In load op[4] will be 0 hence x10 will be written with that value.
##### STORE
- sw x10,imm(x12)
- Control unit will give op[5] to choose between x12 and 0 and dince op[5] is 1,x12 will be read. Also imm will be passed and x12+imm will be done 
- x10 will bypass to memoey operation it will store tht vsl in particular address















