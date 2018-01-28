;0x02ad3c
@thumb
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r6, r1
    
    bl DistantGuard
    cmp r0, #0
    bne endZero
    
    mov	r0, r6
        @align 4
        ldr r1, [adr+16] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne next
    
    bl shisen
    
next:
    
    bl godBless

Return:
    ldr r5, [r4, #76]
    ldr r0, =$0802ad44
    mov r15, r0
endZero:
    mov r0, #0
    mov r1, r4
    add r1, #90
    strh r0, [r1] ;威力
    
    mov r0, #0x7F
    mov r1, r6
    add r1, #92
    strh r0, [r1] ;防御
    pop {r4, r5, r6}
    pop {r0}
    bx r0



DistantGuard:
    push {lr}
    mov r0, r6
        @align 4
        ldr r1, [adr+0] ;遠距離無効
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq endDistantGuard
    
    ldr r0, =$0203a4d2
    ldrb r0, [r0] ;距離
    cmp r0, #1
    beq endDistantGuard
    
    mov r0, #1
    @dcw $E000
endDistantGuard:
    mov r0, #0
    pop {pc}

godBless:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;光の加護
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne endBless
    
    mov r0, r6
        @align 4
        ldr r1, [adr+8] ;暗黒の加護
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq endBless

    mov r1, #90
    ldrh r0, [r4, r1] ;威力
    asr r0, r0, #1
    strh r0, [r4, r1] ;威力

    mov r0, #1
    @dcw $E000
endBless:
    mov r0, #0
    pop {pc}

shisen:
    push {lr}
    mov r0, r4
        @align 4
        ldr r1, [adr+12] ;死線
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

true:
    mov r0, #1
    pop {pc}
false:
    mov r0, #0
    pop {pc}

@ltorg
adr:

