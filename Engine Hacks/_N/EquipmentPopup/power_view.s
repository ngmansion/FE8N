.thumb
@org   0808e75c

    push    {r4, r5, r6, r7, lr}
    mov r7, r8
    push    {r7}
    mov r4, r0
    mov r5, r1
    mov r0, #68
    ldsh    r6, [r0, r4]
    
    mov r0, #63
    and r0, r6
    cmp r0, #0
    bne check
    mov r0, #64
    and r0, r6
    cmp r0, #0
@   beq start
@   ldr r0, [r4, #64]
@   ldr r1, =0x0808e688
@   mov lr, r1
@   mov r1, r5
@   @dcw    0xF800
@   b   dont
    
    
start:
    bl SetNumber

    ldrb    r0, [r5, #8]    @レベル
    bl  NUMBER
    ldr r1, =0x02028e44
    ldrb    r0, [r1, #6]
    sub r0, #48
    mov r2, r4
    add r2, #81
    strb    r0, [r2, #0]
    ldrb    r0, [r1, #7]
    sub r0, #48
    mov r1, r4
    add r1, #82
    strb    r0, [r1, #0]

    ldrb    r0, [r5, #9]    @Exp
    bl  NUMBER
    ldr r1, =0x02028e44
    
    ldrb    r0, [r1, #6]
    sub r0, #48
    mov r2, r4
    add r2, #83
    strb    r0, [r2, #0]

    ldrb    r0, [r1, #7]
    sub r0, #48
    mov r1, r4
    add r1, #84
    strb    r0, [r1, #0]
@文字
    ldr r1, [r4, #64]
    mov r2, #0
    ldr r3, =0x2160
    strh    r3, [r1, #0]
    add r3, #1
    strh    r3, [r1, #2]
    strh    r2, [r1, #4]
    strh    r2, [r1, #6]
    add r3, #1
    strh    r3, [r1, #8]
    strh    r2, [r1, #10]
    strh    r2, [r1, #12]

    ldr r1, [r4, #64]
    add r1, #0x40
    bl $0008e660    @HP文字

dont:
    mov r0, #1
    ldr r1, =0x08001efc
    mov lr, r1
    .short 0xF800
check:
    mov r0, r4
    add r0, #85
    ldrb    r0, [r0, #0]
    lsl r0, r0, #24
    asr r0, r0, #24
    bne end
    bl DrawNumber
    ldr r0, =0x0808e838     @合流
    mov pc, r0
end:
    ldr r0, =0x0808e8b4     @終了
    mov pc, r0


ExtraNumber:
        push {lr}
        mov r0, r4
        add r0, #85
        ldrb    r0, [r0, #0]
        lsl r0, r0, #24
        asr r0, r0, #24
        bne endExtra
        bl SetNumber
        bl DrawNumber
    endExtra:
        pop {pc}

SetNumber:
        push {lr}
        ldrb    r0, [r5, #19]    @ヒットポイント
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44
        ldrb    r0, [r1, #6]
        sub r0, #48
        ldr r2, EX_NUM_MEM
        strb    r0, [r2, #0]
        
        ldrb    r0, [r1, #7]
        sub r0, #48
        ldr r2, EX_NUM_MEM
        strb    r0, [r2, #1]

        mov r0, r5
        bl $00018ea4        @最大HP
        cmp r0, #99
        .short 0xDD00
        mov r0, #255
        bl  NUMBER
        ldr r1, =0x02028e44

        ldrb    r0, [r1, #6]
        sub r0, #48
        ldr r2, EX_NUM_MEM
        strb    r0, [r2, #2]

        ldrb    r0, [r1, #7]
        sub r0, #48
        ldr r2, EX_NUM_MEM
        strb    r0, [r2, #3]
        pop {pc}

DrawNumber:
        push {r5, lr}
        mov r0, r4
        add r0, #70
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r5, r0, #3
        mov r7, r5
        add r7, #17
        mov r0, r4
        add r0, #72
        mov r1, #0
        ldsh r0, [r0, r1]
        lsl r6, r0, #3
        add r6, #8          @1段下にずらす

        ldr r1, =0x82e0
        mov r8, r1

        ldr r3, EX_NUM_MEM
        ldrb    r3, [r3, #0]
        cmp r3, #240
        beq $0008e86a
        add r3, r8
        mov r0, r7
        mov r1, r6
        ldr r2, =0x085b8cdc
        bl $00002b08

    $0008e86a:
        mov r0, r5
        add r0, #24
        ldr r3, EX_NUM_MEM
        ldrb    r3, [r3, #1]
        add r3, r8
        mov r1, r6
        ldr r2, =0x085b8cdc
        bl $00002b08

        ldr r3, EX_NUM_MEM
        ldrb    r3, [r3, #2]
        cmp r3, #240
        beq $0008e8a0
        mov r0, r5
        add r0, #41
        add r3, r8
        mov r1, r6
        ldr r2, =0x085b8cdc
        bl $00002b08

    $0008e8a0:
        mov r0, r5
        add r0, #48
        ldr r3, EX_NUM_MEM
        ldrb    r3, [r3, #3]
        add r3, r8
        mov r1, r6
        ldr r2, =0x085b8cdc
        bl $00002b08

        pop {r5, pc}
      
      
$00002b08:
    ldr r7, =0x08002b08
    mov pc, r7

$00018ea4:
    ldr r1, =0x08018ea4
    mov pc, r1

$0008e660:
    ldr r2, =0x0808e660
    mov pc, r2


NUMBER:
    ldr r1, =0x08003868
    mov pc, r1
    

EX_NUM_MEM = ADDR

.ltorg
.align
ADDR:
