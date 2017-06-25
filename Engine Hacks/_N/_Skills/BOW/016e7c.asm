@thumb
;@org	$08016e7c
	push	{lr}
	mov	r1, #255
	and	r0, r1
	lsl	r1, r0, #3
	add	r1, r1, r0
	lsl	r1, r1, #2
	ldr r0, =$080162d8
	ldr r0, [r0]
	add	r1, r1, r0
	ldrb	r0, [r1, #25]
	
ldr	r1, [r6, #12]	;•ßŠl
mov		r3,#0x80
lsl		r3, r3,#0x17
tst	r1, r3
bne	one
	
	ldr	r1, [r6, #4]
	ldrb	r1, [r1, #4]
	cmp	r1, #0x1B
	beq	magi
	cmp	r1, #0x1C
	beq	magi
	cmp	r1, #0x1D
	beq	tikai
	cmp	r1, #0x1E
	beq	tikai
end
	ldr	r3, =$08016e8e
	mov	pc, r3
one:
	mov	r0, #0x11
	b	end
	
magi
	lsl	r1, r0, #28
	lsr	r1, r1, #28
	cmp	r1, #2
	bne	end
	add	r0, #1
	b	end
tikai
	lsr	r1, r0, #4
	cmp	r1, #2
	bne	end
	sub	r0, #0x10
	b	end