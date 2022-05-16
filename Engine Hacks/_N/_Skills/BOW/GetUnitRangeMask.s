.thumb
RETURN_ADDR = 0x08016fdc
@ 00016f9c
@ 武器選択時にのみ通る処理


@    lsl r1, r1, #1
    add r0, #30
    add r0, r0, r1
    ldrh r0, [r0, #0]
    bl main
    bl $00016e7c
    ldr r3, =RETURN_ADDR
    mov pc, r3
$00016e7c:
    ldr r3, =0x08016e7c
    mov pc, r3

INVALID_COMBAT_ID = 0x00

LONG_BOW_ID = 0x34
JAVELIN_ID = 0x2D

skill_unit      .req r6
weapon_object   .req r4

main:
@
@
@
        push {r4, r5, lr}
        mov weapon_object, r0

        ldr r1, ARROW_CONFIG
        ldrb r0, [r1]
        cmp r0, #0
        beq end_combat
        sub r0, #1
        ldr r1, WAR_CONFIG
        ldrb r0, [r0, r1]
        cmp r0, #INVALID_COMBAT_ID
        beq end_combat

        mov r0, weapon_object
        bl $00017448

        mov r1, #0xF
        and r0, r1
        cmp r0, #0x01
        beq javelin_check
        cmp r0, #0x02
        beq long_check
        b end_combat
    long_check:

        ldr r1, ARROW_CONFIG
        ldrb r0, [r1]
        sub r0, #1
        ldr r1, WAR_CONFIG
        ldrb r0, [r0, r1]
        cmp r0, #0xB6
        beq long_arts
        cmp r0, #0x7F
        beq long_arts
        b end_combat

    javelin_check:
        ldr r1, ARROW_CONFIG
        ldrb r0, [r1]
        sub r0, #1
        ldr r1, WAR_CONFIG
        ldrb r0, [r0, r1]
        cmp r0, #0xCD
        beq javelin_arts
        cmp r0, #0xCE
        beq javelin_arts
        b end_combat
    long_arts:
        ldr r0, =0xFF00
        and weapon_object, r0
        mov r0, #LONG_BOW_ID
        orr weapon_object, r0
        b end_combat
    javelin_arts:
        ldr r0, =0xFF00
        and weapon_object, r0
        mov r0, #JAVELIN_ID
        orr weapon_object, r0
        b end_combat
    end_combat:
        mov r0, weapon_object
        pop {r4, r5, pc}

$00017448:
    ldr r3, =0x08017448
    mov pc, r3

ARROW_CONFIG = (addr+0)
WAR_CONFIG = (addr+4)

.align
.ltorg
addr:

