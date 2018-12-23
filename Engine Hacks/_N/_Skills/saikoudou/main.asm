@define ATK ($0203a4e8)
@define DEF ($0203a568)



@define hasRemove (adr+0)
@define hasGaleforce (adr+4)
@define hasLifetaker (adr+8)
@define hasCantoPlus (adr+12)
@define hasGaleCause (adr+16)

@define TARGET_UNIT ($03004df0)

@define WEAPON_SP_ADR ($080172f0)
;0x01cea8
@thumb
    push {r4, r5, lr}
    mov r5, r0
	ldr r4 =TARGET_UNIT
	ldr r4, [r4]
;    ldr r4, =ATK
    
    mov r0, r4
    ldrb	r1, [r0, #0x13]
    cmp r1, #0	;自分のHPゼロなら何もせずに終了
    beq end		;
    ldr r0, [r0, #12]
    ldr r1, =$0801cf04
    ldr r1, [r1]
    and	r0, r1	;再移動後はスキップ
    bne end		;

    bl kaifuku
    
    mov r0, r4
    ldrb r1, [r0, #11]
    mov r2, #192
    and r2, r1
    bne end ;自軍以外は終了
    bl shippuJinrai
    cmp r0, #0
    bne Sound
    
    ldr r0, =DEF
    ldr r1, [r0, #4]
    cmp r1, #0		;相手がいない
    beq next		;
    ldrb r1, [r0, #0xB]
    cmp r1, #0		;相手がいない_その2（不要？）
    beq next		;
    
    bl jinpuShourai	;神風招来
    cmp r0, #0
    bne Sound
    
next
    bl random
    cmp r0, #0
    bne Sound
;スキル再移動による再移動化
    mov r0, r4
        @align 4
        ldr r1, [adr+12] ;再移動
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne Canto
    ldr r2, =TARGET_UNIT
    ldr r3, [r2]
    mov r4, r2
    ldr r0, =$0801ceb0 ;通常の再移動判定
    mov pc, r0
    
Canto:
    ldr r4, =TARGET_UNIT
    ldr r3, =$0801cece
    mov pc, r3
    
    
Sound:
    ldr	r0, =$0202bcec
    add	r0, #65
    ldrb	r0, [r0, #0]
    lsl	r0, r0, #30
    bmi	end
    mov	r0, #97
    ldr	r2, =$080d4ef4
    mov	lr, r2
    @dcw 0xf800
end:
    mov	r0, #0
    pop	{r4, r5, pc}
    
jinpuShourai:
    push {lr}
    mov	r0, r4
        @align 4
        ldr r2, [hasGaleCause]
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq dameda
    
    mov r0, r4
    ldr r1, =ATK
    ldrb r0, [r0, #0xB]
    ldrb r2, [r1, #0xB]
    cmp r0, r2
    bne dameda
    add r1, #0x48
    ldrh r0, [r1]
        ldr r2, =WEAPON_SP_ADR
        mov lr, r2
        @dcw $F800
    cmp r0, #4		;杖
    bne dameda
    mov	r0, r4
    add r0, #69
    
    ldrb	r1, [r0]
    cmp r1, #0xFF
    beq dameda
    b gogot ;待機チェック
dameda
    mov	r0, #0
    pop	{lr}
    
    
kaifuku:
    push {lr}
    mov	r0, r4
        @align 4
        ldr r2, [adr+8]
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq non_hp
    
    mov r0, r4
    ldr r1, =ATK
    ldrb r0, [r0, #0xB]
    ldrb r1, [r1, #0xB]
    cmp r0, r1
    bne non_hp
    ldr r1, =DEF
    ldrb r1, [r1, #0x13] ;相手撃破
    cmp r1, #0
    bne non_hp
    
    mov	r2, r4
    ldrb r0, [r2, #19] ;現在19
    ldrb r1, [r2, #18] ;最大18
    asr r1, r1, #1
    add r0, r0, r1
    
    ldrb r1, [r2, #18] ;最大18
    cmp r0, r1
    ble jump_hp
    mov r0, r1
jump_hp:
    strb r0, [r2, #19] ;現在19
    
    mov r0, #0x89
    mov r1, #0xB8
        ldr r2, =$08014B50 ;音
        mov lr, r2
        @dcw $F800
    mov	r0, #1
    @dcw $E000
non_hp:
    mov	r0, #0
    pop	{lr}
    
    
    
shippuJinrai:
    push {lr}
    mov	r0, r4
        @align 4
        ldr r2, [hasGaleforce]
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq non_ka
    
    mov r0, r4
    ldr r1, =ATK
    ldrb r0, [r0, #0xB]
    ldrb r1, [r1, #0xB]
    cmp r0, r1
    bne non_ka
    ldr r1, =DEF
    ldrb r1, [r1, #0x13]
    cmp r1, #0		;相手のHP
    bne non_ka		;
    
    mov	r0, r4
    add r0, #69
    
    ldrb	r1, [r0]
    cmp r1, #0xFF
    bne gogot
    b non_ka ;待機チェック
    
gogot:
    mov r1, #0xFF
    strb r1, [r0] ;既成事実
    
    mov	r0, r4
    ldr	r1, [r0, #12]	;行動済み等の状態
    ldr	r2, =$fffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    mov	r0, #1
    @dcw $E000
non_ka:
    mov	r0, #0
    pop	{lr}
    
    
random
    push {lr}
    mov	r0, r4
        @align 4
        ldr r2, [adr]
        mov lr, r2
        @dcw $F800
    cmp r0, #0
    beq non
        mov r0, #99
        ldr r2, =$08000c58
        mov lr, r2
        @dcw 0xf800
    mov	r1, r4
    ldrb	r1, [r1, #25]
    cmp	r1, r0
    ble	non
    mov	r0, r4
    ldr	r1, [r0, #12]
    ldr	r2, =$fffffbbd
    and	r1, r2
    str	r1, [r0, #12]
    mov	r0, #1
    @dcw $E000
non:
    mov	r0, #0
    pop	{lr}
@ltorg
adr:
