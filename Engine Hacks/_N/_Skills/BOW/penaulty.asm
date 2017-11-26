@thumb
;@org	$0802abd4
	add		r1, #98
	mov		r3, r1
	add		r0, #72
	ldrh	r0, [r0]
	bl		range
	mov		r1, #15
	and		r0, r1
	ldr		r1, =$0203a4d0
	ldrb	r1, [r1, #2]
	cmp		r1, r0
	bgt		penalty
	
	mov		r0, #72
	ldrh	r0, [r2, r0]
	bl		range
	lsr		r0, r0, #4
	ldr		r1, =$0203a4d0
	ldrb	r1, [r1, #2]
	cmp		r1, r0
	blt		penalty
	
	mov		r0, r2
	mov		r1, #96
	ldrh	r2, [r2, r1]
	b		end
penalty
	mov		r0, r2
	mov		r1, #96
	ldrh	r2, [r2, r1]
	sub		r2 #30
end
	ldrh	r1, [r3]
	ldr		r3, =$0802abdc
	mov		pc, r3
	
range
	ldr		r1, =$08017448
	mov		pc, r1
	