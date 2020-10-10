.thumb
RETURN_ADDR  = (0x0808e80e)
RETURN_ADDR2 = (0x0808e814) @何もしない

WAR_OFFSET = (67)

    mov r0, #63     @0x3F
    and r0, r6
    cmp r0, #0
    bne dont_need

    sub sp, #80 @装備あたりまで
    mov r0, sp
    bl SetPow
    add sp, #80

    bl GetFirstNum
    cmp r0, #99
    .short 0xdd00
    mov r0, #255
    bl $00003868

    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3251
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3152
    .short 0x7008

    bl GetSecondNum
    cmp r0, #99
    .short 0xdd00
    mov r0, #255
    bl $00003868
    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3253
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3154
    .short 0x7008

    bl Draw_Word
    ldr r0, =RETURN_ADDR
    mov pc, r0
dont_need:
    ldr r0, =RETURN_ADDR2
    mov pc, r0

JudgeDraw:
        mov r0, #0x80   @64     @0x40
        and r0, r6
        bx lr

Draw_Word:
        push {lr}
        bl JudgeDraw
        cmp r0, #0
        beq Draw_AtAs
        b   Draw_DfRs
Draw_AtAs:
        ldr r1, [r4, #64]
        mov r2, #0
        ldr r3, =0x2163
        strh    r3, [r1, #0]
        add r3, #1
        strh    r3, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        add r3, #1
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]
        pop {pc}
Draw_DfRs:
        ldr r1, [r4, #64]
        mov r2, #0
        ldr r3, =0x2166
        strh    r3, [r1, #0]
        add r3, #1
        strh    r3, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        add r3, #1
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]
        pop {pc}


GetFirstNum:
        push {lr}
        bl JudgeDraw
        cmp r0, #0
        beq GetAttack
        b   GetDefence
GetAttack:
        ldr r0, =0x0203a568
        mov r1, #72
        ldrh r1, [r1, r0]
        cmp r1, #0
        beq falseAT

        mov r1, #90
        ldrh r0, [r1, r0]
        .short 0xE000
    falseAT:
        mov r0, #0xFF
        pop {pc}
GetDefence:
        ldr r0, =0x0203a568
        mov r1, #92
        ldrh r0, [r1, r0]
        pop {pc}


GetSecondNum:
        push {lr}
        bl JudgeDraw
        cmp r0, #0
        beq GetSpeed
        b   GetResistance
GetSpeed:
        ldr r0, =0x0203a568
        mov r1, #94
        ldrh r0, [r1, r0]
        pop {pc}
GetResistance:
        ldr r3, =0x0203a568
        mov r0, r3
        add r0, #86
        ldrb r0, [r0, #0]
        lsl r0, r0, #24
        asr r0, r0, #24
        mov r1, #23
        ldsb r1, [r3, r1]
        add r2, r0, r1

        mov r0, r3
        add r0, #88
        ldrb r0, [r0, #0]
        lsl r0, r0, #24
        asr r0, r0, #24
        mov r1, #24
        ldsb r1, [r3, r1]
        add r1, r0, r1

        ldr r0, =0x0203a568
        add r0, #92
        ldrh r0, [r0]

        add r0, r0, r1
        sub r0, r0, r2
        pop {pc}

COPY_SIZE = (72)

SetPow:
        push {r4, r5, lr}
        ldr r4, =0x0203a568

        mov r1, r5
        mov r5, r0
        mov r0, r4
        bl AtkSideFunc

        mov r0, r5
        bl DefSideFunc

@※0002a8c8
        mov r0, r4
        mov r1, r5
            ldr r2, =0x0802a9b0     @防御
            mov lr, r2
            .short 0xF800

        mov r0, r4
        mov r1, r5
            ldr r2, =0x0802aa28     @攻撃
            mov lr, r2
            .short 0xF800

        mov r0, r4
        mov r1, r5
            ldr r2, =0x0802aae4     @攻速
            mov lr, r2
            .short 0xF800

        ldr r0, =0x0802a8f8
        mov pc, r0


AtkSideFunc:
        push {r4, r5, r6, lr}       @装備処理に合わせる
        mov r4, r0
        mov r5, r1
        mov r6, r4

        mov r0, r4
        mov r1, r5
        mov r2, #COPY_SIZE
        bl MEMCPY_R1toR0_FUNC

        mov r0, r5
        bl STRONG_FUNC
        strb r0, [r4, #20]

        mov r0, r5
        bl SPEED_FUNC
        strb r0, [r4, #22]

        mov r0, r5
        bl DEFENCE_FUNC
        strb r0, [r4, #23]

        mov r0, r5
        bl RESISTANCE_FUNC
        strb r0, [r4, #24]

        bl MagicFuncIfNeed

        mov r0, r4
        bl TERRAIN_FUNC

        mov r2, #0
        mov r1, #83
        strb r2, [r4, r1]       @すくみ初期化
        mov r1, #84
        strb r2, [r4, r1]       @すくみ初期化

@以降装備処理
        mov r0, r4
        bl $080168d0
        ldr r1, =0x0802a894
        mov pc, r1


MagicFuncIfNeed:
        push {lr}
        ldr r3, =0x08018ecc     @magic_func
        ldr r1, [r3]
        ldr r2, =0x468F4900
        cmp r1, r2
        bne notMagic        @魔力パッチなしならジャンプ

        mov r0, r5
            mov lr, r3
            .short 0xF800
        strb r0, [r4, #26]
        b endMagic
    notMagic:
        ldr r2, [r5, #0]
        ldr r3, [r5, #4]
        ldrb r2, [r2, #19]
        ldrb r3, [r3, #17]
        add r0, r2, r3

        ldrb r2, [r5, #26]
        add r0, r2

        strb r0, [r4, #26]
    endMagic:
        pop {pc}

$00003868:
    ldr r1, =0x08003868
    mov pc, r1

$080168d0:
    ldr r1, =0x080168d0
    mov pc, r1


DefSideFunc:
        mov r1, #0
        str r1, [r0, #0]    @ユニット不明
        str r1, [r0, #4]    @兵種不明
        str r1, [r0, #8]    @状態不明

        mov r1, #0xFF
        strb r1, [r0, #0xb] @所属不明

        mov r1, #0
        add r0, #WAR_OFFSET
        strb r1, [r0, #0xb] @戦技不明
        sub r0, #WAR_OFFSET

        mov r1, #0
        add r0, #0x48
        strh r1, [r0] @装備不明

        bx lr

STRONG_FUNC:
    ldr r2, =0x08018ec4
    mov pc, r2

SPEED_FUNC:
    ldr r2, =0x08018f24
    mov pc, r2

DEFENCE_FUNC:
    ldr r2, =0x08018f64
    mov pc, r2

RESISTANCE_FUNC:
    ldr r2, =0x08018f84
    mov pc, r2

TERRAIN_FUNC:
    ldr r2, =0x0802a648
    mov pc, r2

MEMCPY_R1toR0_FUNC:
    ldr r3, =0x080d6908
    mov pc, r3
.align
.ltorg
ADDR:
