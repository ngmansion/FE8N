.thumb
	push {r0}
	mov r0, pc
	add r0, #(adr - calc_adr + 0x18)
calc_adr:
	ldr	r1, =0x06014000
		ldr r2, =0x08013008
		mov lr, r2
		.short 0xF800
	mov	r0, #195
	mov	r1, #147
	mov	r2, #9
	mov	r3, r7
	bl	Addon
	
	pop {r0}
	.short 0xbc30
	.short 0xbc02
	.short 0x4708
	
Addon:
	push	{r4, r5, r6, r7, lr}
	mov	r7, r9
	mov	r6, r8
	push	{r6, r7}
	mov	r8, r0
	mov	r9, r1
	mov	r5, r2
	mov	r6, r3
	mov	r7, pc
	add	r7, #(adr - calc_adr2)	@data.bin
calc_adr2:
	ldr	r0, =0x0808b762
	mov	pc, r0
.align
.ltorg
adr:
