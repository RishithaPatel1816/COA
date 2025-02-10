## Modifying an Array Using Loop and Indexing in RISC-V

.section .data
n:    .word 5    # Integer value 'n' (number of elements in the array)
arr0: .word 5    # Array elements (index 0)
arr1: .word 3    # Array elements (index 1)
arr2: .word 4    # Array elements (index 2)
arr3: .word 6    # Array elements (index 3)
arr4: .word 5    # Array elements (index 4)

.section .text
.global main
main:
    la t4,arr0     # Load the address of arr0 into register t4
    lw t0,n        # Load the value of 'n' (array size) into t0
    li t1,0        # Initialize loop counter t1 to 0

loop:
    beq t0,t1,end  # If t1 (index) == t0 (n), exit loop
    lw t2,0(t4)    # Load the current array element into t2
    add t2,t2,t1   # Add the loop index (t1) to the element value
    sw t2,0(t4)    # Store the updated value back into the array
    addi t4,t4,4   # Move to the next array element (4 bytes per word)
    addi t1,t1,1   # Increment loop counter
    j loop         # Jump back to loop start

end:
    li a7,93       # Exit system call code (93 for exit in RISC-V)
    ecall          # Perform system call (terminate program)
