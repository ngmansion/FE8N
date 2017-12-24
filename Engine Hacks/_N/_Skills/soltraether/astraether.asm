@thumb
;@org	$0802b484
;武器レベルチェック
	mov	r0, #72
	ldrh	r0, [r7, r0]
ldr	r2, =$080172f0	;武器の種類ID
mov	lr r2
@dcw	$F800
	mov	r1, r0
	cmp	r1, #7
	bgt	end
	mov	r0, r7
	add	r0, #40
	add	r0, r0, r1
	ldrb	r0, [r0]
	cmp	r0, #250
	bls	end
;;;;流星チェック
;剣以外では発動しない
	cmp	r1, #0
	bne	skill2
;ユニットチェック
	ldr	r0, [r7]
	add	r0, #0x31
	ldrb	r0, [r0]
	cmp r0, #1
	beq	ouiAstra
;クラスチェック
	ldr	r0, [r7, #4]
	ldrb	r0, [r0, #4]
	
@align 4
	ldr	r3, [adr+8]
loopAstra:
	ldrb	r1, [r3]
	cmp	r1, #0
	beq	skill2
	cmp	r0, r1
	beq	ouiAstra
	add	r3, #1
	b	loopAstra
ouiAstra:
;ダメージがゼロなら発動しない
	mov	r0, #4
	ldsh	r0, [r5, r0]
	cmp	r0, #0
	ble	skill2
;近距離しか発動しない
	ldr	r0,	=$0203a4d2
	ldrb	r0, [r0]
	cmp	r0, #1
	bne	skill2
;必殺率がゼロなら発動しない
	ldrh	r0, [r5, #12]	;必殺
	cmp	r0, #0
	beq	skill2
;発動乱数
	ldrb	r0, [r7, #8]	;レベル
	mov	r1, #0
bl	random
	cmp	r0, #1
	bne	skill2
;必殺チェック
	mov	r0, #4
	ldsh	r2, [r5, r0]
	cmp	r2, #1
	beq	nobon
	asr	r0, r2, #1
	strh	r0, [r5, #4]
nobon
	ldr	r0, [r6]
	ldr	r0, [r0]
	lsl r0, r0, #31
	bpl	waranai
;必殺の場合
	mov	r1, r2
	mov	r2, #0
loop
	add	r2, #1
	sub	r1, #3
	bgt	loop
waranai
	asr	r0, r2, #1
	cmp	r0, #0
	bne	nononon
	mov	r0, #1
nononon
bl	RYUSEI
	b	effect
end:
	mov	r1, #4
	ldsh	r0, [r4, r1]
	cmp	r0, #127
	ble	nonmax
	mov	r0, #127
	strh	r0, [r4, #4]
nonmax
	ldr	r0, =$0802b48e
	mov	pc, r0
skill2
;必殺と重複しない
	ldr	r0, [r6, #0]
	ldr	r0, [r0, #0]
	lsl r0, r0, #31
	bmi	end
;HP吸収武器では発動しない
	mov	r0, #72
	ldrh	r0, [r7, r0]
ldr	r1,	=$080174cc
mov	lr, r1
@dcw	$F800
	cmp	r0, #2
	beq	end
;ユニットチェック
	ldr	r0, [r7]
	add	r0, #0x31
	ldrb	r0, [r0]
	cmp r0, #4
	beq	TENKU
;クラスチェック
	ldr	r0, [r7, #4]
	ldrb	r0, [r0, #4]
@align 4
	ldr	r3, [adr]
loop_tenku:
	ldrb	r1, [r3]
	cmp	r1, #0
	beq	next_judge
	cmp	r0, r1
	beq	TENKU
	add	r3, #1
	b	loop_tenku
next_judge:
@align 4
	ldr	r3, [adr+4]
loop_youkoh:
	ldrb	r1, [r3]
	cmp	r1, #0
	beq	final_judge
	cmp	r0, r1
	beq	YOUKOU
	add	r3, #1
	b	loop_youkoh
final_judge:
	b	end
TENKU:
	ldr	r0,	=$0203a4d2
	ldrb	r0, [r0]	;距離
	cmp	r0, #1
	bne	end
	mov	r0, r7
	add	r0, #72
	ldrh	r0, [r0, #0]
ldr	r3, =$08017448	;武器の射程
mov	lr,r3
@dcw	$F800
	ldrb	r1, [r1, #7]
	cmp	r1, #2	;;斧
	bne	jump
	cmp	r0, #0x12
	beq	end	;;手斧チェック
jump
	ldrb	r0, [r7, #8]	;レベル
	mov	r1, #0
		bl	random
	cmp	r0, #1
	bne	end
	mov	r0, #4
	ldsh	r1, [r5, r0]
	mov	r0, r8
	ldrb	r0, [r0, #23]
	asr	r0, r0, #1
	add	r0, r0, r1
	strh	r0, [r5, #4]
	b	effect
YOUKOU:
	ldrb	r0, [r7, #21]	;技
	mov	r1, #0
		bl	random
	cmp	r0, #1
	bne	end
	mov	r0, #4
	ldsh	r1, [r5, r0]
	mov	r0, r8
	ldrb	r0, [r0, #23]
	asr	r0, r0, #1
	add	r0, r0, r1
	strh	r0, [r5, #4]
	ldr	r3, [r6, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	b	gekko
	
effect
	ldr	r3, [r6, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #1
	orr	r1, r0
gekko
	ldr	r0, =$0007FFFF
	and	r1, r0
	ldr	r0, =$FFF80000
	and	r0, r2
	orr	r0, r1
	mov	r1, #128
	lsl	r1, r1, #9
	orr	r0, r1
	str	r0, [r3, #0]
	b	end
random
	ldr	r3, =$0802a490
	mov	pc, r3
	
RYUSEI
	push	{r6, r7, lr}
	mov	r6, r0
	mov	r7, #0
ryuloop
	ldrh	r0, [r5, #10]	;命中
	mov	r1, #1
ldr	r2, =$0802a4c0
mov	lr, r2
@dcw	$F800
	lsl	r0, r0, #24
	cmp	r0, #0
	beq	ryuend
	ldrh	r0, [r5, #12]	;必殺
ldr	r1, =$08000C78
mov	lr, r1
@dcw	$F800
	mov	r1, #4
	ldsh	r1, [r5, r1]
	cmp	r0, #0
	beq	noncritical
	lsl	r0, r6, #1 
	add	r1, r1, r0
noncritical
	add	r0, r6, r1 
	strh	r0, [r5, #4]
ryuend
	add	r7, #1
	cmp	r7, #4
	bne	ryuloop
	pop	{pc, r6, r7}
@ltorg
adr: