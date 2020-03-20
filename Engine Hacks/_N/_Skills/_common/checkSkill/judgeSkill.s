
SKL_TBL = ADR+0
CONTAINS_SKILL = ADR+4
JUDGE_UNIT_FUNC = ADR+8
WP_LV_SKL_TABLE = ADR+12
SKL_TBL_SIZE = ADR+16
CHECK_ITEM_FUNC = ADR+20

@
@	judgeUnitと横並びの作り
@
.thumb
@ユニットデータとスキルIDから、発動可能かを判定する
    cmp r0, #0
    bne main
    bx lr
main:
    push {r4, r5, lr}
    mov r4, r0
    mov r5, r1
    bl impl
    cmp r0, #1
    beq ret

    bl ComplexSkill

ret:
    pop {r4, r5, pc}


impl:
    push {lr}

    ldr r0, [r4, #0]
    cmp r0, #0
    beq return
    ldr r0, [r4, #4]
    cmp r0, #0
    beq return
@書チェック
    mov r0, r4
    mov r1, r5
    bl containsSkill
    cmp r0, #1
    beq return
@ユニットデータチェック
    mov r0, r4
    mov r1, r5
    bl judgeSkillInUnitData
    cmp r0, #1
    beq return
@リストチェック
    bl judgeList
@武器レベルチェック
@    bl JudgeWpLv
@    cmp r0, #0
@    bne true
return:
    pop {pc}

ComplexSkill: @リストチェック
        push {r6, lr}
        ldr r6, SKL_TBL
        ldr r0, SKL_TBL_SIZE
        mul r0, r5
        add r6, r0
        add r6, #20
        ldr r6, [r6]
    loopComplex:
        ldrb r1, [r6]
        cmp r1, #0
        beq falseComplex
        mov r0, r4
        bl main
        cmp r0, #1
        beq endComplex
        add r6, #1
        b loopComplex

    falseComplex:
        mov r0, #0
    endComplex:
        pop {r6, pc}


judgeList: @リストチェック
        push {r6, lr}
        ldr r6, SKL_TBL
        ldr r0, SKL_TBL_SIZE
        mul r0, r5
        add r6, r0
    @ユニット
        add r6, #4
        ldr r2, [r6]
        ldr r1, [r4]
        ldrb r1, [r1, #4]
        bl Listfunc
        cmp r0, #1
        beq returnList
    @クラス
        add r6, #4
        ldr r2, [r6]
        ldr r1, [r4, #4]
        ldrb r1, [r1, #4]
        bl Listfunc
        cmp r0, #1
        beq returnList
    @武器
        add r6, #4
        
        bl GetWeapon
        lsl r1, r0, #24
        lsr r1, r1, #24

        ldr r2, [r6]
        bl Listfunc
        cmp r0, #1
        beq returnList
    @アイテム
        add r6, #4
        mov r0, r4
        ldr r1, [r6]
        bl checkItemList	@5か所判定するので1層潜る
    returnList:
        pop {r6, pc}

Listfunc:
@r2 = リスト先頭ポインタ
@r1 = 検索キー
    whileLoop:
        ldrb r0, [r2]
        cmp r0, #0
        beq endLoop
        cmp r0, r1
        beq trueLoop
        add r2, #1
        b whileLoop
    trueLoop:
        mov r0, #1
    endLoop:
        bx lr

GetWeapon:
        ldr r1, =0x0203a4e8
        cmp r4, r1
        beq notWeapon
        ldr r1, =0x0203a568
        cmp r4, r1
        beq notWeapon
        push {lr}
            mov r0, r4
            ldr r1, =0x080168d0
            mov lr, r1
            .short 0xF800
        pop {pc}
    notWeapon:
        mov r1, #74
        ldrh r0, [r4, r1]
        bx lr

JudgeWpLv:
    push {r4, r5, r6, lr}
    mov r5, r0
    mov r6, r1
    mov r4, #0
loopJudgeWpLv:
    mov r0, r5
    mov r1, r6
    bl CheckWp
    cmp r0, #1
    beq endJudgeWpLv
    add r4, #1
    cmp r4, #8	@無効武器
    blt loopJudgeWpLv
    mov r0, #0
endJudgeWpLv:
    pop {r4, r5, r6, pc}

CheckWp:
    push {lr}

    add	r0, #40
    ldrb	r0, [r0, r4]
        ldr r1, =0x08016b04
        mov lr, r1
        .short 0xF800
    ldr r3, WP_LV_SKL_TABLE
    cmp r0, #1
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    
    add r3, #8
    cmp r0, #2
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    
    add r3, #8
    cmp r0, #3
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    
    add r3, #8
    cmp r0, #4
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    
    add r3, #8
    cmp r0, #5
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    
    add r3, #8
    cmp r0, #6
    blt falseCheckWp
    ldrb r1, [r3, r4]
    cmp r6, r1
    beq trueCheckWp
    b falseCheckWp
    
trueCheckWp:
    mov r0, #1
    b endCheckWp
falseCheckWp:
    mov r0, #0
endCheckWp:
    pop {pc}

containsSkill:
    ldr r3, CONTAINS_SKILL
    mov pc, r3
judgeSkillInUnitData:
    ldr r3, JUDGE_UNIT_FUNC
    mov pc, r3
checkItemList:
    ldr r3, CHECK_ITEM_FUNC
    mov pc, r3
.align
.ltorg
ADR:

