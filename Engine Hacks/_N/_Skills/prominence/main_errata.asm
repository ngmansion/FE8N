@thumb
;0002e7ec
    ldr r4, =$0202CFB8 ;敵アドレス

loop_al:
    ldr r1, [r4]
    cmp r1, #0
    beq next_al
    ldrb r1, [r4, #16]	;座標
    cmp r1, #255
    bge next_al
    ldrb r1, [r4, #19]	;現在HP
    cmp r1, #0
    beq next_al
    ldrb r1, [r4, #12]	;救出
    lsl r1, r1, #26
    bmi next_al
    mov r0, r4
        @align 4
        ldr r1, [adr] ;
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq next_al
    
    push {r6}
    ldrb r5, [r4, #17] ;Y座標
    ldrb r4, [r4, #16] ;X座標
    mov r6, #0
next_flare:
    bl address_calc
    cmp r0, #0
    beq loop_flare
    
    mov r2, r5 ;Y座標
    ldr r0, =$0202e4d4
    ldr r1, [r0]
    lsl r0, r2, #2
    add r0, r0, r1
    mov r1, r4 ;X座標
    ldr r0, [r0]
    add r0, r0, r1
    ldrb r0, [r0]
    cmp r0, #0
    beq loop_flare
    cmp r0, #0x80
    bgt loop_flare ;自軍以外ならスルー
    
    ldr r3, =$08050630
    mov lr, r3
    mov r0, r4
    mov r1, r5
    mov r2, #0
    mov r3, #4
    @dcw $F800
    
    mov r0, r4
    mov r1, r5
    mov r2, #10 ;ダメージ？
        ldr r3, =$0802e628
        mov lr, r3
        @dcw $F800
loop_flare:
    add r6, #1
    cmp r6, #11
    ble next_flare
    pop {r6}
    pop {r4, r5}
    pop {r0}
    bx r0
        
next_al:
    add r4, #0x48
    ldrb r0, [r4, #11]
    cmp r0, #0xB3
    ble loop_al
return:
    ldr r4, =$0203a610
    ldr r0, =$0802e8d0
    mov pc, r0

address_calc:
    cmp r6, #1
beq one
    cmp r6, #2
beq two
    cmp r6, #3
beq three
    cmp r6, #4
beq four
    cmp r6, #5
beq five
    cmp r6, #6
beq six
    cmp r6, #7
beq seven
    cmp r6, #8
beq eight
    cmp r6, #9
beq nine
    cmp r6, #10
beq ten
    cmp r6, #11
beq eleven
    sub r5, #2
    b judge
one
    add r5, #1
    b judge
two
    add r4, #1
    b judge
three
    add r5, #1
    b judge
four
    add r4, #1
    b judge
five
    sub r4, #1
    add r5, #1
    b judge
six
    sub r4, #1
    b judge
seven
    add r5, #1
    b judge
eight
    sub r4, #1
    sub r5, #1
    b judge
nine
    sub r5, #1
    b judge
ten
    sub r4, #1
    b judge
eleven
    sub r5, #1
    add r4, #1
    
judge:
    cmp r4, #0
    blt owari
    cmp r5, #0
    blt owari
    mov r0, #1
    @dcw $E000
owari:
    mov r0, #0
    bx lr
@ltorg
adr: