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
;;;;;;;;;;;;;大盾
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
	lsl	r1, r1, #31
	bpl	skill2
ootate
	ldrb	r0, [r3, #8]	;レベル
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	skill2
	ldrh	r0, [r4, #4]
	lsr	r0, r0, #1
	strh	r0, [r4, #4]
	b	effect
;;;;;;祈り
skill2
	mov	r3, r8
	ldrb	r1, [r3, #19]
	cmp	r1, #1
	beq	skill3
;一撃で死ぬか
	ldrh	r0, [r4, #4]
	cmp	r0, r1
	blt	skill3
;ダメージが幸運を上回るか
;	ldrb	r1, [r3, #25]
;	cmp	r0, r1
;	bgt	skill3
	
	ldr	r0, [r3]
	ldrh	r0, [r0, #0x26]
	lsl	r0, r0, #30
	bpl	skill3
	ldrb	r0, [r3, #25]	;幸運
	lsl	r1, r0, #1
	add	r0, r0, r1
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	skill3
	mov	r0, r8
	ldrb	r0, [r0, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
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
;;;;;;;;;;オラクル
skill3
	ldr	r1, [r3, #4]
	ldrb	r1, [r1, #4]
	cmp	r1, #0x00		;無指定
	beq	nihil_check
	cmp	r1, #0x66		;魔王
	beq	nihil_check
	b	end
nihil_check
	ldr	r1, [r7]
	ldr	r0, [r7, #4]
	ldr	r1, [r1, #40]
	ldr	r0, [r0, #40]
	orr	r0, r1
	lsl	r0, r0, #8
	bmi	Nihil
	ldrh	r0, [r4, #4]
	asr	r0, r0, #1
	strh	r0, [r4, #4]
	b	end
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
	b	end
zero
	mov	r0, #0
	strh	r0, [r4, #4]
end	
	ldr	r0, =$0802b49a
	mov	pc, r0
	
random
	ldr	r2, =$0802a490
	mov	pc, r2
@ltorg
adr: