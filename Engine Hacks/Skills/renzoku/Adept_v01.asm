@thumb
;@org	$0802b004
	push	{r4, lr}
	mov	r4, #0
	ldr	r0, [r0, #76]
	mov	r1, #32
	and	r0, r1
	cmp	r0, #0
	beq	skill				;x勇者系以外はジャンプ
	ldr	r0, =$0203a604
	ldr	r3, [r0, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #16
	orr	r1, r0
	ldr	r0, =$FFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]
	mov	r4, #1				;;攻撃回数加算
	b end
;これ以下は新処理
skill
	ldr	r0, [r6]
	ldrh	r0, [r0, #0x26]	;ユニット
	lsl	r0, r0, #23
	bmi	got
;クラス
	ldr	r0, [r6, #4]
	ldrb	r0, [r0, #4]
	cmp	r0, #0x15			;ソドマス男
	blt	end
	cmp	r0, #0x16			;ソドマス女
	bgt	end
got
	mov	r0, #0x15
	ldsb	r0, [r6, r0]
	lsl	r0, r0, #16
	lsr	r0, r0, #16
	mov	r1, #0
ldr	r2, =$0802a490
mov lr, r2
@dcw $F800
	lsl	r0, r0, #24
	asr	r0, r0, #24
	cmp	r0, #1
	bne	end
	ldr	r0, =$0203a604
	ldr	r3, [r0, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #0x80
	lsl	r0, r0, #7
	orr	r1, r0
	ldr	r0, =$FFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]		;;必的発動の処理（エフェクトの為）
	mov	r4, #1				;;攻撃回数加算
end
	mov	r0, r4
	pop	{r4}
	pop	{pc}