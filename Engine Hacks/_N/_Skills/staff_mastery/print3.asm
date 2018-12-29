@thumb
;@org $000170cc

	add r0, r0, r1
	ldrb r0, [r0, #25]
	mov r4, #15	
	and r4, r0	;;r4には最大射程
	
@align 4
		ldr r0, [hasSkill]
		mov lr, r0
		mov r0, r7
		@dcw $F800
	cmp r0, #0
	beq non
	
	ldrh r1, [r7, #30]
	mov r0, #255
	and r0, r1
	cmp r0, #0x4B
	beq oui
	cmp r0, #0x4C
	beq oui
	cmp r0, #0x4D
	beq oui
	b non
oui:
	mov r4, #0
non:
	ldr r0, =$080170d4
	mov pc, r0
@ltorg
hasSkill: