@thumb
;@org	$0809522e > C0 46 00 48 87 46 XX XX XX XX
	ldr	r3, [r3]
	ldrb	r0, [r3, #8]	;レベルロード
	ldr	r3, [r3, #4]
	ldr	r3, [r3, #40]
	lsl	r3, r3, #23
	bpl	nonup1
	add	r0, #20
nonup1
	ldr	r3, [r1, #4]
	ldrb	r1, [r1, #8]
	ldr	r3, [r3, #40]
	lsl	r3, r3, #23
	bpl	nonup2
	add	r1, #20
nonup2
	ldr	r3, [r2]
	cmp	r1, r0
	bge	jump
	ldr	r0, =$08095240
	mov	pc, r0
jump
	ldr	r0, =$08095248
	mov	pc, r0