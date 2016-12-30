@thumb
@org	$080b4a18
	mov	r0, #48
	ldsb	r0, [r3, r0]
	cmp	r0, #0
	beq	$080b4a4c
	ldr	r1, [$080b4a48]
	ldrh	r2, [r3, #44]
	mov	r0, #50
	ldrb	r0, [r3, r0]
	lsl	r0, r0, #4
	add	r1, #4
	ldr	r0, [r0, r1]
	cmp	r2, r0
	blt	$080b4a4c
	mov	r0, r3
	mov	r1, #49
	ldrb	r1, [r1, r3]
	cmp	r1, #0x7F
	beq	reset
	bl	$080b3b44
	b	$080b4aa0
reset:
	bl	$080b4960
	b	$080b4aa0