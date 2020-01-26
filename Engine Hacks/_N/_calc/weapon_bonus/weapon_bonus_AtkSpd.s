SWORD = (0)
LANCE = (1)
AXE = (2)
BOW = (3)
STAFF = (4)
ANIMA = (5)
LIGHT = (6)
DARK = (7)

LEVEL_E = (1)
LEVEL_D = (2)
LEVEL_C = (3)
LEVEL_B = (4)
LEVEL_A = (5)
LEVEL_S = (6)

@0802acc8
.thumb
	push {lr}
	mov r0, #0x50
	ldrb r0, [r4, r0]

	add	r0, r4
	add	r0, #40
	ldrb	r0, [r0]
	bl Get_WpLv

	cmp r0, #LEVEL_S
	blt end
	
	ldrb r0, [r4, #20]
	push {r0}
	mov r0, #0xFF
	strb r0, [r4, #20]
	bl AtkSpdFunc
	pop {r0}
	strb r0, [r4, #20]	@back
	
end:
	pop	{pc}
	
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1
AtkSpdFunc:
	ldr r1, =0x0802aae4
	mov pc, r1
.align
.ltorg
addr:
	
