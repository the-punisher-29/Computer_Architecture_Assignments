.data
prompt1:    .asciiz "Enter the first integer: "
prompt2:    .asciiz "Enter the second integer: "
result_add: .asciiz "Addition result: "
result_mul: .asciiz "Multiplication result: "
result_sub: .asciiz "Subtraction result: "
newline:    .asciiz "\n"

.text
main:
    li   $v0, 4                
    la   $a0, prompt1        
    syscall
    li   $v0, 5                
    syscall
    move $t0, $v0              
    li   $v0, 4                
    la   $a0, prompt2          
    syscall
    li   $v0, 5                
    syscall
    move $t1, $v0              

    # Perform Addition
    add  $t2, $t0, $t1         # $t2 = $t0 + $t1

    # Perform Multiplication
    mul  $t3, $t0, $t1         # $t3 = $t0 * $t1

    # Perform Subtraction
    sub  $t4, $t0, $t1         # $t4 = $t0 - $t1

    # Print Addition Result
    li   $v0, 4                
    la   $a0, result_add       
    syscall

    li   $v0, 1               
    move $a0, $t2              
    syscall

    li   $v0, 4                
    la   $a0, newline
    syscall

    # Print Multiplication Result
    li   $v0, 4                
    la   $a0, result_mul      
    syscall

    li   $v0, 1                
    move $a0, $t3              
    syscall

    li   $v0, 4                
    la   $a0, newline
    syscall

    # Print Subtraction Result
    li   $v0, 4                
    la   $a0, result_sub       
    syscall

    li   $v0, 1                
    move $a0, $t4              
    syscall

    li   $v0, 4                
    la   $a0, newline
    syscall

    li   $v0, 10               
    syscall
