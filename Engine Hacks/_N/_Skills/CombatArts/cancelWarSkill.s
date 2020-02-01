STR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFF)	@フラグ
WAR_FLAG2 = (0xFE)	@フラグ

@.ORG 08022C60
.thumb
	
	ldr r1, =0x03004df0
	ldr r1, [r1]
	add r1, #STR_ADR
	ldrb r0, [r1]
	cmp r0, #WAR_FLAG
	beq vanish
	cmp r0, #WAR_FLAG2
	beq vanish
	b nonVanish
vanish:
	mov r0, #0
	strb r0, [r1]
nonVanish:
	push	{lr}
	bl	func_clear
	mov	r0, #0	
	pop	{r1}	
	bx	r1	
	
func_clear:
	ldr r0, =0x0801d730
	mov pc, r0

	