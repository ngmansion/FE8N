@thumb
    ldr	r5, =$0203a4d0
    ldrh r0, [r5]
    mov r1, #0x20
    and r0, r1
    bne endwo ;闘技場チェック
    
    mov r0, r8
        @align 4
        ldr r1, [adr+8] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne endwo
    
    bl cancel
    
    bl ikari
endwo:
    mov r1, #6
    ldsh r0, [r5, r1]
    mov r9, r0
    ldr r3, =$0802b3ac
    mov pc, r3
    
cancel:
    push {lr}
    mov r0, r7
        @align 4
        ldr r1, [adr] ;キャンセル
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false

    ldr r0, =$0203A604
    ldr r0, [r0]
    ldr r0, [r0]
    lsl r0, r0, #29
;   bmi false ;追撃チェック

    mov r0, #0x15
    ldsb r0, [r7] ;技％
    lsl r0, r0, #16
    lsr r0, r0, #16
    mov r1, #0
    bl random ;r0=確率, r1=#0で乱数
    lsl r0, r0, #24
    asr r0, r0, #24
    cmp r0, #0
    beq false
;キャンセル発動
    mov r0, #0
    mov r1, r8
    add r1, #72
    strh r0, [r1]	;相手装備消去
    strb r0, [r1, #10]	;相手武器消滅防止
effect:
    ldr r0, =$0203a604
    ldr r3, [r0]
    ldr r2, [r3]
    lsl r1, r2, #13
    lsr r1, r1, #13
    mov r0, #0x80
    lsl r0, r0, #7
    orr r1, r0
    ldr r0, =$FFF80000
    and r0, r2
    orr r0, r1
    str r0, [r3] ;必的発動の処理（エフェクト用）
    pop {pc}
    
    
ikari: ;怒り
    push {lr}
    ldr r0, [r7, #76]
    mov r1, #0x90
    and r0, r1
    bne false ;反撃不可武器と魔法剣は無視
    
    mov r0, r7 ;イクリプス開始
    add r0, #74
    ldrh r0, [r0]
        ldr r1, =$080174cc
        mov lr, r1
        @dcw $F800
    cmp r0, #3
    beq false ;HP1武器は無視
    
    mov r0, #0x13
    ldsb r0, [r7, r0]
    cmp r0, #10
    bge false ;HP分岐
    
    mov r0, r7
        @align 4
        ldr r1, [adr+4] ;怒り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false
    ldrh r0, [r5, #12]
    add r0, #50
    strh r0, [r5, #12]
false:
    pop {pc}
random:
    ldr r3, =$0802a490
    mov pc, r3

@ltorg
adr:
	