@thumb
	ldr	r5, =$02003BFC
	
	ldr	r0, [r5, #12]
	ldrb	r0, [r0, #26]
	
	ldr	r1, [r5, #12]
	mov	r3, #26
	ldsb	r3, [r1, r3]	;‘ÌŠi“Ç‚İ‚İ
	str	r0, [sp, #0]
	ldr	r0, [r1, #4]
	ldrb	r0, [r0, #25]	;‘ÌŠiãŒÀ“Ç‚İ‚İ
	lsl	r0, r0, #24
	asr	r0, r0, #24
	str	r0, [sp, #4]
	mov	r0, #7
	mov	r1, #5	;x²
	ldr	r2, =$08089354
	mov	lr, r2
	mov	r2, #3	;y²
	@dcw	$F800
	
	@dcw	$B014
	pop	{r4-r7, pc}