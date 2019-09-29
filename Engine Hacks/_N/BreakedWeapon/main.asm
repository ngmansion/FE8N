.thumb
	
	lsl r1, r0, #28
	bmi nonBreak
	ldr r1, adr+4
	add r2, r2, r1
	cmp	r2, #255
	bgt nonBreak
check:
	mov r1, #5	@ñ‚Ü‚½‚Í•¨—
	and r0, r1
	beq adr+8
nonBreak:
	lsl	r0, r2, #16
	lsr	r0, r0, #16
	.short 0xE004
adr:

