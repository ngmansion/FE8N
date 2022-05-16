.thumb
@
@コマンド選択可能判定と、武器可不可判定兼用
@

@ 08024998
@ 08022c88

    ldr r0, [r5, #0]
    mov r1, r4 
    bl  USE_SUB_ROUTINE
    lsl r0, r0, #24
    cmp r0, #0
    beq false

    bl combat_arts

    ldr r0, TRUE_RETURN
    mov pc, r0
false:
    ldr r0, FALSE_RETURN
    mov pc, r0

$000164f8:
    ldr r2, =0x080164f8
    mov pc, r2


LONG_BOW_ID = 0x34
BOW_ID = 0x2D
JAVELIN_ID = 0x1C

skill_unit      .req r5
weapon_id       .req r4

combat_arts:
        push {r5, lr}
        ldr r5, [r5]
        mov r0, weapon_id
        bl $00017448
        mov r1, #0xF
        and r0, r1
        cmp r0, #0x01
        beq javelin_check
        cmp r0, #0x02
        beq long_check
        b end_combat
    long_check:
        mov r0, skill_unit
        mov r1, weapon_id
        mov r2, #0xB6
        bl CAN_USE_COMBAT_ARTS
        cmp r0, #1
        beq long_arts

        mov r0, skill_unit
        mov r1, weapon_id
        mov r2, #0x7F
        bl CAN_USE_COMBAT_ARTS
        cmp r0, #1
        beq long_arts
        b end_combat

    javelin_check:
        mov r0, skill_unit
        mov r1, weapon_id
        mov r2, #0xCD
        bl CAN_USE_COMBAT_ARTS
        cmp r0, #1
        beq javelin_arts
        mov r0, skill_unit
        mov r1, weapon_id
        mov r2, #0xCE
        bl CAN_USE_COMBAT_ARTS
        cmp r0, #1
        beq javelin_arts
        b end_combat
    long_arts:
        mov weapon_id, #LONG_BOW_ID
        b end_combat
    javelin_arts:
        ldr r5, [r5]
        mov r0, weapon_id
        bl $00017448
        cmp r0, #0x11
        beq javelin_range       @射程1なら+1で手槍レンジ
        mov weapon_id, #BOW_ID
        .short 0xE000
    javelin_range:
        mov weapon_id, #JAVELIN_ID
        b end_combat
end_combat:
        pop {r5, pc}

$00017448:
    ldr r1, =0x08017448
    mov pc, r1

CAN_USE_COMBAT_ARTS:
    ldr r3, (ADDR+0)
    mov pc, r3

FALSE_RETURN = ADDR+4 @ (0x080249a6)
TRUE_RETURN = ADDR+8  @ (0x080249b6)

USE_SUB_ROUTINE:
    ldr r3, (ADDR+12) @ = can_unit_use_weapon
    mov pc, r3

.align
.ltorg
ADDR:

