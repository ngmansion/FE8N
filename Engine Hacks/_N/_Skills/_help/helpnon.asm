.thumb
	mov	r1, #0
	b	start
	mov	r1, #2
	b	start
	mov	r1, #4
	b	start
	mov	r1, #6
	b	start
	mov	r1, #8
	b	start
	mov	r1, #10
	b start
	mov	r1, #12
	b start
	mov	r1, #14
start:
	push	{r4, lr}
	mov	r4, r0
	ldr	r0, =0x02003B00
	ldrh	r0, [r1, r0]
	cmp	r0, #0
	bne	end
	ldr	r0, =0x0808aeb0
	mov	pc, r0
end:
	pop	{r4, pc}
