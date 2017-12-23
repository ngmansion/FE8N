@thumb
;@org	$00028a38
@align 4
	ldr		r0, [hasSkill]
	mov		lr, r0
	mov		r0, r4
	@dcw	$F800
	cmp		r0, #0
	bne		got
normal:
	ldr		r1, =$08028a44
	ldr		r1, [r1]
	ldr		r0, =$08028a4a
	mov		pc, r0
got:
	ldr		r0, =$08028a48
	mov		pc, r0
@ltorg
hasSkill: