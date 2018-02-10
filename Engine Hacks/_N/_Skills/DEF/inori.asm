@thumb
;@org	0002b490 > 00 4A 97 46 XX XX XX 08
;
;
    mov r1, #4
    ldsh r0, [r4, r1]
    cmp r0, #0
    ble zero
bl DistantGuard ;遠距離無効
    cmp r0, #0
    bne zero
    
    mov r1, r10
    cmp r1, #0xDE
    beq end    ;必的チェック
    ldr r0, =$0203a604
    ldr r0, [r0]
    ldr r0, [r0]
    mov r1, #128
    lsl r1, r1, #3
    and r0, r1
    bne end    ;トライアングルチェック
    mov r1, #0xDF		;防御用
    mov r10, r1
bl HolyShield
    cmp r0, #0
    bne effect
bl Pray
    cmp r0, #0
    bne effect
bl Amulet
    cmp r0, #0
    bne effect
bl BigShield
    cmp r0, #0
    bne effect
bl Deflect
    cmp r0, #0
    bne end
bl Oracle
bl Xeno
    b end

effect
	ldr	r3, =$0203a604
	ldr	r3, [r3]
	ldr	r2, [r3]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #128
	lsl	r0, r0, #8
	orr	r1, r0
	ldr	r0, =$FFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3]
	b	end
zero
	mov	r0, #0
	strh	r0, [r4, #4]
end
    ldr r0, =$0802b49a
    mov pc, r0
    
    
    Deflect:
        push {lr}
            ldr r0, =$0203a4d0
            ldrh r0, [r0]
            mov r1, #0x20
            and r0, r1
            bne endDeflect ;闘技場チェック
        mov r0, r8
            @align 4
            ldr r3, [adr+32] ;連撃防御
            mov lr, r3
            @dcw $F800
        cmp r0, #0
        beq endDeflect
        
        mov r0, r8
        ldrb r0, [r0, #11]
            @align 4
            ldr r3 =$08019108
            mov lr, r3
            @dcw $F800
        ldrb r1, [r0, #0x13] ;戦闘前のHP
        mov r0, r8
        ldrb r0, [r0, #0x13] ;今のHP
        cmp r0, r1
        bge endDeflect ;HP減少(被攻撃)が無ければ終わり
        
        mov r0, r7
            @align 4
            ldr r1, [adr+16] ;見切り
            mov lr, r1
            @dcw $F800
        cmp r0, #0
        bne endDeflect
        ldrh r0, [r4, #4]
        asr r0, r0, #1
        strh r0, [r4, #4]
        mov r0, #1
        @dcw $E000
    endDeflect
        mov r0, #0
        pop {pc}
    
    
    
    DistantGuard:
        push {lr}
        mov r0, r8
            @align 4
            ldr r1, [adr+24] ;遠距離無効
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
    endDistantGuard
        mov r0, #0
        pop {pc}
        

BigShield:
    push {lr}
    mov r0, r8
        @align 4
        ldr r1, [adr] ;大盾
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq endShield
ouiShield
    mov	r3, r8
	mov	r0, #0x50
	ldrb	r0, [r7, r0]	;魔法判定
	cmp	r0, #7
	beq	endShield
	cmp	r0, #6
	beq	endShield
	cmp	r0, #5
	beq	endShield
	
	ldrb	r0, [r3, #21]	;技
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	endShield
	ldrh	r0, [r4, #4]
	lsr	r0, r0, #1
	strh	r0, [r4, #4]
	mov	r0, #1
	@dcw $E000
endShield
	mov	r0, #0
	pop	{pc}
	
	
HolyShield:
    push {lr}
    mov r0, r8
        @align 4
        ldr r1, [adr+4] ;聖盾
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq endHoly
Holy
    mov	r3, r8
	mov	r0, #0x50
	ldrb	r0, [r7, r0]	;物理判定
	cmp	r0, #7
	beq	ouiHoly
	cmp	r0, #6
	beq	ouiHoly
	cmp	r0, #5
	beq	ouiHoly
	b endHoly
ouiHoly
	ldrb	r0, [r3, #21]	;技
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	endHoly
	ldrh	r0, [r4, #4]
	mov r0, #0
	strh	r0, [r4, #4]
	mov	r0, #1
	pop	{pc}

endHoly
	mov	r0, #0
	pop	{pc}
	
	
Pray:
	push {lr}
    mov r0, r8
        @align 4
        ldr r1, [adr+12] ;祈り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    beq	endPray
    mov r3, r8
    ldrb r1, [r3, #19]
    cmp r1, #1
    beq endPray ;HP1なら終了
    ldrh r0, [r4, #4]
    cmp r0, r1
    blt endPray ;一撃で死なないなら終了
    @align 4
    ldr r1, [adr+20] ;祈り切り換え
    cmp r1, #0
    beq originalPray
newPray:
    ldrb r1, [r3, #25]
    cmp r0, r1
    bgt endPray ;ダメージが幸運を上回るか
    mov r0, r7
        @align 4
        ldr r1, [adr+16] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne endPray ;見切り持ちなら終了
    b effectPray

originalPray:
	ldrb	r0, [r3, #25]	;幸運
	lsl	r1, r0, #1
	add	r0, r0, r1
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	endPray
	
	
effectPray
	mov	r0, r8
	ldrb	r0, [r0, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
	mov	r0, #1
	pop	{pc}
endPray
	mov	r0, #0
	pop	{pc}


Oracle:
	push	{lr}
	@align 4
	ldr r1, [adr+8] ;聖盾
	mov lr, r1
	mov r0, r8
	@dcw $F800
	cmp r0, #0
	beq	endOracle
	
nihil_check
    mov r0, r7
        @align 4
        ldr r1, [adr+16] ;見切り
        mov lr, r1
        @dcw $F800
    cmp r0, #0
    bne	Nihil
	ldrh	r0, [r4, #4]
	asr	r0, r0, #1
	strh	r0, [r4, #4]
	b	endOracle
Nihil
	ldrh	r0, [r4, #4]
	lsl	r0, r0, #1
	mov	r1, #0
division
	add	r1, #1
	sub	r0, #3
	bgt	division
	sub	r1, #1
	strh	r1, [r4, #4]
endOracle
	pop	{pc}
	
	
Amulet:
	push {lr, r5}
	mov	r5, #0x1C
	mov	r3, r8
loopAmulet
	add	r5, #2
	cmp	r5, #40
	beq	endAmulet
	
	ldrh	r0, [r3, r5]
	cmp	r0, #0
	beq	loopAmulet
	ldr	r1, =$08017314
	mov	lr, r1
	@dcw $F800
	mov	r2, r1
	mov	r1, r0
	lsl	r0, r1, #5	;盾パッチの下の下
	bmi	ouiAmulet
	b	loopAmulet
	
ouiAmulet
	ldrb	r1, [r3, #19]	;現在HP
;一撃で死ぬか
	ldrh	r0, [r4, #4]	;ダメージ
	cmp	r0, r1
	blt	endAmulet
	
	ldrh	r0, [r3, r5]
	mov		r2, #0xFF
	lsl	r2, r2, #8
	tst	r0, r2
	beq	endAmulet	;破損チェック
	mov		r2, #0xFF
	and	r0, r2
	strh	r0, [r3, r5]	;破損処理
	
	ldrb	r0, [r3, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
	mov	r0, #1
	pop	{pc, r5}
endAmulet
	mov	r0, #0
	pop	{pc, r5}

Xeno:
    mov r2, r8
    ldrb r0, [r2, #11]
    ldr r1, =$0203a5e8 ;ゲノ
    ldrb r1, [r1]
    cmp r0, r1
    bne endXeno ;不発
;    ldrh r0, [r4, #4]
;    lsr r0, r0, #1
;    strh r0, [r4, #4]
    ldrb r1, [r2, #19]	;現在HP
;一撃で死ぬか
    cmp r0, r1
    blt endXeno
    sub r1, #1
    strh r1, [r4, #4]
endXeno
    bx lr


random:
	ldr	r2, =$0802a490
	mov	pc, r2
@ltorg
adr: