;0x02ad3c
@thumb
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1
    
    mov	r0, r6
        @align 4
        ldr r1, [adr] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne Return
    
    bl shisen
    ldr r0, =$0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne Return ;闘技場チェック
    
    bl kishin
    
    bl kongou
    
    bl koroshi
    
Return:
    ldr r5, [r4, #76]
    ldr r0, =$0802ad44
    mov r15, r0
true:
    mov r0, #1
    pop {pc}
false:
    mov r0, #0
    pop {pc}

koroshi:
    push {lr}
    bl breaker_impl
    cmp r0, #0
    beq false
    
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] ;自分
    
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] ;自分
    
    mov r1, #94
    ldrh r0, [r4, r1]
    add r0, #3
    strh r0, [r4, r1] ;自分
    
    mov r1, #96
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] ;自分
    
    mov r1, #98
    ldrh r0, [r4, r1]
    add r0, #20
    strh r0, [r4, r1] ;自分
    b true

shisen:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;死線
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false
    
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #10
    strh r0, [r4, r1] ;自分
    ldrh r0, [r6, r1]
    add r0, #10
    strh r0, [r6, r1] ;相手
    b true

kishin:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+8] ;鬼神
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false
    
    ldr r0, =$03004df0
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne false
    mov r1, #90
    ldrh r0, [r4, r1]
    add r0, #5 ;威力
    strh r0, [r4, r1] ;自分

    mov r1, #106
    ldrh r0, [r4, r1]
    add r0, #15 ;必殺
    strh r0, [r4, r1] ;自分
    b true

kongou:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+12] ;金剛
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false
    
    ldr r0, =$03004df0
    ldr r0, [r0]
    ldrb r0, [r0, #0xB]
    
    ldrb r1, [r4, #0xB]
    cmp r0, r1
    bne false
    mov r1, #92
    ldrh r0, [r4, r1]
    add r0, #10
    strh r0, [r4, r1] ;自分
    b true
    
breaker_impl:
    push {lr}
    mov r0, r6
    add r0, #74
    ldrh r0, [r0]
        ldr r1, =$080172f0
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq sword
    cmp r0, #1
    beq lance
    cmp r0, #2
    beq axe
    cmp r0, #3
    beq bow
    cmp r0, #4
    beq false
    cmp r0, #7
    ble magic
    b false
sword:
    @align 4
    ldr r0, [adr+16]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    b merge
lance:
    @align 4
    ldr r0, [adr+20]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    b merge
axe:
    @align 4
    ldr r0, [adr+24]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    b merge
bow:
    @align 4
    ldr r0, [adr+28]
    mov lr, r0
    mov r0, r4
    @dcw $F800
    b merge
magic:
    @align 4
    ldr r0, [adr+32]
    mov lr, r0
    mov r0, r4
    @dcw $F800
merge:
    pop {pc}
@ltorg
adr:

