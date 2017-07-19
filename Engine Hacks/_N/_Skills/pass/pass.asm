@thumb
	cmp	r3, #0
	bne	Start
	strb	r3, [r6, #8]
	ldr	r0, =$0801a1ea
	mov	pc, r0
Start:
	mov	r0, r13
	ldr	r1, =$03007d18
	cmp	r0, r1
	beq	nonPass
	ldr	r0, [r4, #0]
	ldrh	r0, [r0, #38]
	lsl	r0, r0, #20
	bmi	ouiPass
	ldr	r0, [r4, #4]
	ldrb	r0, [r0, #4]
	cmp	r0, #23
	beq	ouiPass
	cmp	r0, #24
	beq	ouiPass
	cmp	r0, #0
	beq	ouiPass
	cmp	r0, #0
	beq	ouiPass
nonPass:
	mov	r0, #1
	b	Return
ouiPass:
	mov	r0, #0
Return:
	ldr	r1, =$0801a1e6
	mov	pc, r1
