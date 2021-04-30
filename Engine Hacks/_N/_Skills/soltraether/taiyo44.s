.thumb

MAX_BATTLE_NUM = (24)
HAS_SOL_FUNC = (adr+4)
SOL_BIT = (adr+8)
SET_SKILLANIME_ATK_FUNC = (adr+12)
HAS_NIHIL_FUNC = (adr+16)
RADIANT_AETHER_BIT = (adr+20)
HAS_SOL_PLUS = (adr+24)

@(2B666 > )
    mov r3, r10
    push {r3}

    bl ClearFlag            @フラグ初期化

    ldr r0, =0x0203A4D0
    ldrb r0, [r0, #4]
    cmp r0, #0
    bne judge

    ldrh r0, [r7]
        ldr r1, =0x080174cc
        mov lr, r1
        .short 0xF800
    cmp r0, #2
    beq rizaia
    b false

judge:
@太陽発動分岐
    ldr r3, [r6]
    ldr r2, [r3]
    lsl r0, r2, #13
    lsr r0, r0, #13

    mov r1, #0x80
    ldr r2, RADIANT_AETHER_BIT
    lsl r1, r2
    and r1, r0
    cmp r1, #0
    bne arther          @天空

    mov r1, #0x80
    lsl r1, r1, #1
    and r1, r0
    cmp r1, #0
    bne rizaia          @HP吸収フラグ起動済み。通常HP吸収処理へ

    ldrh r0, [r7]
        ldr r1, =0x080174cc
        mov lr, r1
        .short 0xF800
    cmp r0, #2
    beq rizaia          @HP吸収武器。通常HP吸収処理へ

    ldr r0, [r6]
    ldr r0, [r0]
    lsl r0, r0, #13
    lsr r0, r0, #13
    mov r1, #128
    lsl r1, r1, #9
    and r0, r1
    bne false       @奥義発動済み

    mov r0, r4
        ldr r1, HAS_NIHIL_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #1
    beq false
    mov r0, r5
        ldr r2, HAS_SOL_FUNC @太陽
        mov lr, r2
        .short 0xF800
    cmp r0, #1
    beq taiyo

    mov r0, r5
    mov r1, r4
        ldr r2, HAS_SOL_PLUS @太陽
        mov lr, r2
        .short 0xF800
    cmp r0, #1
    beq rizaia

false:
    pop {r3}
    mov r10, r3
    ldr r0, =0x0802b6a2
    mov pc, r0
rizaia:
    pop {r3}
    mov r10, r3
    ldr r0, =0x0802B670
    mov pc, r0

taiyo:
@奥義目印
    mov r0, #21 @技(発動率)
    ldsb r0, [r5, r0]
    mov r1, #0
        ldr r2,	=0x0802a490
        mov lr, r2
        .short 0xF800
    lsl r0, r0, #13
    asr r0, r0, #13
    cmp r0, #0
    beq false
    
    mov r0, r5
    ldr r1, HAS_SOL_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800

    ldr r2, =0x0802b820
    ldr r2, [r2]
    ldr r2, [r2]
    ldr r0, [r2]

    mov r3, #0x80
    ldr r1, SOL_BIT
    lsl r3, r1
    orr r0, r3
    str r0, [r2]

    ldr r1, =0x0203a4d0
    ldrb r1, [r1, #4]
merge:
    ldrb r0, [r5, #19]      @NowHP
    add r0, r0, r1
    strb r0, [r5, #19]

    pop {r3}
    mov r10, r3
    ldr r3, =0x0802b67e
    mov pc, r3
@@@@
arther:
        ldr r1, =0x0203a4d0
        ldrb r2, [r1, #8]
        ldrb r1, [r1, #6]
        sub r1, r1, r2
        ble zeroArther
        mov r2, #3
        ldsb r2, [r7, r2]
        cmp r1, r2
        blt endArther       @小さければジャンプ(採用)
        mov r1, r2
        b endArther
    zeroArther:
        mov r1, #0
    endArther:
        b merge

ClearFlag:
        mov r0, #0
        mov r2, #0
        ldr r1, adr @(勝手な太陽フラグ)
    clear_loop:
        str r0, [r1]
        add r1, #4
        add r2, #1
        cmp r2, #MAX_BATTLE_NUM
        blt clear_loop
        bx lr

.align
.ltorg
adr:
