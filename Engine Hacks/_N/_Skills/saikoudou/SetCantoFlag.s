.thumb

    ldr r2, [r4, #0]
    ldr r0, [r2, #12]
    mov r1, #64
    orr r0, r1         @0x40を加える
    sub r1, #67
    and r0, r1         @0x02を落とす
@@@@@@@@@@@
    ldr r1, =0x80000000
    orr r0, r1
@@@@@@@@@@@
    str r0, [r2, #12]

    ldr r1, =0x0801cf2a
    mov pc, r1


