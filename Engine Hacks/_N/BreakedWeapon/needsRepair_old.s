.thumb
	
	lsl r1, r0, #28
	bmi TRUE	@回数無限
	
FALSE:
	mov r0, #0
	b RETURN
TRUE:
	mov r0, #1
RETURN:
	bx lr
	
	
	