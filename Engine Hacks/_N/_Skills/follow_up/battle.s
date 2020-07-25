.thumb      @0002ae88
    
    mov r0, r5
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]

    b JudgeSemetate
retSemetate:
    cmp r0, #1
    beq reverse

    ldr r3, [r6, #0]
    ldr r2, [r3, #0]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #8          @反撃
    orr r1, r0
    ldr r5, =0xfff80000

    mov r0, r5
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]

    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    bl $0002af88        @二手目
    cmp r0, #0
    bne battle_end      @試合終了


    ldr r0, =0x0203a4e8
    ldr r1, =0x0203a568
    bl FollowUpBattle   @三手目
    cmp r0, #0
    bne battle_end      @試合終了
    b force_battle

reverse:        @攻め立て発動。

    ldr r0, =0x0203a4e8
    ldr r1, =0x0203a568
    bl FollowUpBattle       @三手目
    cmp r0, #0
    bne battle_end      @試合終了

    ldr r3, [r6, #0]
    ldr r2, [r3, #0]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #8          @反撃
    orr r1, r0
    ldr r5, =0xfff80000

    mov r0, r5
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]

    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    bl $0002af88        @二手目
    cmp r0, #0
    bne battle_end      @試合終了

force_battle:

    ldr r1, =0x0203a4e8
    ldr r0, =0x0203a568
    bl FollowUpBattle       @四手目

battle_end:         @敵機撃破
    ldr r0, =0x0802aec0
    mov pc, r0


@r4 = sp,#4
FollowUpBattle:
        push {r4, r5, lr}
        sub sp, #8
        mov r4, r0
        mov r5, r1


        str r4, [sp]
        str r5, [sp, #4]

        mov r0, sp          @ポインタ渡し
        add r1, sp, #4      @ポインタ渡し
                ldr r3, =0x0802af00
                mov lr, r3
                .short 0xF800
        ldr r1, [sp]

        cmp r0, #0
        beq nextInitial      @追撃無しなので終了
        cmp r1, r4
        bne nextInitial      @相手の追撃なので終了
    
        ldr r2, [r6, #0]
        ldr r0, [r2, #0]
        and r0, r5
        mov r1, #4          @追撃にチェック
        orr r0, r1
        str r0, [r2, #0]

        mov r0, r4
        mov r1, r5
        bl $0002af88
        .short 0xE000
    nextInitial:
        mov r0, #0
        add sp, #8
        pop {r4, r5, pc}



JudgeSemetate:
        ldr r0, =0x0203a4d0
        ldrh r0, [r0]
        mov r1, #0x20
        and r0, r1
        bne falseSemetate      @闘技場なら終了

        ldr r0, =0x0203a4e8
        ldr r1, [sp]
        cmp r0, r1
        bne falseSemetate      @先制攻撃者と加攻撃者が一致しないなら終了(待ち伏せ対策)

        ldr r0, [sp]
        ldr r1, [sp, #4]
        bl HAS_SEMETATE
        .short 0xE000
    falseSemetate:
        mov r0, #0
        b retSemetate

$0002af88:
    ldr r2, =0x0802af88
    mov pc, r2
HAS_SEMETATE:
    ldr r2, addr
    mov pc, r2


.align 4
.ltorg
addr:
