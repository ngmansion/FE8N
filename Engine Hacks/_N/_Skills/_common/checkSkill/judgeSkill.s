.thumb
@ユニットデータとスキルIDから、発動可能かを判定する
@I  r0 = ベースアドレス
@   r1 = スキルID
@O  -
    cmp r0, #0
    bne main
    bx lr
main:
    push {r4, r5, lr}
    mov r4, r0
    mov r5, r1
@ダミーユニットチェック
    ldr r0, [r4, #0]
    cmp r0, #0
    beq ret
    ldr r0, [r4, #4]
    cmp r0, #0
    beq ret
    cmp r1, #0
    beq ret
    
    bl impl
    cmp r0, #1
    beq ret

    bl ComplexSkill

ret:
    pop {r4, r5, pc}


impl:
    push {lr}
@書チェック
    mov r0, r4
    mov r1, r5
    bl CONTAINS_SKILL
    cmp r0, #1
    beq true
@ユニットデータチェック
    mov r0, r4
    mov r1, r5
    bl JUDGE_UNIT_FUNC
    cmp r0, #1
    beq true
@リストチェック
    bl judgeList
true:
    pop {pc}

ComplexSkill: @リストチェック
        push {r5, lr}
        cmp r5, #0x65
        beq falseComplex
@@@@@@@@
        bl GetSkillTable
        mul r5, r0
        add r5, r1
        add r5, #20
        ldr r5, [r5]
    loopComplex:
        ldrb r1, [r5]
        cmp r1, #0
        beq falseComplex
        mov r0, r4
        bl main
        cmp r0, #1
        beq endComplex
        add r5, #1
        b loopComplex

    falseComplex:
        mov r0, #0
    endComplex:
        pop {r5, pc}


judgeList: @リストチェック
        push {r6, lr}
        mov r0, r4
        mov r1, r5
        bl SKILL_LIST_UNIT
        cmp r0, #1
        beq returnList
@@@@@クラス
        mov r0, r4
        mov r1, r5
        bl SKILL_LIST_CLASS
        cmp r0, #1
        beq returnList
    skipClass:
@@@@@武器
        add r6, #4
        ldr r0, ITEM_CHECK_FLAG
        cmp r0, #0
        beq skipItem      @dontNeedItemCheck

        mov r0, r4
        mov r1, r5
        bl SKILL_LIST_WEAPON
        cmp r0, #1
        beq returnList
    @アイテム
        mov r0, r4
        mov r1, r5
        bl SKILL_LIST_ITEM
    skipItem:
    returnList:
        pop {r6, pc}

GetSkillTable:
    ldr r1, SKL_TBL_ADDR
    ldr r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr
GetCombatTable:
    ldr r1, COMBAT_TBL_ADDR
    ldr r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr



SKL_TBL_ADDR = ADDR+0
CONTAINS_SKILL:
    ldr r3, ADDR+4
    mov pc, r3
JUDGE_UNIT_FUNC:
    ldr r3, ADDR+8
    mov pc, r3
OCCULT_FLAG = ADDR+12
COMBAT_TBL_ADDR = ADDR+16
CHECK_ITEM_FUNC:
    ldr r3, ADDR+20
    mov pc, r3
ITEM_CHECK_FLAG = ADDR+24
JUDGE_OCCULT:
    ldr r3, ADDR+28
    mov pc, r3
SKILL_LIST_UNIT:
    ldr r3, ADDR+32
    mov pc, r3
SKILL_LIST_CLASS:
    ldr r3, ADDR+36
    mov pc, r3
SKILL_LIST_WEAPON:
    ldr r3, ADDR+40
    mov pc, r3
SKILL_LIST_ITEM:
    ldr r3, ADDR+44
    mov pc, r3

.align
.ltorg
ADDR:

