.thumb
@ hint 0x07cc22でビットを減らした状態で格納
@

SOL_BIT            = (addr+0)
RADIANT_AETHER_BIT = (addr+4)

        mov r2, #0x80
        ldr r1, SOL_BIT
        lsl r2, r1
        ldrh r1, [r4, #0]
        tst r1, r2
        bne sol

        mov r2, #0x80
        ldr r1, RADIANT_AETHER_BIT
        lsl r2, r1
        ldrh r1, [r4, #0]
        tst r1, r2
        bne aether
    normal:
        mov r1, #93
        ldsb r1, [r0, r1]
        asr r1, #1
        b merge

    aether:
        ldr r1, =0x0203a4d0
        ldrb r2, [r1, #8]
        ldrb r1, [r1, #6]
        sub r1, r1, r2
        ble zero
        mov r2, #93
        ldsb r2, [r0, r2]
        cmp r1, r2
        blt merge       @小さければジャンプ(採用)
        mov r1, r2
        b merge
    sol:
        mov r1, #93
        ldsb r1, [r0, r1]
        b merge
    zero:
        mov r1, #0
    merge:
        neg r1, r1
        ldr r0, =0x08083a24
        mov pc, r0


.align
.ltorg
addr:




