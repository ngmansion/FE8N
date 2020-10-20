.thumb
@ r0 = UNIT
@ r1 = skillID
@
        push {r6, lr}
        mov r2, r8
        push {r2}
        mov r8, r0
        mov r6, r1

        bl JudgeCombatSkill

        pop {r2}
        mov r8, r2
        pop {r6, pc}

JudgeCombatSkill:
        push {r6, lr}
        ldr r2, COMBAT_TBL
        ldr r0, COMBAT_TBL_SIZE
        mul r6, r0
        add r6, r2
        ldrb r2, [r6, #6]
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

        bl JudgeOracle      @4
        cmp r0, #0
        beq falseCombat

        mov r0, #1
        .short 0xE000
    falseCombat:
        mov r0, #0
        pop {r6, pc}

JudgeSpecialWeapon:
        push {lr}

        mov r0, r8
        ldr r0, [r0, #76]
        mov r1, #0x80
        tst r0, r1
        bne falseSpecial    @反撃不可武器は無効

        mov r0, r8
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

JudgeOracle:
        push {r4, lr}
        mov r4, r8  @必要

        ldrb r0, [r6, #6]
        mov r1, #4
        tst r0, r1
        beq trueOracle

        mov r0, r4
        bl OracleFunc
        .short 0xE000
    trueOracle:
        mov r0, #1
        pop {r4, pc}

JudgeRange:
        push {lr}

        ldrb r0, [r6, #6]
        mov r1, #2
        tst r0, r1
        beq trueRange

        mov r0, r8
        add r0, #74
        ldrh r0, [r0]
        bl GetWeaponRange
        mov r1, #0b00001111
        and r0, r1
        cmp r0, #1
        beq trueRange
        mov r0, #0
        .short 0xE000
trueRange:
        mov r0, #1
        pop {pc}

MatchWeaponType:
        push {r6, lr}

        ldrb r6, [r6, #5]
        cmp r6, #0xFF
        beq trueType

        mov r0, r8
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

        mov r0, r8
        add r0, #72
        ldrh r0, [r0]
        lsr r0, #8

        ldrb r1, [r6, #4]

        cmp r0, r1
        bge trueCost
        mov r0, #0
        .short 0xE000
trueCost:
        mov r0, #1
        pop {pc}


GetWeaponSetting:
    ldr r1, =0x08017490
    mov pc, r1

GetWeaponAbility:
    ldr r1, =0x080174cc
    mov pc, r1

GetWeaponType:
    ldr r3, =0x080172f0
    mov pc, r3

GetWeaponRange:
    ldr r3, =0x08017448     @武器の射程
    mov pc, r3

COMBAT_TBL = (ADDR+0)
COMBAT_TBL_SIZE = (ADDR+4)

OracleFunc:
    ldr r3, ADDR+8
    add r3, #26
    mov pc, r3

.align
.ltorg
ADDR:
