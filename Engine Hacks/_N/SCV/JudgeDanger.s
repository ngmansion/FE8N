.thumb

BATTLE_SIZE = (128)

JudgeDanger:
        push {r6, lr}
        sub sp, #BATTLE_SIZE

        ldr r0, =0x0203a4e8
        ldr r1, =0x03004df0
        ldr r1, [r1]

        ldrb r2, [r0, #0x0B]
        ldrb r3, [r1, #0x0B]
        cmp r2, r3
        beq cached
        bl SetInitDataR1toR0
    cached:
        mov r0, sp
        mov r1, r4
        bl SetInitDataR1toR0

        mov r0, sp
        ldr r1, =0x0203a4e8
        bl CALC_TRIANGLE_FUNC

        mov r0, sp
        ldr r1, =0x0203a4e8
        bl CalcAttackFunc

        ldr r0, =0x0203a4e8
        mov r1, sp
        bl CalcDefenseFunc

        mov r0, sp
        ldr r1, =0x0203a4e8
        bl CALC_VERSUS_FUNC

        ldr r0, =0x0203a4e8
        mov r1, sp
        bl CALC_VERSUS_FUNC

        mov r0, sp
        ldr r1, =0x0203a4e8
        bl DoubleAttack
        mov r6, r0

        mov r0, #90
        add r0, sp
        ldrh r0, [r0]       @攻撃

        ldr r2, =0x0203a4e8
        mov r1, #92
        ldrh r1, [r2, r1]   @防御
        sub r0, r1
        ble falseJudgeDanger  @ノーダメージなら終了

        mov r1, sp
        ldr r2, =0x0203a4e8
        bl DEF_DIVIDE
        lsl r0, r6          @追撃や勇者を加味
        ldr r2, =0x0203a4e8
        ldrb r1, [r2, #19]  @現在HP
        cmp r1, r0
        ble trueJudgeDanger      @即死する
    falseJudgeDanger:
        mov r0, #0
        .short 0xE000
    trueJudgeDanger:
        mov r0, #1

        add sp, #BATTLE_SIZE
        pop {r6, pc}


UNIT_SIZE = (72)

SetInitDataR1toR0:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

        mov r2, #UNIT_SIZE
        bl MEMCPY_R1toR0_FUNC

        ldr r1, =0x0203a4e8
        cmp r4, r1
        bne atkSide            @自キャラ以外は不要

        bl InitializeDEF
        .short 0xE001
    atkSide:
        bl InitializeATK
        pop {r4, r5, pc}

InitializeATK:
        push {lr}
        mov r0, r5
        bl STRONG_FUNC
        strb r0, [r4, #20]
        bl MagicFuncIfNeed

        mov r0, r5
        bl SPEED_FUNC
        strb r0, [r4, #22]
        mov r0, r5
        bl MAX_HIT_POINT_FUNC       @HP発動スキル用
        strb r0, [r4, #18]
        
        mov r0, r4
        bl EquipmentFunc
        pop {pc}

InitializeDEF:
        push {lr}

        mov r0, r5
        bl DEFENSE_FUNC
        strb r0, [r4, #23]

        mov r0, r5
        bl RESIST_FUNC
        strb r0, [r4, #24]

        mov r0, r4
        bl CALC_TERRAIN_FUNC

        mov r0, r5
        bl SPEED_FUNC
        strb r0, [r4, #22]

        mov r0, r5
        bl MAX_HIT_POINT_FUNC       @HP発動スキル用
        strb r0, [r4, #18]

        mov r0, r4
        bl EquipmentFunc
        pop {pc}

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
        b mergeMagic

    notMagic:
        ldr r2, [r5, #0]
        ldr r3, [r5, #4]
        ldrb r2, [r2, #19]
        ldrb r3, [r3, #17]
        add r0, r2, r3

        ldrb r2, [r5, #26]
        add r0, r2

        strb r0, [r4, #26]
    mergeMagic:
        pop {pc}

EquipmentFunc:
        push {r4, r5, r6, lr}
        mov r6, r0

        mov r2, #0
        mov r1, #83
        strb r2, [r6, r1]       @すくみ初期化
        mov r1, #84
        strb r2, [r6, r1]       @すくみ初期化

        bl $080168d0
        ldr r1, =0x0802a894
        mov pc, r1

$080168d0:
    ldr r1, =0x080168d0
    mov pc, r1


CalcAttackFunc:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

        ldr r2, =0x0802aa28     @攻撃
        mov lr, r2
        .short 0xF800

        mov r0, r4
        ldr r2, =0x0802aae4     @攻速
        mov lr, r2
        .short 0xF800

        ldr r0, =0x0802a8f8
        mov pc, r0


CalcDefenseFunc:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1

            ldr r2, =0x0802a9b0     @防御
            mov lr, r2
            .short 0xF800

        mov r0, r4
            ldr r2, =0x0802aae4     @攻速
            mov lr, r2
            .short 0xF800

        ldr r0, =0x0802a8f8
        mov pc, r0


DoubleAttack:
        push {r5, r6, r7, lr}
        mov r5, r0
        mov r6, r1
        mov r7, #0
        
        bl FllowUpFunc
        add r7, r0

        mov r0, r5
        mov r1, r6
        bl BraveFunc
        add r7, r0

        mov r0, r7
        pop {r5, r6, r7, pc}

BraveFunc:
        push {r6, lr}
        mov r6, r8
        push {r6}
        mov r6, r0
        mov r8, r1
        bl CALC_BRAVE_FUNC
        pop {r6}
        mov r8, r6
        pop {r6, pc}

FllowUpFunc:
        push {r4, lr}
        sub sp, #8
        mov r4, r0

        str r0, [sp]
        str r1, [sp, #4]
        mov r0, sp
        add r1, sp, #4

        bl CalcFollowUpFunc
@        ldr r1, [sp]
@        cmp r1, r4
@        beq endFollowUp
@        mov r0, #0
    endFollowUp:
        add sp, #8
        pop {r4, pc}


MAX_HIT_POINT_FUNC:
    ldr r2, =0x08018ea4
    mov pc, r2
STRONG_FUNC:
    ldr r2, =0x08018ec4
    mov pc, r2
DEFENSE_FUNC:
    ldr r2, =0x08018f64
    mov pc, r2
RESIST_FUNC:
    ldr r2, =0x08018f84
    mov pc, r2
SPEED_FUNC:
    ldr r2, =0x08018f24
    mov pc, r2

CALC_TERRAIN_FUNC:
    ldr r2, =0x0802a648
    mov pc, r2

CALC_TRIANGLE_FUNC:
    ldr r2, =0x0802c6f8
    mov pc, r2
@CALC_ALL_FUNC:
@    ldr r2, =0x0802a8c8
@    mov pc, r2
CALC_VERSUS_FUNC:
    ldr r2, =0x0802ad3c
    mov pc, r2
CalcFollowUpFunc:
    push {r4, r5, r6, r7, lr}
    mov r4, r0
    mov r7, r1

    ldr r0, [r4]
    ldr r2, [r7]
    mov r6, r2
    add r2, #94
    mov r3, #0
    ldsh r3, [r2, r3]
    cmp r3, #250
    bgt falseFollowUp
    ldr r1, =0x0802af18
    mov pc, r1
falseFollowUp:
    mov r0, #0
    pop {r4, r5, r6, r7, pc}

CALC_BRAVE_FUNC:
    ldr r2, =0x0802b004
    mov pc, r2

MEMCPY_R1toR0_FUNC:
    ldr r3, =0x080d6908
    mov pc, r3

CheckXY:
@r1とr2がr0マス以内に居るならr0=TRUE
@同座標ならTRUE
@
        ldr r1, =0x03004df0
        ldr r1, [r1]
        mov r2, r4
        push {r0}
        ldrb r0, [r1, #16]
        ldrb r3, [r2, #16]
        sub r3, r0, r3
        bge jump1CheckXY
        neg r3, r3  @絶対値取得
    jump1CheckXY:

        ldrb r1, [r1, #17]
        ldrb r2, [r2, #17]
        sub r2, r1, r2
        bge jump2CheckXY
        neg r2, r2  @絶対値取得
    jump2CheckXY:

        add r2, r2, r3
        pop {r0}
        cmp r2, r0
        bgt falseCheckXY    @r0マス以内に居ない
    trueCheckXY:
        mov r0, #1
        bx lr
    falseCheckXY:
        mov r0, #0
        bx lr

DEF_DIVIDE:
ldr r3, addr+0
mov pc, r3

.align
.ltorg
addr:
