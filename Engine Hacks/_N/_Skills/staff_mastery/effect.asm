@thumb
;@org	$00028f40
@align 4
	ldr		r0, [hasSkill]
	mov		lr, r0
	mov		r0, r5
	@dcw	$F800
	cmp		r0, #0
	bne		got
normal:
	ldr		r1, =$08025e21
	ldr		r0, =$08028f4a
	mov		pc, r0
got:
	ldr		r0, =$08028f48
	mov		pc, r0
@ltorg
hasSkill:
	

