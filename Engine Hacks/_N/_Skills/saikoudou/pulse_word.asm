@thumb
@org $0808e694
	mov	r6, r1
	ldrb	r1, [r6]
	lsl	r1, r1, #28
	lsr	r1, r1, #26
	ldr r0, [$0808e6d8]
	cmp	r1, #36	;9
	beq $0808e720
	cmp r1, #52	;13
	bhi $0808e71c
	ldr r0, [pc, #8]
	ldr r0, [r0, r1]
	mov pc, r0

