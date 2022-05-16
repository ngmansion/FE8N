.thumb

SOUND_ID = (97)

ATK = (0x0203a4e8)
DEF = (0x0203a568)

@0002519c

        mov r3, r0
        lsl r3, r3, #16
        lsr r3, r3, #16
        bl main

        mov r0, r5
        ldr r1, =0x080251a4
        mov pc, r1

main:
        push {lr}

        bl NeedsThisFunction
        cmp r0, #0
        beq skip
        
        push {r3}

        bl get_force_range

        pop {r3}
        cmp r0, #0
        beq skip

        mov r3, r1  @ distant
        mov r4, r0  @ close
    skip:
        pop {pc}

get_force_range:
@
@r0=0なら、指定なし
@それ以外なら、r0とr1に有効値設定
@
        push {r4, lr}

        bl GetSelectingCombatArt
        cmp r0, #0
        beq falseRange
        mov r4, r0

        bl HAS_SHORT_RANGE
        cmp r0, #1
        beq force_short

        mov r0, r4
        bl HAS_LONG_BOW
        cmp r0, #1
        beq force_long

        mov r0, r4
        bl HAS_JAVELIN
        cmp r0, #1
        beq force_jave

        b falseRange

    force_short:
        mov r0, #1
        mov r1, #1
        b endRange
    force_long:
        mov r0, #2
        mov r1, #3
        b endRange
    force_jave:
        mov r0, #2
        mov r1, #2
        b endRange

    falseRange:
        mov r0, #0
    endRange:
        pop {r4, pc}


GetSelectingCombatArt:
        ldr r0, ARROW_CONFIG
        ldrb r0, [r0]
        sub r0, #1
        blt zeroSelect
        ldr r1, WAR_CONFIG
        ldrb r0, [r1, r0]
        .short 0xE000
    zeroSelect:
        mov r0, #0
        bx lr


NeedsThisFunction:
        ldr r0, =0x080251c0
        ldr r0, [r0]
        ldr r0, [r0]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        cmp r0, r1
        bne dontNeed
        ldrb r0, [r0, #0xB]
        mov r1, #0xC0
        tst r0, r1
        bne dontNeed
        mov r0, #1
        .short 0xE000
    dontNeed:
        mov r0, #0
        bx lr


.align
.ltorg

WAR_CONFIG = addr+0
ARROW_CONFIG = addr+4

SET_COMBAT_ART:
    ldr r2, addr+8
    mov pc, r2
TURN_OFF_TEMP_SKILL_FLAG:
    ldr r2, addr+12
    mov pc, r2
GET_COMBAT_ART:
    ldr r1, (addr+16)
    mov pc, r1
GET_COMBAT_ARTS_TYPE:
    ldr r1, (addr+20)
    mov pc, r1
HAS_SHORT_RANGE:
    ldr r1, addr+24
    mov pc, r1
HAS_LONG_BOW:
    ldr r1, addr+28
    mov pc, r1
HAS_JAVELIN:
    ldr r1, addr+32
    mov pc, r1
.align
addr:

