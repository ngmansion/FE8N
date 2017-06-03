@thumb
;;@org	$08E48BB0
	
	mov	r0, #72
	ldrh	r0, [r2, r0]
		bl	WEAPON
	cmp	r0, #7
	bgt	end
	add	r0, #40
	ldrb	r0, [r2, r0]
	cmp	r0, #250
	bls	end
;ヴァルター様専用
	ldr	r0, [r2]
	add r0, #0x31
	ldrb	r0, [r0]
	cmp r0, #2
	beq	random
	
	ldr	r0, [r2, #4]
	ldrb	r0, [r0, #4]
@align 4
	ldr	r3, [adr]
loop
	ldrb	r1, [r3]
	cmp	r1, #0
	beq	end
	cmp	r0, r1
	beq	random
	add	r3, #1
	b	loop
	
random
	ldrb	r0, [r2, #0x15]	;;月光発動率

	mov	r1, #0
	ldr	r3, =$0802a490 ;;r0=確率, r1=#0 乱数
	mov	lr, r3
	@dcw	$F800
	cmp	r0, #1
	bne	end
	
	ldr	r3, [r5, #0]
	ldr	r2, [r3, #0]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	orr	r1, r4
	ldr	r0, =0xFFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]
	
	pop	{r4, r5}
	asr	r4, r4, #1
	pop	{r0}
	bx	r0
	
end
	ldr	r3, =$0802b24a
	mov	pc, r3
WEAPON
	ldr	r3, =$080172f0
	mov	pc, r3
@ltorg
adr:

