.thumb
	
	push {lr}

	mov r1, #255
	and r1, r0
	lsl	r2, r1, #3
	add	r2, r2, r1
	lsl	r2, r2, #2
	ldr	r1, adr
	add	r2, r2, r1
	ldr	r2, [r2, #8]
	
	lsr r1, r0, #8
	beq check

	lsl r1, r2, #28
	bmi nonBreak
	ldr r1, adr+4
	add r0, r0, r1
	cmp	r0, #255
	bgt nonBreak
check:
	mov r1, #5	@ñ‚Ü‚½‚Í•¨—
	and r1, r2
	beq adr+8
nonBreak:
	.short 0xE005
	lsl r0, r0, #0
adr:

