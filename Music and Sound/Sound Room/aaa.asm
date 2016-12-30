@thumb
@org	$80b3be6
	add	r2, #1
	mov	r0, r9 
	add	r0, #0x36
	ldrb	r0, [r0]
	cmp	r2, r0
	blt	nasi
	mov	r2, #0
nasi
	cmp	r6, #0x80
	beq	$080b3bfc