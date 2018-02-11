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
        ldr r1, [adr] ;skill
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq next_al
    
    push {r6, r7}
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
    
    ldr r1, =$08019108 ;=部隊表IDから変換
    mov lr, r1
    @dcw $F800
    mov r7, r0
    
    ldr r3, =$08050630
    mov lr, r3
    mov r0, r4
    mov r1, r5
    mov r2, #0
    mov r3, #4
    @dcw $F800
    
    mov r0, #10
        ldr r3, =$08000c58
        mov lr, r3
        @dcw $F800
    mov r2, r0
    ldrb r0, [r7, #19]
    cmp r0, #1
    beq out
    add r2, #10 ;ダメージ
    sub r2, r0, r2
    bgt genki
    mov r2, #1
genki
    strb r2, [r7, #19]
    b loop_flare
out
    mov r0, r4
    mov r1, r5
    mov r2, #10 ;ダメージ
        ldr r3, =$0802e628
        mov lr, r3
        @dcw $F800
loop_flare:
    add r6, #1
    cmp r6, #59 ;3マスは#23
    ble next_flare
    pop {r6, r7}
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
beq label01
    cmp r6, #2
beq label02
    cmp r6, #3
beq label03
    cmp r6, #4
beq label04
    cmp r6, #5
beq label05
    cmp r6, #6
beq label06
    cmp r6, #7
beq label07
    cmp r6, #8
beq label08
    cmp r6, #9
beq label09
    cmp r6, #10
beq label10
    cmp r6, #11
beq label11
;
;
;
    cmp r6, #12
beq label12: ;new!
    cmp r6, #13
beq label13
    cmp r6, #14
beq label14
    cmp r6, #15
beq label15
    cmp r6, #16
beq label16
    cmp r6, #17
beq label17
    cmp r6, #18
beq label18
    cmp r6, #19
beq label19
    cmp r6, #20
beq label20
    cmp r6, #21
beq label21
    cmp r6, #22
beq label22
    cmp r6, #23
    beq label23
;
;
;
    cmp r6, #24
    beq label24
    cmp r6, #25
    beq label25
    cmp r6, #26
    beq label26
    cmp r6, #27
    beq label27
    cmp r6, #28
    beq label28
    cmp r6, #29
    beq label29
    cmp r6, #30
    beq label30
    cmp r6, #31
    beq label31
    cmp r6, #32
    beq label32
    cmp r6, #33
    beq label33
    cmp r6, #34
    beq label34
    cmp r6, #35
    beq label35
    cmp r6, #36
    beq label36
    cmp r6, #37
    beq label37
    cmp r6, #38
    beq label38
    cmp r6, #39
    beq label39
    cmp r6, #40
    beq label40
    cmp r6, #41
    beq label41
    cmp r6, #42
    beq label42
    cmp r6, #43
    beq label43
    cmp r6, #44
    beq label44
    cmp r6, #45
    beq label45
    cmp r6, #46
    beq label46
    cmp r6, #47
    beq label47
    cmp r6, #48
    beq label48
    cmp r6, #49
    beq label49
    cmp r6, #50
    beq label50
    cmp r6, #51
    beq label51
    cmp r6, #52
    beq label52
    cmp r6, #53
    beq label53
    cmp r6, #54
    beq label54
    cmp r6, #55
    beq label55
    cmp r6, #56
    beq label56
    cmp r6, #57
    beq label57
    cmp r6, #58
    beq label58
    cmp r6, #59
    beq label59
label00:
    sub r5, #1
    b judge
label01
    add r4, #1
    add r5, #1
    b judge
label02
    sub r4, #1
    add r5, #1
    b judge
label03
    sub r4, #1
    sub r5, #1
    b judge
;;;;;;;;;;;;;;
label04
    add r4, #1
    sub r5, #2
    b judge
label05
label06
    add r4, #1
    add r5, #1
    b judge
label07
label08
    sub r4, #1
    add r5, #1
    b judge
label09
label10
    sub r4, #1
    sub r5, #1
    b judge
label11
    add r4, #1
    sub r5, #1
    b judge
;;;;;;;
label12
    add r4, #1
    sub r5, #2
    b judge
label13
label14
label15
    add r4, #1
    add r5, #1
    b judge
label16
label17
label18
    sub r4, #1
    add r5, #1
    b judge
label19
label20
label21
    sub r4, #1
    sub r5, #1
    b judge
label22
label23
    add r4, #1
    sub r5, #1
    b judge
;;;;;;;
label24
    add r4, #1
    sub r5, #2
    b judge
label25
label26
label27
label28
    add r4, #1
    add r5, #1
    b judge
label29
label30
label31
label32
    sub r4, #1
    add r5, #1
    b judge
label33
label34
label35
label36
    sub r4, #1
    sub r5, #1
    b judge
label37
label38
label39
    add r4, #1
    sub r5, #1
    b judge
;;;;;;;;;;;;;
label40
    add r4, #1
    sub r5, #2
    b judge
label41
label42
label43
label44
label45
    add r4, #1
    add r5, #1
    b judge
label46
label47
label48
label49
label50
    sub r4, #1
    add r5, #1
    b judge
label51
label52
label53
label54
label55
    sub r4, #1
    sub r5, #1
    b judge
label56
label57
label58
label59
    add r4, #1
    sub r5, #1
    
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