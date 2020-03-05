.thumb

        mov r1, #92
        ldrb r1, [r0, r1]
        mov r2, #0x1                @anim_offでは#16~12まで保存(ここでは12)
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
        bx lr

.align
.ltorg
addr:




