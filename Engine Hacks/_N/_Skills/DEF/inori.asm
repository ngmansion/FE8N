@thumb
;@org	0002b490 > 00 4A 97 46 XX XX XX 08

;
	mov	r1, #4
	ldsh	r0, [r4, r1]
	cmp	r0, #0
	ble	zero
	mov	r3, r8
	mov	r1, r10
	cmp	r1, #0xDE	;必的チェック
	beq	end
	mov	r1, #0xDF		;防御用
	mov	r10, r1
	
bl BigShield
	cmp	r0, #1
	beq	effect
bl HolyShield
	cmp	r0, #1
	beq	effect
bl Pray
	cmp	r0, #1
	beq	effect
bl Oracle
	b	end

effect:
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
	
zero:
	mov	r0, #0
	strh	r0, [r4, #4]
end:
	ldr	r0, =$0802b49a
	mov	pc, r0
	

BigShield:
	push {lr}
@align 4
	ldr	r2, [adr]	;大盾クラスアドレス
	ldr	r1, [r3, #4]
	ldrb	r1, [r1, #4]
loop
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	skill1_check
	cmp	r0, r1
	beq	ootate
	add	r2, #1
	b	loop
;ユニットチェック
skill1_check
	ldr	r1, [r3]
	ldrh	r1, [r1, #0x26]	;;ユニット0x1
	ldrh	r0, [r3, #0x3A]
	orr r1, r0
	lsl	r1, r1, #31
	bpl	endShield
ootate
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
	pop	{pc}

endShield:
	mov	r0, #0
	pop	{pc}
	
	
HolyShield:
	push {lr}
@align 4
	ldr	r2, [adr+4]	;聖盾クラスアドレス
	ldr	r1, [r3, #4]
	ldrb	r1, [r1, #4]
loopHoly
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	unitHoly
	cmp	r0, r1
	beq	Holy
	add	r2, #1
	b	loopHoly
;ユニットチェック
unitHoly
	ldr	r1, [r3]
	add	r1, #0x31
	ldrb	r0, [r1]
	cmp r0, #6
	bne	endHoly
Holy
	mov	r0, #0x50
	ldrb	r0, [r7, r0]	;物理判定
	cmp	r0, #7
	beq	ouiHoly
	cmp	r0, #6
	beq	ouiHoly
	cmp	r0, #5
	beq	ouiHoly
	b endHoly
ouiHoly:
	ldrb	r0, [r3, #21]	;技
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	endHoly
	ldrh	r0, [r4, #4]
	lsr	r0, r0, #1
	strh	r0, [r4, #4]
	mov	r0, #1
	pop	{pc}

endHoly:
	mov	r0, #0
	pop	{pc}
	
	
Pray:
	push {lr}
	mov	r3, r8
	ldrb	r1, [r3, #19]
	cmp	r1, #1
	beq	endPray
;一撃で死ぬか
	ldrh	r0, [r4, #4]
	cmp	r0, r1
	blt	endPray
;ダメージが幸運を上回るか
;	ldrb	r1, [r3, #25]
;	cmp	r0, r1
;	bgt	endPray
	
	ldr	r0, [r3]
	ldrh	r0, [r0, #0x26]
	ldrh	r1, [r3, #0x3A]
	orr r0, r1
	lsl	r0, r0, #30
	bpl	endPray
	ldrb	r0, [r3, #25]	;幸運
	lsl	r1, r0, #1
	add	r0, r0, r1
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	endPray
	mov	r0, r8
	ldrb	r0, [r0, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
	mov	r0, #1
	pop	{pc}
endPray:
	mov	r0, #0
	pop	{pc}


Oracle:
	push	{lr}
	
@align 4
	ldr	r2, [adr+8]	;神盾クラスアドレス
	ldr	r1, [r3, #4]
	ldrb	r1, [r1, #4]
loopOracle
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	endOracle
	cmp	r0, r1
	beq	nihil_check
	add	r2, #1
	b	loopOracle
nihil_check:
	ldr	r1, [r7]
	ldr	r0, [r7, #4]
	ldr	r1, [r1, #40]
	ldr	r0, [r0, #40]
	orr	r0, r1
	lsl	r0, r0, #8
	bmi	Nihil
	ldr	r1, [r7]
	ldrh	r1, [r1, #0x26]
	ldrh	r0, [r7, #0x3A]
	orr	r0, r1
	lsl r0, r0, #29	;見切りの書
	bmi	Nihil
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
endOracle:
	pop	{pc}

	
random:
	ldr	r2, =$0802a490
	mov	pc, r2
@ltorg
adr: