.data
prompt_hours:    .asciiz "Enter the number of regular hours worked: "
prompt_ot_hours: .asciiz "Enter the number of overtime hours worked: "
prompt_wage:     .asciiz "Enter the hourly wage: "
prompt_more:     .asciiz "Do you want to enter details for another employee? (y/n): "
output_gross:    .asciiz "Gross Salary: "
output_deduct:   .asciiz "Total Deductions: "
output_net:      .asciiz "Net Salary: "
newline:         .asciiz "\n"
yes:             .asciiz "y"
no:              .asciiz "n"

roll_number:     .word 06

.text
main:
    lw   $t0, roll_number      # Load roll number
    li   $t1, 30               
    div  $t0, $t1              
    mfhi $t2                   
    addi $t3, $t0, 8           # y = x + 8
    div  $t3, $t1              
    mfhi $t4                   

input_loop:
    # Resetting all relevant registers to 0 before starting calculations
    li   $t5, 0            
    li   $t6, 0            
    li   $t7, 0            
    li   $t8, 0            
    li   $s0, 0            
    li   $s1, 0            
    li   $s2, 0            
    li   $s3, 0            
    li   $s4, 0          
    li   $s5, 0            

    li   $v0, 4                
    la   $a0, prompt_hours    
    syscall
    
    li   $v0, 5                
    syscall
    move $t5, $v0              # $t5 = regular hours

    li   $v0, 4                
    la   $a0, prompt_ot_hours  
    syscall

    li   $v0, 5                
    syscall
    move $t6, $v0              # $t6 = overtime hours

    li   $v0, 4                
    la   $a0, prompt_wage      
    syscall

    li   $v0, 5                
    syscall
    move $t7, $v0              # $t7 = hourly wage

    # Gross Salary Calculation
    mul  $t8, $t5, $t7         # $t8 = regular salary = regular hours * wage
    li   $t9, 3                # $t9 = 1.5 * 2 = 3 (for 1.5x multiplication)
    mul  $s0, $t6, $t7         # $s0 = overtime pay = overtime hours * wage
    mul  $s0, $s0, $t9
    div  $s0, $s0, 2           # divide by 2 to get 1.5 * wage
    add  $s1, $t8, $s0         # $s1 = gross salary = regular salary + overtime pay

    # Deductions Calculation
    mul  $s5, $s1, $t2         # $t2 = gross salary * x (tax percentage)
    div  $s5, $s5, 100         # divide by 100 to get the tax deduction
    mflo $s2                   # move the result to $s2 (tax deduction)

    mul  $s6, $s1, $t4         # $t4 = gross salary * y (insurance percentage)
    div  $s6, $s6, 100         # divide by 100 to get the insurance deduction
    mflo $s3                   # move the result to $s3 (insurance deduction)

    add  $s4, $s2, $s3         # $s4 = total deductions = tax deduction + insurance

    # Net Salary Calculation
    sub  $s5, $s1, $s4         # $s5 = net salary = gross salary - total deductions

    # Output Results
    li   $v0, 4                
    la   $a0, output_gross     
    syscall
    
    li   $v0, 1                
    move $a0, $s1              # gross salary in $s1
    syscall
    
    li   $v0, 4               
    la   $a0, newline
    syscall
    
    li   $v0, 4                
    la   $a0, output_deduct    
    syscall

    li   $v0, 1                
    move $a0, $s4              # total deductions in $s4
    syscall

    li   $v0, 4                
    la   $a0, newline
    syscall

    li   $v0, 4                
    la   $a0, output_net       
    syscall

    li   $v0, 1               
    move $a0, $s5              # net salary in $s5
    syscall

    li   $v0, 4                
    la   $a0, newline
    syscall

    # Ask for another employee
    li   $v0, 4                
    la   $a0, prompt_more      
    syscall

    li   $v0, 8                
    la   $a0, yes              
    li   $a1, 2                # allocate space for 2 characters
    syscall

    lb   $t0, yes              
    li   $t1, 'y'              
    beq  $t0, $t1, input_loop  # if 'y', loop back to input

    # Exit Program
    li   $v0, 10               
    syscall

