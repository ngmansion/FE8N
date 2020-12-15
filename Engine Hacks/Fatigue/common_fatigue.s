.thumb

VALID_BIT_UT    = (0b00000111)
VALID_BIT_TP    = (0b00000011)

b GET_FATIGUE_NUM
nop
b SET_FATIGUE_NUM
nop
b ADD_FATIGUE_NUM
nop
GET_FATIGUE_NUM:
        push {r4, lr}
        mov r4, r0
        bl SetBaseAddr
        cmp r4, #0
        beq falseGet

        mov r0, #59
        ldrb r0, [r4, r0]
        mov r2, #VALID_BIT_UT
        and r0, r2
        lsl r0, #2

        mov r1, #71
        ldrb r1, [r4, r1]

        mov r2, #VALID_BIT_TP
        and r1, r2

        orr r0, r1
        .short 0xE000
    falseGet:
        mov r0, #0
        pop {r4, pc}

SET_FATIGUE_NUM:
        push {r4, r5, lr}
        mov r4, r0
        mov r5, r1
        bl SetBaseAddr
        cmp r4, #0
        beq endSet

        ldr r0, FATIGUE_MAX
        cmp r5, r0
        ble underFatigue
        mov r5, r0
    underFatigue:
@@@@@@@@UT
        mov r1, #59
        ldrb r0, [r4, r1]
        mov r2, #VALID_BIT_UT
        mvn r2, r2
        and r0, r2

        mov r2, r5
        lsr r2, r2, #2
        orr r0, r2

        strb r0, [r4, r1]
@@@@@@@@TP
        mov r1, #71
        ldrb r0, [r4, r1]
        mov r2, #VALID_BIT_TP
        mvn r2, r2
        and r0, r2

        mov r2, #VALID_BIT_TP
        and r2, r5

        orr r0, r2
        strb r0, [r4, r1]
@@@@@@@@
    endSet:
        pop {r4, r5, pc}


ADD_FATIGUE_NUM:
        push {r4, lr}
        mov r4, r0
        bl GET_FATIGUE_NUM
        add r1, r0, #1
        mov r0, r4
        bl SET_FATIGUE_NUM
        pop {r4, pc}

SetBaseAddr:
    push {lr}
    ldrb r0, [r4, #0xB]
    cmp r0, #51
    bgt endAddr

    bl $00019108
    mov r4, r0
    .short 0xE000
endAddr:
    mov r4, #0
    pop {pc}

$00019108:
    ldr r1, =0x08019108
    mov pc, r1

FATIGUE_MAX=addr+0

.align
.ltorg
addr:

