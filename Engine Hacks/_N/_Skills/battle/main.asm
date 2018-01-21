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

shisen:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;死線
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq false
    
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] ;自分
    mov r1, r6
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #10
    add r1, #90
    strh r0, [r1] ;相手
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
    mov r1, r4
    mov r0, #90
    ldrh r0, [r1, r0]
    add r0, #5 ;威力
    add r1, #90
    strh r0, [r1] ;自分

    mov r1, r4
    mov r0, #106
    ldrh r0, [r1, r0]
    add r0, #15 ;必殺
    add r1, #106
    strh r0, [r1] ;自分
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
    mov r1, r6
    mov r0, #90
    ldrh r0, [r1, r0]
    sub r0, #10
    add r1, #90
    strh r0, [r1] ;相手
    b true

@ltorg
adr:

