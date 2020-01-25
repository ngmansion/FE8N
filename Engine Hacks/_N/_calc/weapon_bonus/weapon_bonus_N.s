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
	cmp r0, #SWORD
	beq typeA
	cmp r0, #LANCE
	beq typeB
	cmp r0, #AXE
	beq typeC
	cmp r0, #BOW
	beq typeB
	cmp r0, #STAFF
	beq typeA
	cmp r0, #ANIMA
	beq typeC
	cmp r0, #LIGHT
	beq typeA
	cmp r0, #DARK
	beq typeC
	b end
typeA:
typeB:
typeC:
	add	r0, r4
	add	r0, #40
	ldrb	r0, [r0]
	bl Get_WpLv
	mov r3, r0
	mov r0, #0
	mov r1, #0
	mov r2, #0
	
	cmp r3, #LEVEL_S
	blt end
	
	mov r1, #90
	ldrh r0, [r4, r1]
	add r0, #1
	strh r0, [r4, r1] @攻撃
	mov r1, #96
	ldrh r0, [r4, r1]
	add r0, #10
	strh r0, [r4, r1] @命中
	
end:
	pop	{pc}
	
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1
	
	
