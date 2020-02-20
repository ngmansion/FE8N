.thumb


        push {r6, lr}
        mov r6, r1

        bl GetGrowthRate




        bl $0802b8e8

        ldrb r2, [r6, #0]
        cmp r2, #0
        beq dontNeedCount


        ldrb r0, [r6, #3]   @成長書き込みオフセット
        ldrb r0, [r6, #4]   @ユニットのステータスオフセット
        ldrb r0, [r6, #5]   @クラスのステータス最大値オフセット
        ldrb r0, [r7, r0]



    dontNeedCount:



    falseGrowth:
        mov r0, #0
        .short 0xE000
    trueGrowth:
        mov r0, #1


    needCount:
        pop {r6, pc}

GetGrowthRate:
        cmp r0, #1
        beq ClassAverageMode
        ldrb r0, [r6, #1]   @ユニット成長率オフセット
        ldr r1, [r7, #0]
        ldrb r0, [r0, r1]

        bx lr
ClassAverageMode:
        ldrb r0, [r6, #1]   @ユニット成長率オフセット
        ldr r1, [r7, #0]
        ldrb r0, [r0, r1]

        ldrb r2, [r6, #2]   @クラス成長率オフセット
        ldr r1, [r7, #4]
        ldrb r2, [r2, r1]

        add r0, r2
        asr r0, r0, #2
        bx lr



$0802b8e8:
ldr r1, =0x0802b8e8
mov pc, r1

NEED_COUNT = addr+0

.align
.ltorg
addr:






