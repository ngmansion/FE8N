@thumb
;0002ae54
    
    ldr r2, =$0203a5e8
    mov r0, #0x0
    str r0, [r2]
    
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl zeno
    
    cmp r0, #0
    beq jump
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl zeno_impl
    b Return
jump:
    ldr r1, [sp, #0]
    ldr r0, [sp, #4]
    bl zeno
    cmp r0, #0
    beq Return
    ldr r0, [sp, #4]
    ldr r1, [sp]
    bl zeno_impl
Return:
    ldr r3, [r6]
    ldr r1, [r3]
    lsl r1, r1, #8
    lsr r1, r1, #27
    ldr r0, =$0802ae5c
    mov pc, r0

zeno_impl:
    mov r3, r0
    ldr r2, =$0203a5e8
    ldrb r0, [r3, #11]
    str r0, [r2]
    
    add r1, #100
    ldrb r0, [r1]
    sub r0, #20
    strb r0, [r1]
    
    mov r1, #90
    ldsb r0, [r3, r1]
    add r0, #10
    strb r0, [r3, r1]
    
    mov r1, #94
    ldsb r0, [r3, r1]
    add r0, #3
    strb r0, [r3, r1]
    
    bx lr
    
zeno:
    push {r4, lr}
    mov r4, r0
    
    mov r0, r1
        @align 4
        ldr r1, [adr]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne notZeno
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;zeno
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq notZeno
    
    ldr r0, =$0203a4d0
    ldrh r1, [r0
    mov r0, #2
    and r0, r1
    cmp r0, #0
    bne notZeno
    ldrb r0, [r4, #0x13] ;nowHP   
        ldr r1, =$08000c78
        mov lr, r1
        @dcw $F800
    lsl r0, r0, #24
    asr r0, r0, #24
    b endZeno
notZeno:
    mov r0, #0
endZeno:
    pop {r4, pc}
@ltorg
adr:
