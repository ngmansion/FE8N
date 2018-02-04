@thumb
;0002aec0
    cmp r0, #0
    bne Retrun ;戦闘終了フラグ
    
    ldr	r0, =$0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne Retrun ;闘技場チェック
    
    ldr r2, =$0203a5e8
    ldr r1, [r2]
    cmp r1, #0
    beq Retrun ;0x00なら終了
    mov r0, #0xFF ;突撃フラグ
    ldrb r1, [r2, #1]
    cmp r0, r1
    beq Retrun ;0xFFなら終了
    strb r0, [r2, #1]
Again:
    @dcw $ac01
    @dcw $4668
    @dcw $1c21
        ldr r3, =$0802aeec
        mov lr, r3
        @dcw $F800
    ldr r3, [r6, #0]
    ldr r1, [r3, #0]
    lsl r1, r1, #8
    lsr r1, r1, #27
    
    ldr r0, =$0802ae5c
    mov pc, r0
    
Retrun:
    ldr r3, [r6, #0]
    ldr r1, [r3, #0]
    lsl r1, r1, #8
    lsr r1, r1, #27
    
    ldr r0, =$0802aeca
    mov pc, r0
    
    