.thumb

@0808e884

@@@@@@@@命中
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #12]
        cmp r3, #0xF0
        beq dontNeed

        mov     r0, r5
        add     r0, #10
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

        mov     r1, r4
        add     r1, #83
        ldrb    r0, [r1, #0]
        cmp     r0, #240
        beq     underCrit
        mov     r0, r5
        add     r0, #41
        ldrb    r3, [r1, #0]
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    underCrit:
        mov     r0, r5
        add     r0, #48
        mov     r1, r4
        add     r1, #84
        ldrb    r3, [r1, #0]
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
        add     r0, #41
        bl      $00002b08

        mov     r1, r4
        add     r1, #83
        ldrb    r3, [r1, #0]
        add     r3, r8

        mov     r1, r6
        ldr     r2, =0x085b8cdc
        mov     r0, r5
        add     r0, #48
        bl      $00002b08


        mov     r1, r4
        add     r1, #84
        ldrb    r3, [r1, #0]
        add     r3, r8

        mov     r1, r6
        ldr     r2, =0x085b8cdc
        mov     r0, r5
        add     r0, #55
        bl      $00002b08
    endCrit:
@@@@@@@@2段目
        add r6, #8
        add r6, #1
@@@@@@@@回避
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #16]
        cmp r3, #0xF0
        beq dontAvo100

        mov     r0, r5
        add     r0, #10
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    dontAvo100:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #15]
        cmp r3, #0xF0
        beq dontAvo10

        mov     r0, r5
        add     r0, #17
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    dontAvo10:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #14]
        mov     r0, r5
        add     r0, #24
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
@@@@@@@@必避
        bl GET_EX_NUM_MEM_TO_R3
@        ldrb    r3, [r3, #19]      @100超えないでしょ・・・
        ldrb    r3, [r3, #18]
        cmp r3, #0xF0
        beq dontDdg10

        mov     r0, r5
        add     r0, #41
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08
    dontDdg10:
        bl GET_EX_NUM_MEM_TO_R3
        ldrb    r3, [r3, #17]
        mov     r0, r5
        add     r0, #48
        add     r3, r8
        mov     r1, r6
        ldr     r2, =0x085b8cdc
        bl      $00002b08

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

