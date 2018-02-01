@thumb
;0002e7ec
    

    ldr r0, =$0202BCFC
    ldrb r0, [r0]
    mov r1, #0x3
    and r0, r1
    cmp r0, #3
    bne return ;4ターンおきじゃない
    
    ldr r4, =$0202BE48 ;自軍アドレス
loop_al:
    ldrb r1, [r4, #16]	;座標
    cmp r1, #255
    bge next_al
    ldrb r1, [r4, #19]	;現在HP
    cmp r1, #0
    beq next_al
    ldrb r1, [r4, #12]	;救出
    lsl r1, r1, #26
    bmi next_al
    
        mov r0, #99
        ldr r2, =$08000c58
        mov lr, r2
        @dcw 0xf800
    cmp r0, #50
    ble next_al
    ldr r3, =$08050630
    mov lr, r3
    ldrb r0, [r4, #16] ;座標
    ldrb r1, [r4, #17] ;座標
    mov r2, #0
    mov r3, #4
    @dcw $F800
    
    ldrb r0, [r4, #16] ;座標
    ldrb r1, [r4, #17] ;座標
    mov r2, #10 ;ダメージ？
        ldr r3, =$0802e628
        mov lr, r3
        @dcw $F800
next_al:
    add r4, #0x48
    ldrb r0, [r4, #11]
    cmp r0, #63
    ble loop_al
    
    pop {r4, r5}
    pop {r0}
    bx r0
    
return:
    ldr r4, =$0203a610
    ldr r0, =$0802e8d0
    mov pc, r0
    
    ldr r4, =$0202CFB8 ;敵アドレス
    
    ldr r0, [r4]
    cmp r0, #0
    