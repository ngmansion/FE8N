@thumb
;@org	0008e75c

	push	{r4, r5, r6, r7, lr}
	mov	r7, r8
	push	{r7}
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
;文字
	ldr	r1, [r4, #64]
	mov	r0, r4
	mov	r2, #0
	ldr	r3, =$2160
	strh	r3, [r1, #0]
	add	r3, #1
	strh	r3, [r1, #2]
	strh	r2, [r1, #4]
	strh	r2, [r1, #6]
	add	r3, #1
	strh	r3, [r1, #8]
	strh	r2, [r1, #10]
	strh	r2, [r1, #12]
	mov	r0, #1
	ldr	r1, =$08001efc
	mov	lr, r1
	@dcw	$F800
	
	ldr	r0, =$0808e838
	mov	pc, r0

numbers:
	ldr	r1, =$08003868
	mov	pc, r1
	

	
