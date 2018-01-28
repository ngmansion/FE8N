;000168e8
@thumb
    cmp r0, #0
    bne start ;装備可能アイテム発見
    ldr r0, =$080168f2
    mov pc, r0
start:
    push {r7}
    mov r7, r4

    ldr r0, =$0203A568
    ldr r1, [r0, #4]
    cmp r1, #0
    beq nothing ;戦闘開始以外
    ldrb r1, [r6, #0xB]
    ldrb r2, [r0, #0xB]
    cmp r1, r2
    bne nothing ;なんか違う
    
    ldr r0 =$0203a4e8
        @align 4
        ldr r1, [adr+0] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne nothing
    
    mov r0, r6
        @align 4
        ldr r1, [adr+4] ;持ち替え
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq nothing
loop:
    ldrh r0, [r4]
        ldr r1, =$08017314 ;アイテム特性
        mov lr, r1
        @dcw $F800
    mov r1, #0x80
    and r0, r1
    bne end ;反撃不可装備
    
    ldrh r0, [r4]
        ldr r1, =$08017448 ;射程
        mov lr, r1
        @dcw $F800
    cmp r0, #0xFF
    beq got ;全距離反撃
    
    ldr r1, =$0203a4d2
    ldrb r1, [r1] ;距離
    
    mov r2, #0xF
    and r2, r0
    cmp r1, r2
    bgt end ;射程より遠い
    
    mov r2, #0xF0
    and r2, r0
    lsr r2, r2, #4
    cmp r1, r2
    blt end ;射程より近い
    b got ;反撃可
nothing:
    mov r4, r7
got: ;問題なし
    ldrh r0, [r4]
    pop {r7}
    pop {r4, r5, r6}
    pop {r1}
    bx r1
    
end:
    add r5, #1
    cmp r5, #4
    bgt nothing ;反撃できないので通常判定の通りに終了
    
    lsl r1, r5, #1
    mov r0, r6
    add r0, #30
    add r4, r0, r1
    ldrh r1, [r4]
    mov r0, r6
        ldr r2, =$0801631c
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq end ;装備不能
    b loop
@ltorg
adr:


