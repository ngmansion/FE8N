.thumb

@    0808e850
        ldr r0, =0x82e0
        mov r8, r0

@        add r6, #8

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #4]
        cmp r3, #0xF0
        beq dontAtk10

        mov     r0, r5
        add     r0, #17             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
    dontAtk10:

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #5]

        mov     r0, r5
        add     r0, #24             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
@@@@0008e850
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #6]
        cmp r3, #0xF0
        beq dontNum10

        mov     r0, r5
        add     r0, #41             @横位置H, P, 17, 24, ／, 41, 48
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        add     r3, r8
        bl      $00002b08
    dontNum10:

        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #7]


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

.align
.ltorg
ADDR:

