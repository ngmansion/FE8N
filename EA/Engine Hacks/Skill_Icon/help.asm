@thumb
	ldr	r1, [adr+4]
	add	r0, #76
	ldrh	r1, [r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
	bx	lr
	
	ldr	r1, [adr+4]
	add	r1, #2
	add	r0, #76
	ldrh	r1, [r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
	bx	lr
	
	ldr	r1, [adr+4]
	add	r1, #4
	add	r0, #76
	ldrh	r1, [r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
	bx	lr
	
	ldr	r1, [adr+4]
	add	r1, #6
	add	r0, #76
	ldrh	r1, [r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
	bx	lr
	
	ldr	r1, [adr+4]
	add	r1, #8
	add	r0, #76
	ldrh	r1, [r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
end
	bx	lr

adr
@dcd	$02003B00