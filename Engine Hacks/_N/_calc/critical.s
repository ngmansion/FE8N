.thumb
@ 0802ab94
    ldrb r1, [r4, #21]
    asr r1, r1, #1
    add r0, r1

    ldr r1, [r4]
    ldr r2, [r4, #4]
    ldr r1, [r1, #40]
    ldr r2, [r2, #40]
    orr r1, r2

    mov r2, #64
    and r1, r2
    beq jump
    add r0, #15
jump:
    mov r3, #102
    strh r0, [r4, r3]
    pop {r4, pc}
