@thumb
	ldr	r1, =$03004df0
	ldr	r1, [r1]
	
	ldr	r0, [r1]
	ldr	r1, [r1, #4]

	ldr	r1, [r1, #40]
	ldr	r0, [r0, #40]
	orr	r1, r0
	
	mov	r0, #128
	lsl	r0, r0, #7
	and	r1, r0
	
	mov	r0, #0
	cmp	r1, #0
	beq	end
	mov	r0, #1
end	
	ldr	r1, =$030004B0
	str	r0, [r1, #48]
	mov	r0, #0
	bx lr
	
