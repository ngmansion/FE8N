.thumb
RETURN_ADDR  = (0x0808e80e)
RETURN_ADDR2 = (0x0808e814) @何もしない

WAR_OFFSET = (67)

    mov r0, #63     @0x3F
    and r0, r6
    cmp r0, #0
    bne dont_need

    sub sp, #80 @装備あたりまで
    mov r0, sp
    bl SetPow
    add sp, #80

    bl GetFirstNum
    cmp r0, #99
    .short 0xdd00
    mov r0, #255
    bl $00003868

    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3251
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3152
    .short 0x7008

    bl GetSecondNum
    cmp r0, #99
    .short 0xdd00
    mov r0, #255
    bl $00003868
    ldr r1, =0x02028e44
    .short 0x7988
    .short 0x3830
    .short 0x1c22
    .short 0x3253
    .short 0x7010
    .short 0x79c8
    .short 0x3830
    .short 0x1c21
    .short 0x3154
    .short 0x7008

    bl Draw_Word
    ldr r0, =RETURN_ADDR
    mov pc, r0
dont_need:
    ldr r0, =RETURN_ADDR2
    mov pc, r0


Draw_Word:
        push {lr}
        ldr r1, [r4, #64]
        mov r2, #0
        ldr r3, =0x2120
        strh    r3, [r1, #0]
        add r3, #1
        strh    r3, [r1, #2]
        strh    r2, [r1, #4]
        strh    r2, [r1, #6]
        add r3, #29
        strh    r3, [r1, #8]
        strh    r2, [r1, #10]
        strh    r2, [r1, #12]
        pop {pc}

GetFirstNum:
        push {lr}
        mov r0, r5
        bl $00018e64

        pop {pc}


GetSecondNum:
        push {lr}
        mov r0, r5
        bl $00018ea4
        pop {pc}

SetPow:
    bx lr

$00003868:
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


.align
.ltorg
ADDR:
