@thumb
@org	$0802b2fc
	push	{lr}
	ldr	r0, [r1, #4]
	ldrb	r0, [r0, #4]
	cmp	r0, #0x66	;;クラス魔王は瞬殺不可
	beq	non
	ldr	r0, [adr1+4]
	ldrh	r0, [r0, #14]
	cmp	r0, #0
	beq	non
	mov	r1, #0
	bl	$0802a490 ;;r0=確率, r1=#0 乱数
	lsl	r0, r0, #24
	asr	r0, r0, #24
	cmp	r0, #1
	beq	goto
non
	mov	r0, #0
	b	end
goto
	mov	r0, #1
end
	pop	{pc}
adr1
@dcd	$0203a4d0