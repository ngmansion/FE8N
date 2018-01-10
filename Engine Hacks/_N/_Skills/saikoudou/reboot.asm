@thumb
    ldr r0, [r1]
    cmp r0, #0
    beq end
    ldr r0, [r1, #12]
    and r0, r4
    str r0, [r1, #12]
    
    add r1, #69
    ldrb r0, [r1]
    cmp r0, #0xFF
    bne jump
    mov r0, #0
    strb r0, [r1]
jump:
    sub r1, #69
end:
    ldr r0, =$0801854c
    mov pc, r0
    