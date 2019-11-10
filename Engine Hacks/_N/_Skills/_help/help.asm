.thumb
	mov	r1, #0
	b merge
	mov	r1, #2
	b merge
	mov	r1, #4
	b merge
	mov	r1, #6
	b merge
	mov	r1, #8
	b merge
	mov	r1, #10
	b merge
	mov	r1, #12
	b merge
	mov	r1, #14
merge:
	add	r0, #76
	ldr r2, =0x02003B00
	ldrh	r1, [r2, r1]
	cmp	r1, #0
	beq	end
	strh	r1, [r0]
end:
	bx	lr
