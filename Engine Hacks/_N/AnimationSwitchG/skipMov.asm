@thumb
;@org $0007b90a
	
	lsl r1, r1, #31
	bmi skip
	ldrh	r1, [r0, #12]
	lsl r1, r1, #28
	bpl jump
skip:
	@dcw $2080
	@dcw $E015
	nop
	nop
jump:


