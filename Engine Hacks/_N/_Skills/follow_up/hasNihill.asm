@thumb
    
    mov r2, r0
    ldr r0, [r2, #4]
    ldr r1, [r2, #0]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
    lsl r0, r0, #8
    bmi oui
    ldr r1, [r2]
    ldrh r1, [r1, #0x26]
    ldrh r0, [r2, #0x3A]
    orr r0, r1
    lsl r0, r0, #29	;見切りの書
    bpl non
oui:
    mov r0, #1
    b end
non:
    mov r0, #0
end:
    bx lr
    