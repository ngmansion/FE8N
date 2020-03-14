.thumb

    ldr r2, =0x0202bd2e
    ldrb r2, [r2]
    mov r3, #0x08
    tst r2, r3
    bne detail
    mov r2, #0x28
    .short 0xe000
detail:
    mov r2, #0x38
    add r2, r5
    bx lr
