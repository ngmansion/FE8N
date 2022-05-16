.thumb

skill_unit   .req r4
item_id           .req r5
combat_id        .req r6
combat_table        .req r6

@
@r0 = skill_unit
@r1 = item_id
@r2 = combat_id
@
    push {r4, r5, r6, lr}
    mov skill_unit, r0
    mov item_id, r1
    mov combat_id, r2

    ldrb r0, [r4, #11]
    ldr r2, =0x03004df0
    ldr r2, [r2]
    ldrb r2, [r2, #11]
    cmp r0, r2
    bne false

    bl main
    pop {r4, r5, r6, pc}
false:
    mov r0, #0
    pop {r4, r5, r6, pc}

main:
        push {lr}

        mov r0, r4
        mov r1, combat_id
        bl judgeSkill
        cmp r0, #0
        beq return

        bl JudgeCombatSkill

    return:
        pop {pc}

JudgeCombatSkill:
        push {lr}
        bl GetCombatTable
        mul combat_id, r0
        add combat_id, r1
        bl MatchWeaponType
        cmp r0, #0
        beq falseJudge

        bl JudgeCost
    falseJudge:
        pop {pc}

MatchWeaponType:
        push {r7, lr}

        ldrb r7, [combat_table, #5]
        cmp r7, #0xFF
        beq trueType

        mov r0, item_id
        bl GetWeaponType
        cmp r0, r7
        beq trueType
        mov r0, #0
        .short 0xE000
    trueType:
        mov r0, #1
        pop {r7, pc}

JudgeCost:
        push {lr}

        mov r0, item_id
        lsr r0, #8

        ldrb r1, [combat_table, #4]

        cmp r0, r1
        bge trueCost
        mov r0, #0
        .short 0xE000
    trueCost:
        mov r0, #1
        pop {pc}

GetCombatTable:
    ldr r1, COMBAT_TBL_ADDR
    ldr r0, [r1, #4]
    ldr r1, [r1, #0]
    bx lr

GetWeaponType:
    ldr r3, =0x080172f0
    mov pc, r3

judgeSkill:
    ldr r3, ADDR+0
    mov pc, r3
COMBAT_TBL_ADDR = ADDR+4

.align
.ltorg
ADDR:

