.thumb
@ hint 0x07cc22でビットを減らした状態で格納
@

SOL_BIT = (addr+0)

        mov r2, #0x80
        ldr r1, SOL_BIT
        lsl r2, r1
        ldrh r1, [r4, #0]
        tst r1, r2
        beq normal

        mov r1, #93
        ldsb r1, [r0, r1]
        b merge
    normal:
        mov r1, #93
        ldsb r1, [r0, r1]
        asr r1, #1
    merge:
        neg r1, r1
        ldr r0, =0x08083a24
        mov pc, r0


.align
.ltorg
addr:




