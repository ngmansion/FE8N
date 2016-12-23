@thumb
@org	$0802b824
	
	mov	r0, #111
	ldrb	r0, [r5, r0]
	lsl	r0, r0, #28
	lsr	r0, r0, #28
	cmp	r0, #2
	beq	$0802b836
	cmp	r0, #11
	beq	$0802b836
	cmp	r0, #13
	bne	$0802b860
	ldr	r4, [$0802b870]
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	mov	r0, #2
	orr	r1, r0
	lsl	r1, r1, #3
	ldrb	r2, [r3, #2]
	mov	r0, #7
	and	r0, r2
	orr	r0, r1
	strb	r0, [r3, #2]
	ldr	r0, [r4, #0]
	add	r0, #4
	str	r0, [r4, #0]
	mov	r0, #1
	b	$0802b86a
	lsl	r0, r0, #0
	lsl	r0, r0, #0