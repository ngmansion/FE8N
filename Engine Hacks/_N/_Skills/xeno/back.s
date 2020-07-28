.thumb
@0002aec0
    cmp r0, #0
    bne Retrun @戦闘終了フラグ
    
    ldr	r0, =0x0203a4d0
    ldrh r0, [r0]
    mov r1, #0x20
    and r0, r1
    bne Retrun @闘技場チェック
    
    ldr r2, adr
    ldr r1, [r2]
    cmp r1, #0
    beq Retrun @突撃系スキル未発動なら終了
    mov r0, #0xFF
    ldrb r1, [r2, #1]
    cmp r0, r1
    beq Retrun @突撃済みフラグが既にONなら終了
    strb r0, [r2, #1]	@突撃済みフラグON
Again:
    .short 0xac01
    .short 0x4668
    .short 0x1c21
        ldr r3, =0x0802aeec
        mov lr, r3
        .short 0xF800
    ldr r3, [r6, #0]
    ldr r1, [r3, #0]
    lsl r1, r1, #8
    lsr r1, r1, #27
    
    ldr r0, =0x0802ae5c
    mov pc, r0
    
Retrun:
    ldr r3, [r6, #0]
    ldr r1, [r3, #0]
    lsl r1, r1, #8
    lsr r1, r1, #27
    
    ldr r0, =0x0802aec8
    mov pc, r0
.align
.ltorg
adr:
    