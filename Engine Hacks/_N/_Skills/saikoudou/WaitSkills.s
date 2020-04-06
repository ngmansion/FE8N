.thumb

    push {r4, lr}
    mov r4, r0
    bl AlertStance
    bl DefensiveStance
    bl Catnap
    pop {r4, pc}


AlertStance:
        push {lr}
        mov r0, #48
        ldrb r0, [r4, r0]
        cmp r0, #0
        bne endAlertStance

        mov	r0, r4
        mov r1, #0
        bl HAS_ALERT_STANCE
        cmp r0, #0
        beq endAlertStance

        mov r1, #0x18
        mov r0, #48
        strb r1, [r4, r0]

    endAlertStance:
        pop {pc}

DefensiveStance:
        push {lr}
        mov r0, #48
        ldrb r0, [r4, r0]
        cmp r0, #0
        bne endDefensiveStance

        mov	r0, r4
        mov r1, #0
        bl HAS_DEFENSIVE_STANCE
        cmp r0, #0
        beq endDefensiveStance

        mov r1, #0x16
        mov r0, #48
        strb r1, [r4, r0]

    endDefensiveStance:
        pop {pc}

Catnap:
        push {lr}

        mov	r0, r4
        mov r1, #0
        bl HAS_CATNAP
        cmp r0, #0
        beq endCatnap

        ldrb r0, [r4, #19]
        ldrb r1, [r4, #18]
        add r0, #5
        cmp r0, r1
        blt jumpCatnap
        mov r0, r1
    jumpCatnap:
        strb r0, [r4, #19]

        mov r0, #0x89
        mov r1, #0xB8
            ldr r2, =0x08014B50 @音
            mov lr, r2
            .short 0xF800

    endCatnap:
        pop {pc}


HAS_ALERT_STANCE:
    ldr r2, addr+0
    mov pc, r2
HAS_DEFENSIVE_STANCE:
    ldr r2, addr+4
    mov pc, r2
HAS_CATNAP:
    ldr r2, addr+8
    mov pc, r2

.align
.ltorg
addr:
