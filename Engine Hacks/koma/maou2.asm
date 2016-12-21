@thumb
@org	$08041398
	
	mov	r1, #3
	and	r0, r1
	cmp	r0, #1
	bne	$080413C4
	ldr	r2, [$080413BC]
	add	r2, #0x86
	ldr	r1, [$080413C0]
	strb	r0, [r2]
	ldr	r1, [r1]
	ldr	r0, [r1, #0x10]
	strb	r0, [r2, #1]
	ldrb	r1, [r1, #0x11]
	add	r0, r2, #2
	b	$080414EA