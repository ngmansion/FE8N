ICON_POS = (0x0202F86)
@ 0801e684
.thumb

		ldr r0, [sp, #0x1C]
		ldr r1, =0x08022D5B
		cmp r0, r1
		bne END
		mov	r0, r4
		add r0, #0x0
		add r0, #0x20
		add r0, #0x80
		add r0, #0x80
		ldr r1, =0x100	@ベース
		mov	r2, #0x60
		lsl	r2, r2, #7
		bl	Icon
		
		mov	r0, r4
		add r0, #0x4
		add r0, #0x20
		add r0, #0x80
		add r0, #0x80
		ldr r1, =0x100	@ベース
		add r1, #114
		mov	r2, #0x80
		lsl	r2, r2, #7
		bl	Icon

		mov	r0, r4
		add r0, #0x8
		add r0, #0x20
		add r0, #0x80
		add r0, #0x80
		ldr r1, =0x100	@ベース
		add r1, #44
		mov	r2, #0x80
		lsl	r2, r2, #7
		bl	Icon
		
        ldr r0, ADDR
		mov r1, #1
        strb r1, [r0]
END:
	pop	{r3, r4, r5}
	mov	r8, r3
	mov	r9, r4
	mov	sl, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0

Icon:
	ldr	r3, =0x08003608
	mov	pc, r3
.align
.ltorg
ADDR:
