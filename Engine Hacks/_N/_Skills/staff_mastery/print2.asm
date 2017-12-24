@thumb
;@org $0001704c
	push	{r4}
	mov		r4, r0
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
	ldrb	r0, [r4, #25]
	mov	r4, #15
	and	r4, r0
	cmp	r4, #0
	bne	jump
long:
	mov	r4, #99
jump:
	ldr		r0, =$08017058
	mov		pc, r0
@ltorg
hasSkill: