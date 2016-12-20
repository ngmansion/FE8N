@thumb
@org	$080282c8
	bne	$08028302
	mov	r0, #50
	add	r0, r0, r6
	ldrb	r7, [r5, r0]
	ldr	r4, [$0802830c]
	mov	r0, r5
	mov	r1, r6
	bl	$080281d0
	lsl	r0, r0, #2
	add	r0, r0, r4
	ldr	r0, [r0]
	cmp	r7, #0x50
	ble	check
	cmp	r7, #241
	bne	$08028310
non
	mov	r0, #0
	b	$0802831a
check
	mov	r0, r5
	bl	$080281f8	;;総支援回数(要改造)
	cmp	r0, #5		;最大支援人数-1？
	bgt	non
	mov	r0, r5
	mov	r1, r6
	bl	$08028188
	bl	$080281f8	;;総支援回数（要改造）
	cmp	r0, #5		;最大支援人数-1？
	bgt	non
	b	$08028310