@thumb
    push {r3, r4, r5, lr}
    push {r2}
    push {r1}
    mov r4, r0
    mov r5, #0
    
    mov r0, r4
        @align 4
        ldr r1, [adr]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq jump1
    add r5, #1
jump1:
    mov r0, r4
        @align 4
        ldr r1, [adr+4]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq jump2
    add r5, #2
jump2:
    ldr r0, [r4]
    add r0, #37
    ldrb r0, [r0]
    add r5, r5, r0
    
    mov r0, r5
    pop {r1}
    pop {r2}
    pop {r3, r4, r5, lr}
@ltorg
@align 4
adr:
