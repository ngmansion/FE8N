@thumb
	
	mov	r0, r9
	cmp	r0, #0x4C
	beq	teki
	ldr	r0, =$0802b372
	mov	pc, r0
teki:
	ldr	r0, =$0802b3a4
	mov	pc, r0