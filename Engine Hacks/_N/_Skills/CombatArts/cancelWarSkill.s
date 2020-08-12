WAR_OFFSET = (67)	@書き込み先(AI1カウンタ)

@.ORG 08022828
.thumb
push {lr}
bl main
ldr r0, =0x0802285c
ldr r0, [r0]
mov r1, #0
bl $000011d0
ldr r0, =0x08022832
mov pc, r0

$000011d0:
ldr r2, =0x080011d0
mov pc, r2


main:
	push {lr}

	bl reset_warskill

	bl arrow_reset_func

	pop {pc}
	
reset_warskill:
	ldr r1, =0x03004df0
	ldr r1, [r1]
	add r1, #WAR_OFFSET
	mov r0, #0
	strb r0, [r1]
	bx lr

arrow_reset_func:
    ldr r0, ADDR
	mov r1, #0
    str r1, [r0]
    str r1, [r0, #4]
    str r1, [r0, #8]
    str r1, [r0, #12]
	bx lr

.align
.ltorg
ADDR:

	