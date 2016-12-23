@thumb
	push	{lr}
	ldr	r1, [r0]
	ldrh	r2, [r1, #0x26]
	lsl	r2, r2, #22
	bmi	elite
	ldr	r1, [r0]
	ldr	r2, [r0, #4]
	ldr	r0, [r1, #0x28]
	ldr	r1, [r2, #0x28]
	ldr	r3, =$0802C35E
	mov	pc, r3
elite
	ldr	r3, =$0802C36C
	mov	pc, r3