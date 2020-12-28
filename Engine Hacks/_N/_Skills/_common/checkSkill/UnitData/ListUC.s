.thumb
b SKILL_LIST_UNIT
b SKILL_LIST_CLASS
b SKILL_LIST_WEAPON
b SKILL_LIST_ITEM

.align
@
@I  r0 = ベースアドレス
@   r1 = スキルID
@
SKILL_LIST_UNIT:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl GetSkillTable
        mul r5, r0
        add r5, r1
@@@@@@@@
        add r5, #4
        ldr r2, [r5]
        ldr r1, [r4, #0]
        ldrb r1, [r1, #4]
        bl Listfunc
        pop {r4, r5, pc}


SKILL_LIST_CLASS:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl IsSpecialSkill
        cmp r0, #0
        beq endClass

        bl GetSkillTable
        mul r5, r0
        add r5, r1
@@@@@@@@
        add r5, #8
        ldr r2, [r5]
        ldr r1, [r4, #4]
        ldrb r1, [r1, #4]
        bl Listfunc
    endClass:
        pop {r4, r5, pc}


SKILL_LIST_WEAPON:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl GetSkillTable
        mul r5, r0
        add r5, r1
@@@@@@@@
        add r5, #12

        bl GetWeapon
        mov r1, r0
        ldr r2, [r5]
        bl Listfunc
        pop {r4, r5, pc}


SKILL_LIST_ITEM:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl GetSkillTable
        mul r5, r0
        add r5, r1
@@@@@@@@
        add r5, #16

        mov r0, r4
        mov r1, r5
        bl CheckItemList
        pop {r4, r5, pc}

CheckItemList:
        push {r4, r5, lr}
        mov r4, r0
        add r4, #30
        mov r3, r1
        mov r5, #0
    forItem:
        cmp r5, #10
        bgt endItem
            ldrb r0, [r4, r5]
            cmp r0, #0
            beq endItem
            mov r1, r0
            ldr r2, [r3]
            bl Listfunc
            cmp r0, #1
            beq endItem
        add r5, #2
        b forItem
    endItem:
        pop {r4, r5, pc}

IsSpecialSkill:
        push {lr}
        bl GetWeapon
        cmp r1, #74
        bne trueSpecial @装備取得不可

        bl CheckOccult
        cmp r0, #0
        beq trueSpecial

        mov r0, r4
        mov r1, #0
        bl JUDGE_OCCULT
        .short 0xE000
    trueSpecial:
        mov r0, #1
        pop {pc}

CheckOccult:
        push {r5, lr}
        bl GetCombatTable

        mul r5, r0
        add r5, r1
        ldrb r0, [r5, #6]

        mov r1, #0b1100
        tst r0, r1
        bne trueOccult     @奥義
        mov r0, #0
        .short 0xE000
    trueOccult:
        mov r0, #1
        pop {r5, pc}

GetWeapon:
        ldr r1, =0x0203a4e8
        cmp r4, r1
        beq canWeapon
        ldr r1, =0x0203a568
        cmp r4, r1
        beq canWeapon
        mov r0, #0
        bx lr
    canWeapon:
        mov r1, #74
        ldrh r0, [r4, r1]
        bx lr

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

GetSkillTable:
    ldr r1, SKL_TBL_ADDR
    ldrb r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr
GetCombatTable:
    ldr r1, COMBAT_TBL_ADDR
    ldrb r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr

SKL_TBL_ADDR = ADDR+0
COMBAT_TBL_ADDR = ADDR+4
JUDGE_OCCULT:
    ldr r3, ADDR+8
    mov pc, r3

.align
.ltorg
ADDR:
