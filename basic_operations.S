.section .data
num1: .word 20   # First operand (20)
num2: .word 15   # Second operand (15)

r_add: .word     # Stores the result of addition
r_sub: .word     # Stores the result of subtraction
r_or:  .word     # Stores the result of logical OR
r_and: .word     # Stores the result of logical AND
r_xor: .word     # Stores the result of logical XOR

.section .text
.global main

main:
    # Load the addresses of num1 and num2
    la t0, num1   # Load address of num1 into t0
    la t1, num2   # Load address of num2 into t1
    lw t0, 0(t0)  # Load the value of num1 into t0
    lw t1, 0(t1)  # Load the value of num2 into t1

    # Addition: num1 + num2
    add t3, t0, t1    # Perform addition t3 = t0 + t1
    la t4, r_add      # Load address of r_add
    sw t3, 0(t4)      # Store result in r_add

    # Subtraction: num1 - num2
    sub t3, t0, t1    # Perform subtraction t3 = t0 - t1
    la t4, r_sub      # Load address of r_sub
    sw t3, 0(t4)      # Store result in r_sub

    # Logical OR: num1 | num2
    or t3, t0, t1     # Perform logical OR operation t3 = t0 | t1
    la t4, r_or       # Load address of r_or
    sw t3, 0(t4)      # Store result in r_or

    # Logical AND: num1 & num2
    and t3, t0, t1    # Perform logical AND operation t3 = t0 & t1
    la t4, r_and      # Load address of r_and
    sw t3, 0(t4)      # Store result in r_and

    # Logical XOR: num1 ^ num2
    xor t3, t0, t1    # Perform logical XOR operation t3 = t0 ^ t1
    la t4, r_xor      # Load address of r_xor
    sw t3, 0(t4)      # Store result in r_xor

    # Exit program
    li a7, 93   # Load system call for program exit
    ecall       # Execute system call
