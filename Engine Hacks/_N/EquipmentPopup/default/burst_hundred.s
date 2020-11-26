.thumb

@    0808e850
        ldr r0, =0x82e0
        mov r8, r0

        bl GET_SKILL_ICON_ADDR_TO_R3
        mov r2, #1
        neg r2, r2
    loopIcon:
        add r2, #1
        ldrb r0, [r3]
        add r3, #1
        cmp r0, #0
        bne loopIcon
        mov r3, r2

        mov     r0, r5
        add     r0, #0x07
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
        b end

        mov r3, #81
        ldrb    r3, [r4, r3]
        cmp r3, #0xF0
        beq dontAtk10

        mov     r0, r5
        add     r0, #17             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
    dontAtk10:

        mov r3, #82
        ldrb    r3, [r4, r3]

        mov     r0, r5
        add     r0, #24             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
@@@@0008e850
        mov r3, #83
        ldrb    r3, [r4, r3]
        cmp r3, #0xF0
        beq dontNum10

        mov     r0, r5
        add     r0, #41             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
    dontNum10:

        mov r3, #84
        ldrb    r3, [r4, r3]


        mov     r0, r5
        add     r0, #48             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
        b end
@0808e884

@@@@@@@@命中
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #12]
        cmp r3, #0xF0
        beq dontNeed

        mov     r0, r5
        add     r0, #17             @横位置H, P, 17, 24, ／, 41, 48
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08

    dontNeed:
@@@@@@@@必殺
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #13]
        cmp r3, #0xF0
        bne hundredCrit

        bl      GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #22]
        cmp     r3, #240
        beq     underCrit
        mov     r0, r5
        add     r0, #41             @横位置H, P, 17, 24, ／, 41, 48
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    underCrit:
        mov     r0, r5
        add     r0, #48             @横位置H, P, 17, 24, ／, 41, 48
        bl      GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #23]
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
        b endCrit

    hundredCrit:
        add     r3, r8

        mov     r1, r6
        ldr     r2, =0x085b8cdc
        mov     r0, r5
        add     r0, #41             @横位置H, P, 17, 24, ／, 41, 48
        bl      $00002b08

        bl      GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #22]
        add     r3, r8

        mov     r1, r6
        ldr     r2, =0x085b8cdc
        mov     r0, r5
        add     r0, #48             @横位置H, P, 17, 24, ／, 41, 48
        bl      $00002b08


        bl      GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #23]
        add     r3, r8

        mov     r1, r6
        ldr     r2, =0x085b8cdc
        mov     r0, r5
        add     r0, #55             @横位置H, P, 17, 24, ／, 41, 48
        bl      $00002b08
    endCrit:
    end:
        ldr r0, =0x0808e8b4
        mov pc, r0

$00002b08:
    ldr r7, =0x08002b08
    mov pc, r7


GET_EX_NUM_MEM_TO_R3:
    ldr r3, ADDR
    bx lr
GET_SKILL_ICON_ADDR_TO_R3:
    ldr r3, ADDR+4
    bx lr
.align
.ltorg
ADDR:

