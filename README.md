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
  

















