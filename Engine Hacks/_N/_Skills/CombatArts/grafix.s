ICON_POS = (0x0202F86)
@ 0801e684
.thumb

    ldr r0, [sp, #0x1C]
    ldr r1, =0x08022D5B
    cmp r0, r1
    bne END             @アイテム選択なら終わり？

    mov r0, r8
    add r0, #72
    ldrh r0, [r0]
    bl GetWeaponType
    cmp r0, #8
    bgt END             @武器以外なら終わり

        bl DrawWindow

        bl arrow_reset_func

        bl JudgeCapture
        cmp r0, #0
        beq notSkill
        mov r0, r8
        ldr r1, ADDR
        mov r2, #8
        bl GATHER_SKILL
    notSkill:
@ウィンドウが無い頃の、不要ならアイコン全削除する処理
@        cmp r0, #0
@        bne start
@        mov r0, #0x0
@        mov r1, #0
@        mov r2, #0x60
@        bl WrapIcon
@        b clear
@    start:
        ldr r1, ADDR+4
        mov r0, #1
        strb r0, [r1]
        
        mov r0, #0x0
        mov r1, #2
        neg r1, r1
        mov r2, #0x60
        bl WrapIcon
@    clear:
        mov r0, #4
        ldr r1, ADDR
        ldrb r1, [r1, #0]
        bl GetColor     @need ID in r1
        bl WrapIcon

        mov r0, #8
        ldr r1, ADDR
        ldrb r1, [r1, #1]
        bl GetColor     @need ID in r1
        bl WrapIcon

        mov r0, #12
        ldr r1, ADDR
        ldrb r1, [r1, #2]
        bl GetColor     @need ID in r1
        bl WrapIcon

        mov r0, #16
        ldr r1, ADDR
        ldrb r1, [r1, #3]
        bl GetColor     @need ID in r1
        bl WrapIcon

        mov r0, #20
        ldr r1, ADDR
        ldrb r1, [r1, #4]
        bl GetColor     @need ID in r1
        bl WrapIcon
        
        mov r0, #24
        ldr r1, ADDR
        ldrb r1, [r1, #5]
        bl GetColor     @need ID in r1
        bl WrapIcon
END:
    pop	{r3, r4, r5}
    mov	r8, r3
    mov	r9, r4
    mov	sl, r5
    pop	{r4, r5, r6, r7}
    pop	{r0}
    bx	r0



JudgeCapture:
        mov r2, r8
        ldr r0, [r2, #0xC]
        mov r1, #0x10
        and r0, r1
        beq trueCapture         @救出していない
        ldrb r0, [r2, #27]
        cmp r0, #0
        beq falseCapture        @誰も担いでいない
        b trueCapture
    trueCapture:
        mov r0, #1
        bx lr
    falseCapture:
        mov r0, #0
        bx lr



GetColor:
    ldr r2, SKL_TBL
    ldr r3, SKL_TBL_SIZE
    mul r3, r1
    add r3, r2
    ldrb r2, [r3, #2]
    mov r3, #1
    and r2, r3
    beq purpleColor
redColor:
    mov	r2, #0x80
    bx lr
purpleColor:
    mov	r2, #0x60
    bx lr



arrow_reset_func:
    ldr r0, ADDR
    mov r1, #0
    str r1, [r0]
    str r1, [r0, #4]
    str r1, [r0, #8]
    str r1, [r0, #12]
    bx lr


WrapIcon:
    push {lr}

    add	r0, r4
    add r0, #0x20
    add r0, #0x80
    add r0, #0x80

    add r1, #0x80
    add r1, #0x80

    lsl r2, r2, #7
    bl Icon
    pop {pc}


DrawWindow:
        push {lr}
        sub sp, #4

        ldr r0, =0x0804f0ec
        mov lr, r0

        mov r0, #0          @モード？ 123なら使えそう
        str r0, [sp, #0]

        mov r0, #1      @開始横座標
        mov r1, #0x10   @開始縦座標
        mov r2, #14     @横の長さ
        mov r3, #4      @縦の長さ
        .short 0xF800
        add sp, #4
        pop {pc}




GetWeaponType:
    ldr r3, =0x080172f0
    mov pc, r3
Icon:
    ldr r3, =0x08003608
    mov pc, r3

SKL_TBL      = (ADDR+8)
SKL_TBL_SIZE = (ADDR+12)
GATHER_SKILL:
    ldr r3, (ADDR+16)
    mov pc, r3

.align
.ltorg
ADDR:
