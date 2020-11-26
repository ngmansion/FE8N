.thumb
b GET_COMBAT_ATK
nop
b GET_COMBAT_HIT
nop
b GET_COMBAT_CRT
nop
b GET_COMBAT_AVO
nop
b GET_COMBAT_COST
nop
b GET_COMBAT_SPECIES
nop
b GET_COMBAT_ARTS_TYPE
nop

GET_COMBAT_ARTS_TYPE:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #6
        ldrb r0, [r0, r1]

        mov r1, #0x04
        and r1, r0
        bne trueOracle

        mov r1, #0x02
        and r1, r0
        bne trueCloseRange

        mov r1, #0x01
        and r1, r0
        bne trueAllRange
        b falseCombat

    trueOracle:
        mov r0, #3
        b endCombat
    trueCloseRange:
        mov r0, #2
        b endCombat
    trueAllRange:
        mov r0, #1
        b endCombat
    falseCombat:
        mov r0, #0
    endCombat:
        bx lr

GET_COMBAT_ATK:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #0
        ldsb r0, [r0, r1]
        bx lr

GET_COMBAT_HIT:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #1
        ldsb r0, [r0, r1]
        bx lr

GET_COMBAT_CRT:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #2
        ldsb r0, [r0, r1]
        bx lr
GET_COMBAT_AVO:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #3
        ldsb r0, [r0, r1]
        bx lr
GET_COMBAT_COST:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #4
        ldrb r0, [r0, r1]
        bx lr
GET_COMBAT_SPECIES:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #5
        ldrb r0, [r0, r1]
        bx lr

COMBAT_ART_LIST_SIZE = ADDR+0
combat_art_table = ADDR+4

.align
.ltorg
ADDR:
