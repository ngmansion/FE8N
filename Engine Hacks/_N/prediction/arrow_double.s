.thumb

    ldr r2, =0x0202bd2e
    ldrb r2, [r2]
    mov r1, #0x08
    tst r2, r1
    bne detail
    add r0, #11
    .short 0xe000
detail:
    add r0, #15
    lsl r1, r0, #3
    bx lr
