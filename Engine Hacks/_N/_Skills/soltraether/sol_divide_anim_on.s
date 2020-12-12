.thumb

SOL_BIT            = (addr+0)
RADIANT_AETHER_BIT = (addr+4)

        mov r3, #0x80
        ldr r2, SOL_BIT
        lsl r3, r2
        ldrh r2, [r7, #0]
        tst r2, r3
        bne sol

        mov r3, #0x80
        ldr r2, RADIANT_AETHER_BIT
        lsl r3, r2
        ldrh r2, [r7, #0]
        tst r2, r3
        bne aether
    normal:
        mov r1, #3
        ldsb r1, [r7, r1]
        asr r1, #1
        b merge

    aether:
        ldr r1, =0x0203a4d0
        ldrb r2, [r1, #8]
        ldrb r1, [r1, #6]
        sub r1, r1, r2
        ble zero
        mov r2, #3
        ldsb r2, [r7, r2]
        cmp r1, r2
        blt merge       @小さければジャンプ(採用)
        mov r1, r2
        b merge
    sol:
        mov r1, #3
        ldsb r1, [r7, r1]
        b merge
    zero:
        mov r1, #0
    merge:
        add r0, r0, r1
        lsl r0, r0, #16
        asr r1, r0, #16
        bx lr

.align
.ltorg
addr:




