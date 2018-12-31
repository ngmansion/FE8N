@thumb
	cmp	r6, #0
	beq	RETURN
	mov	r0, r6
	mov	r1, r4
		ldr	r2, =$0802c134
		mov	lr, r2
		@dcw $F800
	mov	r0, r7
	mov	r1, r6
	bl Fury
	mov	r0, r6
	mov	r1, r7
	bl Fury
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
RETURN:
	ldr	r0, =$0802bfec
	mov	pc, r0
	
	
Fury:
	push	{r4, lr}
	mov	r4, r0
	mov	r0, r1
		@align 4
		ldr	r1, [ADR+0]
		mov	lr, r1
		@dcw $F800
	cmp	r0, #0
	bne	false
	mov	r0, r4
		@align 4
		ldr	r1, [ADR+4]
		mov	lr, r1
		@dcw $F800
	cmp	r0, #0
	beq false
	ldrb r2, [r4, #18]
	asr r2, r2, #1
	ldrb r0, [r4, #19]
	sub	r0, #6
	cmp r0, r2
	bgt	jump
	mov	r0, r2
jump:
	strb	r0, [r4, #19]
	mov	r0, #1
	b	ret
false:
	mov	r0, #0
ret:
	pop	{r4, pc}

@align 4
@ltorg
ADR: