@thumb
;@org	$0801743c
	mov	r0, r13
	ldr	r2, =$03007D6C
	cmp	r0, r2
	beq	end
	ldr	r0, [r0, #4]
	ldr	r2, =$0802A833
	cmp	r0, r2
	beq	five
	mov	r0, #0x1
	lsl	r0, r0, #16
	cmp	r6, r0
	bgt	six
	cmp	r5, r0
	blt	zero
five
	ldr	r0, [r5, #4]
	b	kit
six
	ldr	r0, [r6, #4]
	b	kit
zero
	ldr	r0, =$03004df0
	ldr	r0, [r0]
	cmp	r0, #0
	beq	end
	ldr	r0, [r0, #4]
kit
	ldrb	r0, [r0, #4]
	cmp	r0, #0x1B
	beq	sagi
	cmp	r0, #0x1C
	bne	end
sagi
	lsl	r0, r1, #24
	lsr	r0, r0, #24
	cmp	r0, #0x22
	bne	end
	add	r1, #1
end
	mov	r0, #15
	and	r0, r1
	bx	lr