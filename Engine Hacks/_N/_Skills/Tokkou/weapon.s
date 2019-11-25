.thumb
@org $0802aa7c
	
	cmp r0, #0
	beq non

	ldrh r0, [r7, #0]
	bl getItemText
	add r1, #0x22
	ldrb r0, [r1]
	bl exchange
	mul r4, r0
non:
	add r4, r4, r5
	ldr r0, =0x0802aab6
	mov pc, r0

exchange:
		cmp r0, #0
		beq three
		cmp r0, #3
		beq zero
		bx lr
	zero:
		mov r0, #0
		bx lr
	three:
		mov r0, #3
		bx lr
getItemText:
	ldr r1, =0x080172c0
	mov pc, r1
	
.align
.ltorg
adr:




