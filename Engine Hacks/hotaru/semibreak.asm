@thumb
;@org	$08070c30
	asr	r4, r0, #16
	mov	r1, r8
	lsl	r1, r1, #20
	lsr	r1, r1, #29
	cmp	r1, #2
	beq	nonbreak
	ldr	r0,	=$0203a4d2
	ldrb	r0, [r0]	;距離
	cmp	r0, #1
	beq	nonbreak
nashi
	ldr	r0, =$08070c66
	mov	pc, r0
nonbreak
	cmp	r4, #0
	blt	nashi
	ldr	r0, [r6, #76]
	ldr	r1, =$08070c38
	mov	pc, r1