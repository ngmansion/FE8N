.thumb
RETURN_ADDR  = (0x0808e80e)
RETURN_ADDR2 = (0x0808e814) @何もしない

@0808e79c
    mov r0, #63     @0x3F
    and r0, r6
    cmp r0, #0
    bne dont_need

    bl GetFirstNum
    bl Hundred
    mov r7, r1          @退避
    bl NUMBER

    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3251       @
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3152       @
    .short 0x7008

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #12]

@@@@
    bl GetSecondNum
    bl Hundred
    mov r7, r1          @退避
    bl NUMBER
    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3253       @
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3154       @
    .short 0x7008

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #13]

    bl SetThirdNum
    bl SetFourthNum

    bl Draw_Word
    ldr r0, =RETURN_ADDR
    mov pc, r0
dont_need:
    ldr r0, =RETURN_ADDR2
    mov pc, r0

GetHundredNum:
    push {lr}
    cmp r0, #0
    beq falseHundred
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb    r0, [r1, #7]
    sub r0, #48
    .short 0xE000
falseHundred:
    mov r0, #0xF0
    bl GET_EX_NUM_MEM_TO_R3
    pop {pc}

Hundred:
        mov r1, #0
        ldr r2, =0xFFFFFFFF
        cmp r0, r2
        beq underHundred

        mov r2, r0
    loopHundred:
        cmp r2, #99
        ble underHundred
        sub r2, #100
        add r1, #1
        b loopHundred
    underHundred:
        bx lr

Draw_Word:
    drawHit:
        ldr r1, [r4, #64]
        mov r2, #0
        ldr r3, =0x2163
        strh    r3, [r1, #0]
        strh    r2, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        ldr r3, =0x2164
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]
    drawAvo:
        ldr r1, [r4, #64]
        add r1, #0x40
        mov r2, #0
        ldr r3, =0x2166
        strh    r3, [r1, #0]
        strh    r2, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        ldr r3, =0x2167
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]  
    endWord:
        bx lr

GetFirstNum:
        ldr r1, =0x0203a568
        mov r0, #74
        ldrh r0, [r1, r0]
        cmp r0, #0
        beq falseFirst
        mov r0, #96
        ldrh r0, [r1, r0]
        .short 0xE000
    falseFirst:
        ldr r0, =0xFFFFFFFF
        bx lr

GetSecondNum:
        ldr r1, =0x0203a568
        mov r0, #74
        ldrh r0, [r1, r0]
        cmp r0, #0
        beq falseSecond
        mov r0, #102
        ldrh r0, [r1, r0]
        .short 0xE000
    falseSecond:
        ldr r0, =0xFFFFFFFF
        bx lr

GetThirdNum:
        ldr r1, =0x0203a568
        mov r0, #98
        ldrh r0, [r1, r0]
        bx lr

GetFourthNum:
        ldr r1, =0x0203a568
        mov r0, #104
        ldrh r0, [r1, r0]
        bx lr


SetThirdNum:
    push {lr}
    bl GetThirdNum
    bl Hundred
    mov r7, r1          @退避
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb  r0, [r1, #6]
    sub   r0, #48
    mov   r2, r4
    add   r2, #81
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #15]

    ldrb  r0, [r1, #7]
    sub   r0, #48
    mov   r1, r4
    add   r1, #82
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #14]

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #16]
    pop {pc}

SetFourthNum:
    push {lr}
    bl GetFourthNum
@    bl Hundred
    mov r7, r1          @退避
    bl NUMBER
    ldr r1, =0x02028e44
    ldrb  r0, [r1, #6]
    sub   r0, #48
    mov   r2, r4
    add   r2, #81
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #18]

    ldrb  r0, [r1, #7]
    sub   r0, #48
    mov   r1, r4
    add   r1, #82
    bl GET_EX_NUM_MEM_TO_R3
    strb  r0, [r3, #17]

    mov r0, r7
    bl GetHundredNum
    strb   r0, [r3, #19]
    pop {pc}

NUMBER:
    ldr r1, =0x08003868
    mov pc, r1

$080168d0:
    ldr r1, =0x080168d0
    mov pc, r1

$00018e64:
    ldr r1, =0x08018e64
    mov pc, r1
$00018ea4:
    ldr r1, =0x08018ea4
    mov pc, r1

GET_EX_NUM_MEM_TO_R3:
    ldr r3, ADDR
    bx lr
GET_FLASH_CONFIG:
    ldr r0, ADDR+4
    bx lr

.align
.ltorg
ADDR:
