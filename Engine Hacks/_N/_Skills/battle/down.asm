.thumb
	cmp	r6, #0
	beq	RETURN
	mov	r0, r6
	mov	r1, r4
		ldr	r2, =0x0802c134
		mov	lr, r2
		.short 0xF800
@;表側
	mov	r0, r7
	mov	r1, r6
	bl Fury
	mov	r0, r7
	mov	r1, r6
	bl Adept
	mov	r0, r7
	mov	r1, r6
	bl Cancel
	
@;裏側
	mov	r0, r6
	mov	r1, r7
	bl Fury
	mov	r0, r6
	mov	r1, r7
	bl Adept
	mov	r0, r6
	mov	r1, r7
	bl Cancel
	
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
RETURN:
	ldr	r0, =0x0802bfec
	mov	pc, r0
	
Cancel:
	push	{r4, lr}
	mov	r4, r0
	mov	r0, r1
		ldr	r1, ADR+0
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	bne	false_cancel
	mov	r0, r4
		ldr	r1, ADR+12	@;キャンセル
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	beq false_cancel
	ldrb r2, [r4, #18] @;最大HP
	ldrb r0, [r4, #19] @;現在HP
	cmp r0, r2
	blt jump_cancel @;現在が最大よりも小さい場合
	sub	r0, #1
	strb	r0, [r4, #19]
jump_cancel:
	mov	r0, #1
	b	ret_cancel
false_cancel:
	mov	r0, #0
ret_cancel:
	pop	{r4, pc}
	
Adept:
	push	{r4, lr}
	mov	r4, r0
	mov	r0, r1
		ldr	r1, ADR+0
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	bne	false_adept
	mov	r0, r4
		ldr	r1, ADR+8	@;連続
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	beq false_adept
	ldrb r2, [r4, #18] @;最大HP
	ldrb r0, [r4, #19] @;現在HP
	cmp r0, r2
	blt jump_adept @;現在が最大よりも小さい場合
	sub	r0, #1
	strb	r0, [r4, #19]
jump_adept:
	mov	r0, #1
	b	ret_adept
false_adept:
	mov	r0, #0
ret_adept:
	pop	{r4, pc}
	
Fury:
	push	{r4, lr}
	mov	r4, r0
	mov	r0, r1
		ldr	r1, ADR+0
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	bne	false
	mov	r0, r4
		ldr	r1, ADR+4
		mov	lr, r1
		.short 0xF800
	cmp	r0, #0
	beq false
	ldrb r2, [r4, #18] @;最大HP
	ldrb r0, [r4, #19] @;現在HP
	cmp r0, r2
	blt jump @;現在が最大よりも小さい場合
	sub	r0, #1
	strb	r0, [r4, #19]
jump:
	mov	r0, #1
	b	ret
false:
	mov	r0, #0
ret:
	pop	{r4, pc}

.align
.ltorg
ADR:
