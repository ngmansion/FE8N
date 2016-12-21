@thumb
@org	$0804119c

	mov	r0, #3
	and	r0, r1
	cmp	r0, #1
	bne	$080411BC
	ldr	r1, [$080411B8]
	add	r1, #0x86
	strb	r3, [r1]
	mov	r4, r13
	ldrb	r4, [r4, #0x14]
	strb	r4, [r1, #1]
	mov	r0, #0
	b	$08041338
	