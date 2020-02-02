.thumb

MAX_BATTLE_NUM = (24)
HAS_SOL_FUNC = (adr+4)

SET_SKILLANIME_ATK_FUNC = (adr+12)
HAS_NIHIL_FUNC = (adr+16)

@(2B666 > )
	mov	r0, r10
	push	{r0}
@フラグ初期化
    mov r0, #0
    mov r2, #0
    ldr r1, adr @(勝手な太陽フラグ)
clear_loop:
    str r0, [r1]
    add r1, #4
    add r2, #1
    cmp r2, #MAX_BATTLE_NUM
    blt clear_loop

    ldr r0, =0x0203A4D0
    ldrb r0, [r0, #4]
    cmp r0, #0
    beq buki
@太陽発動分岐
    ldr r3, [r6]
    ldr r2, [r3]
    lsl r0, r2, #13
    lsr r0, r0, #13

    mov r2, #0x80
    lsl r2, r2, #1
    and r0, r2
    cmp r0, #0
    bne rizaia @HP吸収フラグ起動済み


    mov r0, r4
        ldr r1, HAS_NIHIL_FUNC
        mov lr, r1
        .short 0xF800
    cmp r0, #1
    beq buki

    mov r0, r5
        ldr r1, HAS_SOL_FUNC @太陽
        mov lr, r1
        .short 0xF800
    cmp r0, #1
    beq taiyo
buki:
    ldrh r0, [r7]
        ldr r1,	=0x080174cc
        mov lr, r1
        .short 0xF800
    cmp r0, #2
    beq rizaia
@hazure
	pop	{r0}
	mov	r10, r0
    ldr r0, =0x0802b6a2
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
    cmp r0, #1
    bne buki
    
    mov r0, r5
    ldr r1, HAS_SOL_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_ATK_FUNC
        mov lr, r2
        .short 0xF800

rizaia:
    pop {r0}
    mov r10, r0
    ldr r0, =0x0802B670
    mov pc, r0
.align
.ltorg
adr:
