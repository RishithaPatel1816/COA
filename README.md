# COA
- **CPU** is like brain of the compurer.
- It has AlU(Arithematic Logic Unit),CU(Control unit), Registers(to store values.

### What is Computer Architecture?
1. It tells computer what to do.
2. How fast it can do.
3. How it can interact with I/O devices.
### What is Computer Organization
- How CPU, memory and other parts are connected to follow the architecture(that we have designed).

## ISA 
**ISA**: Instruction Set Architecture
- It is like a contract between software and hardware.
- Like tells instructions that processor can execute,no. of registers for temporary storing in CPU, datatypes it can handle, I/O operations etc..
- It works on Fetch-Decode-Execute cycle
- **STATE OF THE PROGRAM**: It will define functional definitions of operations, modes, and storage locations that are supported by hardware.
- This will include Interrupt model, Memory mode(which u will come across later
- **What Instructions do**: Semantics of instructions like how they are updated etc..
- **How Instructions are represented**: Syntax(bit encodings)
- But it will not tell how they are implemented, which operations are fastand which are slow.
- It won't tell which operations take more power and which takes less
- ISA is basically a set of instruction that can be executed.
- To make an ISA one should see
1. Programmability (easy to expess the programS efficiently).
    - Using compilers we can express the programs efficiently.
    - ISA with low level fine grained instructions are preferred
3. Implementablilty (Easy to design high performance implementations.)
    - Every ISA can be implemented (but we need efficient implementation)
    - Fewautures like pipelining parallel execution, out of order execution give high performance.
    - But some ISA feautures will make it hard to implement like using variable instruction length.It might save memory but it is difficult to decode. Variable latencies a;sp complicate scheduling.
5. Compatability (Easy to maintain programmability as languages/programs nd technoloogy evolve)
   - like u have given one ISA but as technology increases this ISA should be easy to maintain

## RISC vs CISC
- **CISC** : Complex Instruction Set Computing
  - More complicati=ed and large number of instructions.
  - Variable length Instruction Encoding
- **RISC** : Reduced Instruction Set Computing
  - Fewer and less complicated instructions.
  - Fixed length Instruction Encoding.😁
- What: ISA
- How : Microarchitecture
### Binary Compatability
- If u change ISA but previous existing support is not changed without recompiling Software also it works.
- A compiled program can run on different systems without recompiling it again.
- But this new ISA may have new features.
- **Backward Binary Compatability** : Things that have compiled in old system will also compile in new system
- **Forward Binary Compatability**  : Things that are compiled in new system may or may not compile in old system
  
## Instruction Set Design
![image](https://github.com/user-attachments/assets/7acc51d4-96a6-4ac1-8438-1018c16ec9df)

- Now we will see how memory is stored
  ### MAIN MEMORY (DRAM)
- It id known as Dynamic Random Access Memory(Dynamic because it has ti refresh periodically inorder to store the value, sunce it stores in a capacitor)
- Latency because of no access
- It will act as cache for hard disk.
- CPU will not have direct access to DRAM. There will be something known as DRAM Controller that will only act as intermediate.
- 1 word= 4 bytes
**VON NEUMANN BOTTLE NECK**
- CPU needs to wait for data to come from memory.
- There is lot of improvement in processor functioning but in memory it is less.
  ![image](https://github.com/user-attachments/assets/17acf6f6-4213-43fc-becb-a51d586f0679)
- To remove Von Neumann Bottleneck we have intriducted things like cache, Pipelining etc..
  ### Registers
- Few in number & Fast in Nature.
- Not too few coz if it is very less we need to again store some in main memory which wiill make the processor slower.
- Like around 16/32/64 registers.
- It will be in processor(very close to processor and as fast as processor).
- Made with CMOS(Complementary Metal Oxide Semiconductor) Transistor.
- **Register File** : collection of registers inside CPU.
- ISA will define number of registers and its purposes like (general purpose or special purpose)
- Good ISA will use more registers as it decreases more access to main memory but too large will make this also less accessible.
#### Architectural Registers vs Microarchitectural Registers
- Architectural registers are registers in CPU that are explicitly visible and defined by ISA
- Where as microarchitectural registers are not visible and like used for optimzation.
### PROGRAM TRANSFORMATIONS
![image](https://github.com/user-attachments/assets/40ac6fb3-1802-469e-b8fe-d4ad4a2acfd2)
- Highlevel language language like cpp will be compiled using compiler and get converted into assembly language code (which will be in .s format).
- Using assembler this assembly code is conerted into machine code(.o format)
- But machine code is not fully executable since it won't have required libraries attached abd also the addresses.
- This machinde code is now combines with linker and makes the code/program executable😍
-  This executable is now loaded into memory by using a loader anit is implemented by using fetch decode execute.
- 32 bit (8 bytes) in the program memory is an instruction















