@thumb
;@org	0008f2b4

	push	{r4, r5, r6, r7}
	mov	r4, r0
	mov	r5, r1

	ldrb	r0, [r5, #8]	;レベル
	bl	numbers
	ldr	r1, =$02028e44
	ldrb	r0, [r1, #6]
	sub	r0, #48
	mov	r2, r4
	add	r2, #81
	strb	r0, [r2, #0]
	ldrb	r0, [r1, #7]
	sub	r0, #48
	mov	r1, r4
	add	r1, #82
	strb	r0, [r1, #0]



	ldrb	r0, [r5, #9]	;経験値
	bl	numbers
	ldr	r1, =$02028e44
	ldrb	r0, [r1, #6]
	sub	r0, #48
	mov	r2, r4
	add	r2, #83
	strb	r0, [r2, #0]
	ldrb	r0, [r1, #7]
	sub	r0, #48
	mov	r1, r4
	add	r1, #84
	strb	r0, [r1, #0]
	pop	{r4, r5, r6, r7}
;元処理
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
	
numbers:
	ldr	r1, =$08003868
	mov	pc, r1
	
	
