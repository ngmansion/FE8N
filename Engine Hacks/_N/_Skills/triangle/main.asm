@;0802c754
.thumb
    bl CancelAffinity
    bl triangle
    ldr r0, [r4, #76]
    mov r6, #128
    lsl r6, r6, #1
    and r0, r6
    cmp r0, #0
    beq ret2

    ldr r0, =0x0802c75e
    mov pc, r0
ret2:
    ldr r0, =0x0802c766
    mov pc, r0

CancelAffinity:

    push {r6, lr}
    mov r6, #0
    
    bl hasCancelAffinity
    add r6, r0
    eor r4, r5
    eor r5, r4
    eor r4, r5
    bl hasCancelAffinity
    add r6, r0
    eor r4, r5
    eor r5, r4
    eor r4, r5
    
    cmp r6, #0
    beq endCancelAffinity
    mov r1, r4
    add r1, #83
    mov r0, #0
    strb r0, [r1, #0]
    add r1, #1
    mov r0, #0
    strb r0, [r1, #0]
    
    mov r1, r5
    add r1, #83
    mov r0, #0
    strb r0, [r1, #0]
    add r1, #1
    mov r0, #0
    strb r0, [r1, #0]
endCancelAffinity:
    pop {r6, pc}

hasCancelAffinity:
    push {lr}
    mov r0, r5
        ldr r1, adr @hasNihil
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne falseCancelAffinity
    mov r0, r4
        ldr r1, adr+8 @;tri
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseCancelAffinity
    mov r0, #1
    .short 0xE000
falseCancelAffinity:
    mov r0, #0
    pop {pc}
 
triangle:
    push {r6, lr}
    mov r6, #0
    bl hasTriangle
    add r6, r0
    eor r4, r5
    eor r5, r4
    eor r4, r5
    
    bl hasTriangle
    add r6, r0
    eor r4, r5
    eor r5, r4
    eor r4, r5
    
    cmp r6, #0
    beq falseTriangle
    mov r2, r6
    
    mov r1, r4
    add r1, #83
    mov r0, #0
    ldsb r0, [r1, r0]
    mul r0, r2
    strb r0, [r1, #0]
    
    add r1, #1
    mov r0, #0
    ldsb r0, [r1, r0]
    mul r0, r2
    strb r0, [r1, #0]
    
    mov r1, r5
    add r1, #83
    mov r0, #0
    ldsb r0, [r1, r0]
    mul r0, r2
    strb r0, [r1, #0]
    
    add r1, #1
    mov r0, #0
    ldsb r0, [r1, r0]
    mul r0, r2
    strb r0, [r1, #0]
falseTriangle:
    pop {r6, pc}


hasTriangle:
    push {lr}
    mov r0, r5
        ldr r1, adr @hasNihil
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    bne falseTri
    mov r0, r4
        ldr r1, adr+4 @;tri
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq falseTri
    mov r0, #3	@3倍
    .short 0xE000
falseTri:
    mov r0, #0
    pop {pc}
.align
.ltorg
adr:




