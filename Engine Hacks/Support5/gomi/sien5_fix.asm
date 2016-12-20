@thumb
@org	$08028208
;現在の支援人数をチェックする
	bge	jump
loop
	mov	r0, r7
	mov	r1, r4
	bl	$080281d0
	cmp	r0, #0
	beq	nonke
	add	r6, #1
nonke
	add	r4, #1
	cmp	r4, r5
	blt	loop
jump
	mov	r0, r6
	pop	{pc, r4-r7}