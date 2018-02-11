;0802c754
@thumb
    
    bl triangle
    cmp r0, #0
    beq jump
    mov r2, r0
    
    mov r1, r4
    add r1, #83
    mov r0, #0
    ldsb r0, [r1, r0]
    lsl r0, r2
    strb r0, [r1, #0]
    
    add r1, #1
    mov r0, #0
    ldsb r0, [r1, r0]
    lsl r0, r2
    strb r0, [r1, #0]
    
    mov r1, r5
    add r1, #83
    mov r0, #0
    ldsb r0, [r1, r0]
    lsl r0, r2
    strb r0, [r1, #0]
    
    add r1, #1
    mov r0, #0
    ldsb r0, [r1, r0]
    lsl r0, r2
    strb r0, [r1, #0]
jump
    ldr r0, [r4, #76]
    mov r6, #128
    lsl r6, r6, #1
    and r0, r6
    cmp r0, #0
    beq ret2

    ldr r0, =$0802c75e
    mov pc, r0
ret2
    ldr r0, =$0802c766
    mov pc, r0



triangle:
    push {r6, lr}
    mov r6, #0
    bl triangle_impl
    add r6, r0
    eor r4, r5
    eor r4, r5
    eor r4, r5
    
    bl triangle_impl
    add r6, r0
    eor r4, r5
    eor r4, r5
    eor r4, r5
    
    mov r0, r6
    pop {r6, pc}


triangle_impl:
    push {lr}
    mov r0, r5
        @align 4
        ldr r1, [adr]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne falseTri
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;zeno
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq falseTri
    mov r0, #1
    @dcw $E000
falseTri
    mov r0, #0
    pop {pc}
@ltorg
adr




