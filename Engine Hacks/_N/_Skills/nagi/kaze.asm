@thumb
;0002a834

    cmp r0, #0
    beq cancel ;射程外
    
    ldr r0, =$03004df0
    ldr r0, [r0]
    ldrb r0, [r0, #11]
    ldrb r1, [r5, #11]
    cmp r0, r1
    beq normal ;攻撃者じゃ無い
;反撃者を確認している
    mov r0, r5
        @align 4
        ldr r1, [adr+0] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne normal ;見切り

    ldr r0, =$0203a4e8
        @align 4
        ldr r1, [adr+4] ;風薙ぎ
        mov lr, r1
        @dcw $F800
    bne cancel ;スキル無し
normal
    mov r1, r8
    ldrb r0, [r1, #0]
    cmp r0, #255
    bne end ;アイテム無し？？
cancel
    ldr r0, =$0802a840
    mov pc, r0
end
    ldr r0, =$0802a84a
    mov pc, r0
@ltorg
adr: