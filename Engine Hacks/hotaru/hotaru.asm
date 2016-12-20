@thumb
	
	ldr	r0, =$08603B18
	mov	r1, r8
	lsl	r1, r1, #20
	lsr	r1, r1, #29
	cmp	r1, #2
	beq	nonbreak
	mov	r0, r15
	add	r0, #8
	nop
nonbreak
	mov	r1, #3
	ldr	r2, =$08070b74
	mov	pc, r2
@INCBIN break.bin
@ltorg