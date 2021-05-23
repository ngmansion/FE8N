.thumb

counting_icon_num   .req r7
icon_list           .req r8
max_icon_num        .req r9
base_status         .req r10

GATHER_SKILL:
@ ***
@I  r0 = ベースアドレス
@   r1 = IconList
@   r2 = Max num
@O  r0 = gather num
        push {r4, r5, r6, lr}
        mov r4, r8
        mov r5, r9
        mov r6, r10
        push {r4, r5, r6}
@@@@@@@@
        mov counting_icon_num, #0
        mov base_status, r0
        mov icon_list, r1
        mov max_icon_num, r2
        bl initialize
        ldr r0, SKILL_LIST_WEAPON
        bl GatherListSkill
        bl GatherUnit       @Book and Unitdata
        bl GatherListUC     @Ignore Weapon and Item
        bl GatherAbility
    endGather:
        mov r0, counting_icon_num
@@@@@@@@
        pop {r4, r5, r6}
        mov r8, r4
        mov r9, r5
        mov r10, r6
        pop {r4, r5, r6, pc}

initialize:
        mov r0, #0
        mov r1, icon_list
        mov r2, max_icon_num
        mov r3, #0
    loopInit:
        cmp r3, r2
        bge endInit

        strb r0, [r1, r3]
        add r3, #1
        b loopInit
    endInit:
        bx lr
GatherUnit:
        push {lr}
        bl BookFunc
        bl UnitDataFunc
        pop {pc}

BookFunc:
        push {r4, lr}
        mov r4, #0
    loopBook:
        cmp r4, #6
        bge endBook
        mov r0, base_status
        mov r1, r4
        bl GET_BOOK_SKILL
        cmp r0, #0
        beq endBook
        bl SetSkill

        add r4, #1
        b loopBook
    endBook:
        pop {r4, pc}

UnitDataFunc:
        push {lr}

        mov r0, base_status
        bl UNITDATA_GetFirst
        bl SetSkill         @下級スキル

        mov r0, base_status
        bl UNITDATA_GetSecond
        bl SetSkill         @上級スキル

        mov r0, base_status
        bl UNITDATA_GetThird
        bl SetSkill         @自軍外スキル
        pop {pc}	


GatherListUC:
        push {lr}
        ldr r0, SKILL_LIST_UNIT
        bl GatherListSkill

        ldr r3, SKIP_CLASS_MODE
        cmp r3, #1
        beq skipUC
        ldr r0, SKILL_LIST_CLASS
        bl GatherListSkill
    skipUC:
        ldr r0, SKILL_LIST_ITEM
        bl GatherListSkill
        pop {pc}

GatherListSkill:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, #0
    loopListSkill:
        add r5, #1
        cmp r5, #255
        bgt endListSkill
        mov lr, r4
        mov r1, r5
        mov r0, base_status
        .short 0xF800
        cmp r0, #0
        beq loopListSkill
        mov r0, r5
        bl SetSkill
        b loopListSkill
    endListSkill:
        pop {r4, r5, pc}

@@@@@@@@@@@@@@@@@

