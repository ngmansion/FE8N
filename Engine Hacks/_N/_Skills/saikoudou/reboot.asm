@thumb
    ldr r0, [r1]
    cmp r0, #0
    beq end
    ldr r0, [r1, #12]
    and r0, r4
    str r0, [r1, #12]
    bl pulse
    bl jinrai
end:
    ldr r0, =$0801854c
    mov pc, r0
    
pulse:
    ldrb r0, [r1, #11]
    cmp r0, #0x40
    bge teki
    add r1, #67
    ldrb r0, [r1]
    cmp r0, #127
    bge teki
    add r0, #1
    strb r0, [r1]
    sub r1, #67
teki:
    bx lr
    
jinrai:
    add r1, #69
    ldrb r0, [r1]
    cmp r0, #0xFF
    bne jump
    mov r0, #0
    strb r0, [r1]
jump:
    sub r1, #69
    bx lr
    
    