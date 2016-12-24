@thumb
	
	mov	r0, r10
	cmp	r0, #0xDE
	beq	teki
	ldr	r0, =$0802b372
	mov	pc, r0
teki
	mov	r6, r5
	ldr	r5, =$0203a4d0
	mov	r1, #6
	ldsh	r1, [r5, r1]
	mov	r9, r1
	
	mov	r0, #8
	ldsh	r4, [r5, r0]
	
	sub	r0, r1, r4
	strh	r0, [r5, #4]
	ldr	r0, =$0802b402
	mov	pc, r0