GatherAbility:
        push {lr}
        ldr r3, SKIP_CLASS_MODE
        cmp r3, #1
        beq skipLuna
        mov r0, base_status
        bl UNITDATA_GetLuna
        bl SetSkill
    skipLuna:
        mov r3, base_status
        ldr r0, [r3, #4]        @兵種
        ldr r0, [r0, #40]
        mov r2, #0x80
        lsl r2, r2, #17         @兵種EXP0
        bic r0, r2
        ldr r1, [r3]            @個人
        ldr r1, [r1, #40]
        orr r0, r1

        ldr r1, ABILITY_BINARY
        bl AbilityFunc          @表示のみ

        pop {pc}

@@@@@@@@@@@@@@@@

AbilityFunc: @ability仕様
@
@r0= abilityBit
@r1= ABILITY.binのポインタ
@
        push {r4, r5, lr}
        cmp r0, #0
        beq falseAbi
        mov r4, r0
        mov r5, r1
        b testAbi


    restartAbi:
        mov r0, r4
        mov r2, #0x10
    loopAbi:
        ldr r1, [r5, r2]
        cmp r1, #0
        beq jumpAbi
        and r1, r0
        bne skillerAbi      @BitOn
        add r2, #4
        cmp r2, #0x20
        beq jumpAbi         @LISTlimit
        b loopAbi

    skillerAbi:
        ldrb r0, [r5, #0]
        bl SetSkill

    jumpAbi:
        add r5, #0x20
    testAbi:
        ldr r0, [r5]
        ldr r1, =0xFFFFFFFF
        cmp r0, r1
        bne restartAbi
    falseAbi:
        pop {r4, r5, pc}

@@@@@@@@@@@@@@@@

SetSkill:
        push {r4, lr}
        cmp r0, #0
        beq endSet
        mov r4, r0

        mov r1, max_icon_num
        cmp counting_icon_num, r1
        bge endSet          @マックス

        mov r0, r4
        bl IsMultipleSkill
        cmp r0, #1
        beq endSet          @重複

        mov r0, base_status
        mov r1, r4
        bl NeedSetFunc
        cmp r0, #0
        beq endSet

        mov r0, icon_list
        strb r4, [r0, counting_icon_num]
        add counting_icon_num, #1
    endSet:
        pop {r4, pc}

IsMultipleSkill:
        mov r3, icon_list
        mov r2, #0
    loopDedup:
        cmp r2, counting_icon_num
        bge falseDedup      @末尾まで到達
        ldrb r1, [r3, r2]
        cmp r0, r1
        beq trueDedup       @重複あり
        add r2, #1
        b loopDedup
    trueDedup:
        mov r0, #1
        .short 0xE000
    falseDedup:
        mov r0, #0
        bx lr

@@@@@@@@@@@@@@@@

NeedSetFunc:
@r0 = base_status
@r1 = skill_id
@
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        ldr r0, COMBAT_MODE
        cmp r0, #0
        beq judgeNormlMode
        mov r0, r5
        bl JudgeCombatSkill
        b endCombatMode
    judgeNormlMode:
        ldr r3, SKL_TBL                 @skl_icon_table
        ldr r1, SKL_TBL_SIZE
        mul r1, r5
        add r3, r3, r1

        ldrb r0, [r3, #3]
        mov r1, #1
        tst r0, r1
        bne falseCombatMode               @無視フラグ

        ldrh r0, [r3]
        cmp r0, #0
        beq falseCombatMode               @ヘルプ無し
        mov r0, #1
        .short 0xE000
    falseCombatMode:
        mov r0, #0
    endCombatMode:
        pop {r4, r5, pc}

JudgeCombatSkill:
        push {lr}
        bl GetCombatTable
        mul r5, r0
        add r5, r1
        ldrb r2, [r5, #6]
        cmp r2, #0
        beq falseCombat

        bl JudgeSpecialWeapon
        cmp r0, #0
        beq falseCombat

        bl MatchWeaponType
        cmp r0, #0
        beq falseCombat

        bl JudgeCost
        cmp r0, #0
        beq falseCombat

        bl JudgeRange       @2
        cmp r0, #0
        beq falseCombat

        bl JudgeCombatOccult      @4
        cmp r0, #0
        beq falseCombat

        mov r0, #1
        .short 0xE000
    falseCombat:
        mov r0, #0
        pop {pc}

JudgeSpecialWeapon:
        push {lr}

        mov r0, r4
        ldr r0, [r0, #76]
        mov r1, #0x80
        tst r0, r1
        bne falseSpecial    @反撃不可武器は無効

        mov r0, r4
        add r0, #74
        ldrh r0, [r0]
        bl GetWeaponAbility
        cmp r0, #3
        beq falseSpecial
    trueSpecial:
        mov r0, #1
        .short 0xE000
    falseSpecial:
        mov r0, #0
        pop {pc}


JudgeCombatOccult:
        push {lr}
        mov r0, r5  @必要
        ldrb r0, [r0, #6]
        mov r1, #0b1000
        tst r0, r1
        bne falseOccult     @不可奥義

        mov r1, #0b0100
        tst r0, r1
        beq trueOccult      @無関係

        ldr r0, BOOL_ENEMY
        cmp r0, #1
        beq falseOccult
        b trueOccult

    falseOccult:
        mov r0, #0
        .short 0xE000
    trueOccult:
        mov r0, #1
        pop {pc}

JudgeRange:
        push {lr}

        ldrb r0, [r5, #6]
        mov r1, #2
        tst r0, r1
        beq trueRange       @2じゃなければフリーレンジ

        ldr r0, BOOL_ENEMY
        cmp r0, #0
        beq allyRange

        mov r0, r4
        add r0, #74
        ldrh r0, [r0]
        bl GetWeaponRange
        mov r1, #0b00001111
        and r0, r1
        cmp r0, #1
        beq trueRange
        b falseRange
    allyRange:
        mov r0, r4
        add r0, #74
        ldrh r0, [r0]
        bl GetWeaponRange
        mov r1, #0b11110000
        and r0, r1
        cmp r0, #0x10
        bne falseRange      @短射程武器じゃなければNG

        mov r0, r4
        ldr r1, =0x0101     @てつのけん
        ldr r2, =0x08025164 @攻撃可能か確認
        mov lr, r2
        .short 0xF800
        ldr r2, =0x08050a9c @攻撃可能か確認
        mov lr, r2
        .short 0xF800
        b endRange
    trueRange:
        mov r0, #1
        b endRange
    falseRange:
        mov r0, #0
    endRange:
        pop {pc}

MatchWeaponType:
        push {r6, lr}

        ldrb r6, [r5, #5]
        cmp r6, #0xFF
        beq trueType

        mov r0, r4
        add r0, #72
        ldrh r0, [r0]
        bl GetWeaponType
        cmp r0, r6
        beq trueType
        mov r0, #0
        .short 0xE000
    trueType:
        mov r0, #1
        pop {r6, pc}

JudgeCost:
        push {lr}

        mov r0, r4
        add r0, #72
        ldrh r0, [r0]
        lsr r0, #8

        ldrb r1, [r5, #4]

        cmp r0, r1
        bge trueCost
        mov r0, #0
        .short 0xE000
    trueCost:
        mov r0, #1
        pop {pc}

@@@@@@@@@@@@@@@@

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

GetCombatTable:
    ldr r1, COMBAT_TBL_ADDR
    ldr r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr


GetWeaponAbility:
    ldr r1, =0x080174cc
    mov pc, r1

GetWeaponType:
    ldr r3, =0x080172f0
    mov pc, r3

GetWeaponRange:
    ldr r3, =0x08017448     @武器の射程
    mov pc, r3

COMBAT_MODE = (ADDR+0)
ABILITY_BINARY = (ADDR+4)
SKL_TBL = (ADDR+8)
SKL_TBL_SIZE = (ADDR+12)
GET_BOOK_SKILL:
    ldr r3, ADDR+16
    mov pc, r3
COMBAT_TBL_ADDR = (ADDR+20)
BOOL_ENEMY = (ADDR+24)
JUDGE_OCCULT:
    ldr r3, ADDR+28
    mov pc, r3
UNITDATA_GetFirst:
    ldr r1, (ADDR+32)
    mov pc, r1
UNITDATA_GetSecond:
    ldr r1, (ADDR+36)
    mov pc, r1
UNITDATA_GetThird:
    ldr r1, (ADDR+40)
    mov pc, r1
UNITDATA_GetLuna:
    ldr r1, (ADDR+44)
    mov pc, r1
SKIP_CLASS_MODE = (ADDR+48)
SKILL_LIST_UNIT       = (ADDR+52)
SKILL_LIST_CLASS      = (ADDR+56)
SKILL_LIST_WEAPON     = (ADDR+60)
SKILL_LIST_ITEM       = (ADDR+64)
.align
.ltorg
ADDR:
