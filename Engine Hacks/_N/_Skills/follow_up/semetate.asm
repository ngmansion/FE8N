@thumb ;0002ae88
@define RETURN_ADR $0802ae94
    
    mov r0, r5
    and r0, r2
    orr r0, r1
    str r0, [r3, #0]
    
    ldr r0, =$0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne return ;闘技場なら終了
    
    ldr	r0, =$0203a4e8
    ldr r1, [sp]
    cmp r0, r1
    bne return ;先制攻撃者と加攻撃者が一致しないなら終了(待ち伏せ対策)
    
    ldr r0, [sp, #4]
        @align 4
        ldr r3, [adr+4]
        mov lr, r3
        @dcw $F800
    cmp r0, #0
    bne return ;相手が見切りなら終了

    ldr r0, [sp]
        @align 4
        ldr r3, [adr]
        mov lr, r3
        @dcw $F800
    cmp r0, #0
    bne hit; 攻め立て所持
return:
    ldr r0, [sp, #4]
    ldr r1, [sp, #0]
    ldr r2, =RETURN_ADR
    mov pc, r2
hit: ;追撃可能か確認
        ldr r2, [sp]
        ldr r3, [r4]
            mov r0, sp ;ポインタ渡し
            mov r1, r4 ;ポインタ渡し
            push {r2, r3}
                @align 4
                ldr r3, =$0802af00
                mov lr, r3
                @dcw $F800
            pop {r2, r3}
        ldr r1, [sp]
        str r2, [sp]
        str r3, [r4]
    cmp r0, #0
    beq return ;追撃無しなので終了
    cmp r1, r2
    bne return ;相手の追撃なので終了
    
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
        @align 4
        ldr r3, =$0802af88
        mov lr, r3
        @dcw $F800
    lsl r0, r0, #24
    cmp r0, #0
    bne battle_end ;敵機撃破でジャンプ
    
    ldr r2, [r6, #0]
    ldr r0, [r2, #0]
    and r0, r5
    mov r1, #4		;;追撃にチェック
    orr r0, r1
    str r0, [r2, #0]
    ldr r1, [sp, #0]
    ldr r0, [sp, #4]
    ldr r2, =$0802aebc ;元の処理に戻る
    mov pc, r2

battle_end: ;敵機撃破
    ldr r0, =$0802aec0
    mov pc, r0

@ltorg
adr:
