@thumb

@org $0801c740            ;replaces start button hook
	ldrh r1,[r2,#0x8]
	mov r0,#0xA               ;0x2 OR 0x8 = C i.e. Select OR Start
	and r0,r1
	beq $0801c7a0
	ldr r0, [next]
	mov	pc, r0
next
	