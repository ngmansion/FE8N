@thumb
;@org 08016a30
    push {lr}
    push {r4, r5}
    mov r4, r0
    mov r5, r1
    
    mov r0, r5
        @align 4
        ldr r1, [Adr+32] ;相手見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne non
    
    mov r0, r4
        @align 4
        ldr r1, [Adr+32] ;自分見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne got
    
    mov r0, r5
        @align 4
        ldr r1, [Adr+36] ;相手練達
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne non
    
got:
    mov r0, r4
        @align 4
        ldr r1, [Adr]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nonhit1
    @align 4
    ldr r1, [Adr+16]
    bl effect_test
    cmp r0, #0
    bne ret
    
nonhit1
    mov r0, r4
        @align 4
        ldr r1, [Adr+4]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nonhit2
    @align 4
    ldr r1, [Adr+20]
    bl effect_test
    cmp r0, #0
    bne ret
    
nonhit2
    mov r0, r4
        @align 4
        ldr r1, [Adr+8]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nonhit3
    @align 4
    ldr r1, [Adr+24]
    bl effect_test
    cmp r0, #0
    bne ret
    
nonhit3
    mov r0, r4
        @align 4
        ldr r1, [Adr+12]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nonhit4
    @align 4
    ldr r1, [Adr+28]
    bl effect_test
    cmp r0, #0
    bne ret
nonhit4


non
    mov r0, #0
ret
    pop {r4, r5}
    pop {pc}
    
    
effect_test:
    ldr r3, [r5, #4]
    ldrb r3, [r3, #4]
    b effective_loop
back
    ldrb r0, [r1, #0]
    cmp r0, r3
    beq true
    add r1, #1
effective_loop:
    ldrb r0, [r1, #0]
    cmp r0, #0
    bne back
    mov r0, #0
    b false
true
    mov r0, #1
false
    bx lr

@align 4
Adr: