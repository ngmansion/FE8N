@thumb
@org	$0802c354
	push	{lr}
	ldr	r1, [r0]
	ldrh	r2, [r1, #0x26]
	lsl	r2, r2, #22
	bmi	$0802c36c
	b	$0802c38c