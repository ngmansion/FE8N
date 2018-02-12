@thumb
    ldrb r1, [r4, #21]
    asr r1, r1, #1
    cmp r1, #20
    ble jump
    mov r1, #20
jump:
    add r2, r1, r0
    mov r3, r4
    add r3, #102
    strh r2, [r3]
    ldr r0, [r4, #0]
    ldr r1, [r4, #4]
    ldr r0, [r0, #40]
    ldr r1, [r1, #40]
    orr r0, r1
