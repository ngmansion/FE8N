.thumb
	
	lsl r1, r0, #28
	bmi TRUE	@回数無限
	lsl r1, r0, #21
	bmi TRUE	@竜石
	mov r1, #0x6	@魔法または杖
	and r0, r1
	bne TRUE
FALSE:
	mov r0, #0
	b RETURN
TRUE:
	mov r0, #1
RETURN:
	bx lr
	
	
	