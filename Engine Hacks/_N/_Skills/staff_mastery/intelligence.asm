@thumb
;@org	$0003fb40
	push	{r0, r1}
@align 4
	ldr		r0, [hasSkill]
	mov		lr, r0
	ldr		r0, =$03004df0
	ldr		r0, [r0]
	@dcw	$F800
	mov		r3, r0
	pop		{r0, r1}
	cmp		r3, #0
	bne		got
normal:
	@dcw	$b4e0
	@dcw	$b089
	@dcw	$9004
	@dcw	$4689
	ldr		r0, =$0803fb48
	mov		pc, r0
got:
	ldr		r3, =$0803fcb8
	mov		pc, r3
@ltorg
hasSkill:
	

