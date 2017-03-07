@thumb

	mov	r0, r2
	ldr	r1, [r0, #4]
	ldr	r2, [r0, #0]
	ldr	r1, [r1, #40]
	ldr	r2, [r2, #40]
	orr	r2, r1
	lsl	r2, r2, #8
	bmi	endwo
	ldr	r1, [r0]
	ldrh	r1, [r1, #0x26]
	ldrh	r0, [r0, #0x3A]
	orr	r0, r1
	lsl r0, r0, #29	;見切りの書
	bmi endwo
	
	ldr	r0, [r6]
	add r0, #0x31
	ldrb	r0, [r0]
	cmp r0, #5
	bne	endwo
	mov	r0, #0
	strh	r0, [r5]
endwo:
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
	
	