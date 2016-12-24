@thumb
;	書き換え
;	00017bdc > 70 47
;
;	0002aeec > 00 4A 97 46 XX XX XX 08(コレを貼るアドレス)
;
	push	{r4, r5, lr}
	mov	r4, r0
	mov	r5, r1
	ldr	r0, =$0203A568
			bl	routine1
	cmp	r0, #0
	beq	jump1
	ldr	r0, =$0203A4E8
	b	jump2
jump1
	ldr	r0, =$0203A568
jump2
	str	r0, [r5, #0]
			bl	routine2
	str	r0, [r4, #0]
	pop	{pc, r4, r5}
	
	
routine1
	push	{r4, lr}
;受け側チェック
	mov	r4, r0
	add	r4, #72
	ldrh	r2, [r4, #0]
	mov	r4, #0
	cmp	r2, r4
	beq	end100
	ldr	r2, [r0, #76]	;武器チェック
	lsl	r2, r2, #7
	bmi	jump100
	bl	routine3
	cmp	r2, #0
	beq	end100
jump100
	bl	routine2
;攻め側チェック
	bl	Nihil
	cmp	r2, #0
	bne	end100
	ldr	r2, [r0, #76]	;武器チェック
	lsl	r2, r2, #7
	bmi	end100
	bl	routine3
	cmp	r2, #0
	bne	end100
	ldr	r4, =$0203A4D0		;??????????
	ldrh	r0, [r4, #0]
	mov	r4, #1
	and	r4, r0
end100
	mov	r0, r4
	pop	{pc, r4}
	
	
routine2	
	ldr	r2, =$0203A568
	mov	r3, r0
	sub	r0, #128
	cmp	r3, r2
	beq	jump201
	add	r3, #128
	mov	r0, r3
jump201
	bx	lr
	
	
routine3
;ユニットチェック
	ldr	r1, [r0]
	ldrh	r1, [r1, #0x26]	;;ユニット0x80待ち伏せ
	lsl	r1, r1, #24
	bmi	got
;クラスチェック
@align 4
	ldr	r3, [adr]
	ldr	r1, [r0, #4]
	ldrb	r1, [r1, #4]	;;ID
classloop
	ldrb	r2, [r3]
	cmp	r2, #0
	beq	end
	cmp	r1, r2
	beq	got
	add	r3, #1
	b	classloop
got
	mov	r2, #1
	bx	lr
end
	mov	r2, #0
	bx	lr
	
	
;	見切りチェック
Nihil
	ldr	r1, [r0, #4]
	ldr	r2, [r0, #0]
	ldr	r1, [r1, #40]
	ldr	r2, [r2, #40]
	orr	r2, r1
	lsl	r2, r2, #8
	lsr	r2, r2, #31
	bx	lr
@ltorg
adr: