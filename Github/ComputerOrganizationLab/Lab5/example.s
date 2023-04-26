/* printf.s */
.data
    .balign 4
message1:       .asciz  "Please enter a number :"
    .balign 4
message2:       .asciz  "I read the number %d\n"
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

    LDR     r0, =message2
    LDR     gdbr1, =number_read
    LDR     r1, [r1]            @ r1 <-*r1
    BL      printf
    
    LDR     r0, =number_read
    LDR     r0, [r0]

    LDR     lr,=return
    LDR     lr, [lr]
    BX      LR@ swap lr,pc