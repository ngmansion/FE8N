.thumb
        bl ResetGrowth

        mov r0, #0
        bl FirstGrowth
        ldr r1, MIN_STATUS_UP_NUM
        cmp r0, r1
        bge return

        bl RetryGrowth
        ldr r1, MIN_STATUS_UP_NUM
        cmp r0, r1
        bge return

        bl RetryGrowth
    return:
        ldr r0, =0x0802bb28
        mov pc, r0

ResetGrowth:
    mov r0, #0
    mov r1, #115
    strb r0, [r7, r1]
    mov r1, #116
    strb r0, [r7, r1]
    mov r1, #117
    strb r0, [r7, r1]
    mov r1, #118
    strb r0, [r7, r1]
    mov r1, #119
    strb r0, [r7, r1]
    mov r1, #120
    strb r0, [r7, r1]
    mov r1, #121
    strb r0, [r7, r1]
    mov r1, #122
    strb r0, [r7, r1]
    bx lr

FirstGrowth:
        push {r5, r6, lr}
        mov r6, r0

        ldr r5, addr
        .short 0xE000
    loopFirstGrowth:
        add r5, #4
        ldr r0, [r5]

        cmp r0, #0
        beq endFirstGrowth
        bl InGrowth
        add r6, r0
        b loopFirstGrowth

    endFirstGrowth:
        mov r0, r6
        pop {r5, r6, pc}

RetryGrowth:
        push {r5, r6, lr}
        mov r6, r0

        ldr r5, addr
        .short 0xE000
    loopRetryGrowth:
        add r5, #4
        ldr r0, [r5]
        cmp r0, #0
        beq endRetryGrowth

        bl InGrowth
        add r6, r0
@▼
        ldr r1, MIN_STATUS_UP_NUM
        cmp r6, r1
        bge endRetryGrowth          @目標達成
@△
        b loopRetryGrowth

    endRetryGrowth:
        mov r0, r6
        pop {r5, r6, pc}

STATUS_COUNT = (0)
UNIT_GROWTH = (1)
UNIT_STATUS = (4)
CLASS_GROWTH = (2)
CLASS_MAX = (5)
GROWTH_STORE = (3)
ITEM_STATUS = (6)       @成長率上昇アイテム用予定

InGrowth:
        push {r6, lr}
        mov r6, r0

        bl JudgeUpperLimit
        cmp r0, #1
        beq falseGrowth
        bl GetGrowthRate
        bl RANDOM_GROWTH

        mov r2, r7
        ldrb r3, [r6, #GROWTH_STORE]
        strb r0, [r2, r3]

        cmp r0, #1
        blt falseGrowth
        ldrb r0, [r6, #STATUS_COUNT]
        .short 0xE000
    falseGrowth:
        mov r0, #0
        pop {r6, pc}



JudgeUpperLimit:
        push {lr}
@▼
        ldrb r0, [r6, #GROWTH_STORE]
        ldrb r0, [r7, r0]
        cmp r0, #1
        bge trueMaximum                  @既に上昇している
@△
        ldrb r0, [r7, #0xB]
        bl GET_UNIT_DATA
        ldrb r3, [r6, #UNIT_STATUS]      @ユニットのステータス
        ldrb r0, [r3, r0]

        ldr r1, [r7, #4]
        ldrb r3, [r6, #CLASS_MAX]        @クラスのステータス最大値オフセット
        ldrb r1, [r3, r1]
        cmp r0, r1
        blt notMaximum
    trueMaximum:
        mov r0, #1
        .short 0xE000
    notMaximum:
        mov r0, #0
        pop {pc}

GET_UNIT_DATA:
ldr r1, =0x08019108
mov pc, r1

GetGrowthRate:
        ldr r0, AVERAGE_GROWTH_MODE
        cmp r0, #1
        beq classAverageMode
        ldrb r0, [r6, #UNIT_GROWTH]   @ユニット成長率オフセット
        ldr r1, [r7, #0]
        ldrb r0, [r0, r1]
        b mergeGrowth

    classAverageMode:
        ldrb r0, [r6, #UNIT_GROWTH]   @ユニット成長率オフセット
        ldr r1, [r7, #0]
        ldrb r0, [r0, r1]

        ldrb r2, [r6, #CLASS_GROWTH]   @クラス成長率オフセット
        ldr r1, [r7, #4]
        ldrb r2, [r2, r1]

        add r0, r2
        asr r0, r0, #1
    mergeGrowth:
        add r0, sl              @メティス上昇分
        bx lr

RANDOM_GROWTH:
        ldr r1, =0x0802b8e8
        mov pc, r1


$0802b8e8:
ldr r1, =0x0802b8e8
mov pc, r1

GrowthTable = addr+0
AVERAGE_GROWTH_MODE = addr+4
MIN_STATUS_UP_NUM = addr+8

.align
.ltorg
addr:


