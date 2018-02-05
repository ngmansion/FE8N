@thumb
;0002ae54
    
    ldr r2, =$0203a5e8
    mov r0, #0x0
    str r0, [r2] ;フラグリセット
    
    ldr r0, =$0203a4d0
    ldrh r2, [r0]
    mov r0, #2
    and r0, r2
    cmp r0, #0
    bne Return ;戦闘予測
    mov r0, #0x20
    and r0, r2
    bne Return ;闘技場チェック
;突撃
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    bl charge
    ldr r1, [sp, #0]
    ldr r0, [sp, #4]
    bl charge
;ジェノサイド
    ldr r0, [sp, #0]
    ldr r1, [sp, #4]
    mov r2, #72
    ldrh r2, [r1, r2]
    cmp r2, #0
    beq Return ;相手が反撃不可
    bl zeno
    cmp r0, #0
    bne firstXeno
    
    ldr r1, [sp, #0]
    ldr r0, [sp, #4]
    bl zeno
    cmp r0, #0
    bne secondXeno
Return:
    ldr r3, [r6]
    ldr r1, [r3]
    lsl r1, r1, #8
    lsr r1, r1, #27
    ldr r0, =$0802ae5c
    mov pc, r0

firstXeno
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl zeno_impl
    b Return
secondXeno
    ldr r0, [sp, #4]
    ldr r1, [sp]
    bl zeno_impl
    b Return
    
zeno_impl:
    mov r3, r0
    ldr r2, =$0203a5e8
    ldrb r0, [r3, #11]
    str r0, [r2]
    
    add r1, #100
    ldrb r0, [r1]
    sub r0, #20
    strb r0, [r1]
    
    mov r1, #90
    ldsb r0, [r3, r1]
    add r0, #10
    strb r0, [r3, r1]
    
    mov r1, #94
    ldsb r0, [r3, r1]
    add r0, #3
    strb r0, [r3, r1]
    
    bx lr
    
zeno:
    push {r4, lr}
    mov r4, r0
    
    mov r0, r1
        @align 4
        ldr r1, [adr]
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne notZeno
    mov r0, r4
        @align 4
        ldr r1, [adr+4] ;zeno
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq notZeno
    ldrb r0, [r4, #0x13] ;nowHP   
        ldr r1, =$08000c78
        mov lr, r1
        @dcw $F800
    lsl r0, r0, #24
    asr r0, r0, #24
    b endZeno
notZeno:
    mov r0, #0
endZeno:
    pop {r4, pc}
    
charge:
    push {r4, lr}
    mov r4, r0
    mov r2, #94
    ldsh r0, [r4, r2]
    ldsh r2, [r1, r2]
    cmp r0, r2
    ble notCharge ;速さが足りない！
    ldrb r0, [r4, 0x13]
    ldrb r2, [r1, 0x13]
    cmp r0, r2
    ble notCharge ;HPが足りない！

    
    mov r0, r1
        @align 4
        ldr r1, [adr] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne notCharge
    mov r0, r4
        @align 4
        ldr r1, [adr+8] ;突撃
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq notCharge
    mov r0, #0xFF
    ldr r2, =$0203a5e8 ;無効ユニットIDストア
    strb r0, [r2]
    mov r0, #1
    b endCharge
notCharge
    mov r0, #0
endCharge
    pop {r4, pc}
    
    
    
    
    
    
@ltorg
adr:
