@thumb
	
	mov	r0, r10
	cmp	r0, #0xDE
	beq	teki
	ldr	r0, =$0802b372
	mov	pc, r0
teki:
	ldr	r0, =$0802b3a4
	mov	pc, r0