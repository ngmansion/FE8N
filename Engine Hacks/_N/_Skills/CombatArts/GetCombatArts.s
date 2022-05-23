.thumb
TRUE = 1
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
b HAS_ALL_RANGE
nop
b HAS_SHORT_RANGE
nop
b HAS_LONG_BOW
nop
b HAS_JAVELIN
nop
HAS_ALL_RANGE:
    push {lr}
    bl GET_COMBAT_ARTS_TYPE
    mov r1, r0
    mov r0, #TRUE
    cmp r1, #0x01
    .short 0xD000
    mov r0, #0
    pop {pc}
HAS_SHORT_RANGE:
    push {lr}
    bl GET_COMBAT_ARTS_TYPE
    mov r1, r0
    mov r0, #TRUE
    cmp r1, #0x02
    .short 0xD000
    mov r0, #0
    pop {pc}
HAS_LONG_BOW:
    push {lr}
    bl GET_COMBAT_ARTS_TYPE
    mov r1, r0
    mov r0, #TRUE
    cmp r1, #0x10
    .short 0xD000
    mov r0, #0
    pop {pc}
HAS_JAVELIN:
    push {lr}
    bl GET_COMBAT_ARTS_TYPE
    mov r1, r0
    mov r0, #TRUE
    cmp r1, #0x20
    .short 0xD000
    mov r0, #0
    pop {pc}

GET_COMBAT_ARTS_TYPE:
        ldr r1, COMBAT_ART_LIST_SIZE
        mul r0, r1
        ldr r1, combat_art_table
        add r0, r1
        mov r1, #6
        ldrb r0, [r0, r1]

        mov r1, #0b1000
        and r1, r0
        bne trueOracle
        mov r1, #0b0100
        and r1, r0
        bne trueOracle

        mov r1, #0x02
        and r1, r0
        bne trueCloseRange

        mov r1, #0x01
        and r1, r0
        bne trueAllRange
        b endCombat

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
