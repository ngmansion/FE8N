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

        bl IsShortRangeCombat

        pop {r3}
        cmp r0, #0
        beq skip

        mov r3, #1  @強制的に射程0x11
        mov r4, #1
    skip:
        pop {pc}

IsShortRangeCombat:
        push {lr}

        bl GetSelectingCombatArt
        bl GET_COMBAT_ARTS_TYPE
        cmp r0, #2
        beq trueRange
    falseRange:
        mov r0, #0
        .short 0xE000
    trueRange:
        mov r0, #1
        pop {pc}


GetSelectingCombatArt:
        ldr r0, ARROW_CONFIG
        ldrb r0, [r0]
        cmp r0, #1
        ble zeroSelect
        sub r0, #2
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
.align
addr:

