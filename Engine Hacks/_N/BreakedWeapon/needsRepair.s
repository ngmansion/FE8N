.thumb
    mov r1, r0
    mov r0, #0x23
    ldrb r0, [r0, r1]
    cmp r0, #1
    beq FALSE
    cmp r0, #2
    beq FALSE
    cmp r0, #3
    beq TRUE
default:
    ldr r0, [r1, #8]
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
	
	
	