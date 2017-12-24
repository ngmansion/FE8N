@thumb
;@org $00017014
	push	{r4}
	mov		r6, r0
@align 4
	ldr		r0, [hasSkill]
	mov		lr, r0
	mov		r0, r5
	@dcw	$F800
	pop		{r1}
	cmp		r0, #0
	beq		non
	mov		r0, #255
	and		r0, r1
	cmp		r0, #0x4B
	beq		oui
	cmp		r0, #0x4C
	beq		oui
	cmp		r0, #0x4D
	beq		oui
	b		non
oui:
	b		long
non:
	ldrb	r0, [r6, #25]
	mov	r6, #15
	and	r6, r0
	cmp	r6, #0
	bne	jump
long:
	mov	r6, #99
jump:
	ldr		r0, =$08017072
	mov		pc, r0
@ltorg
hasSkill: