.thumb

SOL_BIT = (addr+0)

        mov r3, #0x80
        ldr r2, SOL_BIT
        lsl r3, r2

        ldrh r2, [r7, #0]
        tst r2, r3
        beq normal

        mov r1, #3
        ldsb r1, [r7, r1]
        b merge
    normal:
        mov r1, #3
        ldsb r1, [r7, r1]
        asr r1, r1, #1

    merge:
        add r0, r0, r1
        lsl r0, r0, #16
        asr r1, r0, #16
        bx lr

.align
.ltorg
addr:




