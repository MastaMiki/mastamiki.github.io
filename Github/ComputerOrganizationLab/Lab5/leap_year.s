/* printf.s */
.data
    .balign 4
message1:       .asciz  "Please enter a year :"
    .balign 4
is_leap_year_msg:       .asciz  "%d is not a leap year\n"
    .balign 4
not_leap_year_msg:       .asciz  "%d is a leap year\n"
    .balign 4
scan_pattern:   .asciz  "%d"
    .balign 4
number_read:    .word   0
    .balign 4
return:         .word   0
    
.text
    .global main
    .global printf
    .global scanf
main:
    LDR     r1, =return         @ r1=&return
    STR     lr, [r1]            @ *r1=lr

    LDR     r0, =message1       @ print message1
    BL      printf

    LDR     r0, =scan_pattern   @ input via scanf
    LDR     r1, =number_read
    BL      scanf

    @ This section is load input data to register
    LDR     r0, =number_read
    LDR     r0, [r0]
    
    @ Temp data for using later
    MOV     r12, r0

check4:
    MOV r5, r0
    mov r6, #4

check4_L1:
    CMP r5, r6
    BLT not_leap_year
    BEQ check100
    SUB r5, r5, r6
    B check4_L1

check100:
    MOV r5, r0
    mov r6, #100

check100_L1:
    CMP r5, r6
    BLT is_leap_year
    BEQ check400
    SUB r5, r5, r6
    B check100_L1

check400:
    MOV r5, r0
    mov r6, #400

check400_L1:
    CMP r5, r6
    BLT not_leap_year
    BEQ is_leap_year
    SUB r5, r5, r6
    B check400_L1

is_leap_year:
    @ This section is print number from input
    LDR     r0, =message2
    B       final

not_leap_year:
    @ This section is print number from input
    LDR     r0, =message2
    B       final

final:
    LDR     r1, =number_read
    LDR     r1, [r1]            @ r1 <-*r1
    BL      printf
    
    @ This section is load input data to register
    LDR     r0, =number_read
    LDR     r0, [r0]

    LDR     lr,=return
    LDR     lr, [lr]
    BX      LR                  @ swap lr,pc