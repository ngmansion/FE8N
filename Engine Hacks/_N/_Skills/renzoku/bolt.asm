@thumb
    push {r4, lr}
    mov r4, r0
    
    mov r0, r1
        @align 4
        ldr r1, [adr] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne nonL
    
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;電撃
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nonL
    mov r0, #1
    @dcw $E000
nonL:
    mov r0, #0
    pop {r4, pc}

@align 4
adr: