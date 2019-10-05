.equ hasRemove, (adr+0)
.equ hasMeditation, (adr+4)
@;0x01cefc
.thumb

@	bl kaifuku	@ひろいぐい
	
	ldr r0, [r4]
    ldrb r1, [r0, #11]
    mov r2, #192
    and r2, r1
    bne RETURN @;自軍以外は終了
	
    bl random	@再動
    cmp r0, #0
    beq RETURN
    
Sound:	@;再動の音
    ldr	r0, =0x0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	RETURN
    mov	r0, #97
    ldr	r2, =0x080d4ef4
    mov	lr, r2
    .short 0xf800

RETURN:
	mov r0, #0
    ldr r3, =0x0801cf5e
    mov pc, r3


kaifuku:
    push {lr}
    ldr r2, [r4]
    ldrb r0, [r2, #19] @;現在19
    ldrb r1, [r2, #18] @;最大18
    cmp r0, r1
    bge non_hp	@HP最大なら終了
    
    ldr r0, =0x0203a954
    ldrb r0, [r0, #17]
    cmp r0, #1
    bne non_hp @;待機以外なら終了
    
    ldr r0, [r4]
        ldr r2, hasMeditation
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non_hp
    
    @ランダム判定

    ldr r2, [r4]
    ldrb r0, [r2, #19] @;現在19
    ldrb r1, [r2, #18] @;最大18
    asr r1, r1, #1
    add r0, r0, r1
    
    ldrb r1, [r2, #18] @;最大18
    cmp r0, r1
    ble jump_hp
    mov r0, r1
jump_hp:
    strb r0, [r2, #19] @;現在19
    
    mov r0, #0x89
    mov r1, #0xB8
        ldr r2, =0x08014B50 @;音
        mov lr, r2
        .short 0xF800
    mov	r0, #1
    .short 0xE000
non_hp:
    mov	r0, #0
    pop	{pc}



random:
    push {lr}
    
    ldr r0, [r4]
        ldr r2, hasRemove
        mov lr, r2
        .short 0xF800
    cmp r0, #0
    beq non
        mov r0, #99
        ldr r2, =0x08000c58
        mov lr, r2
        .short 0xf800
    ldr r1, [r4]
    ldrb	r1, [r1, #25]
    cmp	r1, r0
    ble	non
    ldr r0, [r4]
    ldr	r1, [r0, #12]
    ldr	r2, =0xfffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    mov	r0, #1
    .short 0xE000
non:
    mov	r0, #0
    pop	{pc}
.ltorg
adr:
