;00016918
@thumb
    cmp r0, #0
    bne start ;装備可能アイテム発見
    ldr r0, =$08016922
    mov pc, r0
start:
    push {r6, r7}
    mov r7, r4
    mov r6, #0xFF

    ldr r0, =$0203A568
    ldr r1, [r0, #4]
    cmp r1, #0
    beq nothing ;戦闘開始以外
    cmp r0, r5
    bne nothing ;なんか違う
    
    ldr r0 =$0203a4e8
        @align 4
        ldr r1, [adr+0] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne nothing
    
    mov r0, r5
        @align 4
        ldr r1, [adr+4] ;持ち替え
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nothing
loop:
    lsl r1, r4, #1
    add r1, #30
    ldrh r0, [r5, r1]
        ldr r1, =$08017314 ;アイテム特性
        mov lr, r1
        @dcw $F800
    mov r1, #0x80
    and r0, r1
    bne next ;反撃不可装備
    
    lsl r1, r4, #1
    add r1, #30
    ldrh r0, [r5, r1]
        ldr r1, =$08017448 ;射程
        mov lr, r1
        @dcw $F800
    
    ldr r1, =$0203a4d2
    ldrb r1, [r1] ;距離

;    ldrb r2, [r5, #0xB]
;    lsl r2, r2, #24
;    lsr r2, r2, #30
;    beq ally ;自軍なら予約制度無し

    lsl r2, r1, #4
    orr r2, r1
    cmp r0, r2
    beq got ;ピッタリ
    cmp r6, #0xFF
    bne next ;先約有り
    
    mov r2, #0xF
    and r2, r0
    cmp r1, r2
    bgt next ;射程より遠い
    mov r2, #0xF0
    and r2, r0
    lsr r2, r2, #4
    cmp r1, r2
    blt next ;射程より近い
    mov r6, r4
    b next ;予約して次へ
    
ally:
    mov r2, #0xF
    and r2, r0
    cmp r1, r2
    bgt next ;射程より遠い
    mov r2, #0xF0
    and r2, r0
    lsr r2, r2, #4
    cmp r1, r2
    blt next ;射程より近い
    b got

nothing:
    mov r4, r7
    cmp r6, #0xFF
    beq got ;予約なし
    mov r4, r6
got: ;問題なし
    mov r0, r4
    pop {r6, r7}
    pop {r4, r5}
    pop {r1}
    bx r1
    
next:
    add r4, #1
    cmp r4, #4
    bgt nothing ;反撃できないので通常判定の通りに終了
    
    lsl r1, r4, #1
    mov r0, r5
    add r0, #30
    add r0, r0, r1
    ldrh r1, [r0]
    mov r0, r5
        ldr r2, =$080164f8
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq next ;装備不能
    b loop
@ltorg
adr:


