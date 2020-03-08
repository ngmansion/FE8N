.thumb
@org   0808e75c

    push    {r4, r5, r6, r7, lr}
    mov r7, r8
    push    {r7}
    mov r4, r0
    mov r5, r1
    add r0, #68
    mov r1, #0
    ldsh    r6, [r0, r1]
    
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


    bl GetAttack
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
    mov r0, r4
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
    ldr r0, =0x0808e838
    mov pc, r0
end:
    ldr r0, =0x0808e8b4
    mov pc, r0

COPY_SIZE = (48)

GetAttack:
        push {r4, lr}
        ldr r4, =0x0203a4e8

        bl AtkSideFunc

        mov r0, #72
        ldrh r0, [r4, r0]
        cmp r0, #0
        beq falseAttack

        bl DefSideFunc

        mov r0, r4
        ldr r1, =0x0203a568
            ldr r2, =0x0802aa28     @攻撃
            mov lr, r2
            .short 0xF800

        mov r0, #90
        ldrh r0, [r4, r0]
        .short 0xE000
    falseAttack:
        mov r0, #0xFF
        pop {r4, pc}


AtkSideFunc:
        push {r4, r5, r6, lr}       @装備処理に合わせる
        mov r6, r4

        mov r0, r4
        mov r1, r5
        mov r2, #COPY_SIZE
        bl MEMCPY_R1toR0_FUNC

        mov r0, r5
        bl STRONG_FUNC
        strb r0, [r4, #20]

        mov r2, #0
        mov r1, #83
        strb r2, [r4, r1]       @すくみ初期化
        mov r1, #84
        strb r2, [r4, r1]       @すくみ初期化

@以降装備処理
        mov r0, r4
        bl $080168d0
        ldr r1, =0x0802a894
        mov pc, r1

$080168d0:
    ldr r1, =0x080168d0
    mov pc, r1





DefSideFunc:
        ldr r0, =0x0203a568
        mov r1, #0
        str r1, [r0, #4]
        bx lr

STRONG_FUNC:
    ldr r2, =0x08018ec4
    mov pc, r2

MEMCPY_R1toR0_FUNC:
    ldr r3, =0x080d6908
    mov pc, r3

NUMBER:
    ldr r1, =0x08003868
    mov pc, r1
    

    
