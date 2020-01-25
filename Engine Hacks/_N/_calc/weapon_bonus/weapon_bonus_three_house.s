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
	push {r4, lr}

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
@剣・杖・光
typeA:
	add	r0, r4
	add	r0, #40
	ldrb	r0, [r0]
	bl Get_WpLv
	mov r3, r0
	mov r0, #0
	mov r1, #0
	mov r2, #0
	
	cmp r3, #LEVEL_E
	blt merge
	nop
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #5
	mov r1, #7
	mov r2, #5
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #6
	mov r1, #10
	mov r2, #6
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #7
	mov r1, #13
	mov r2, #7
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #8
	mov r1, #16
	mov r2, #8
	
	cmp r3, #LEVEL_S
	blt merge
	mov r0, #10
	mov r1, #20
	mov r2, #10
	b merge
	
	
@槍・弓
typeB:
	add	r0, r4
	add	r0, #40
	ldrb	r0, [r0]
	bl Get_WpLv
	mov r3, r0
	mov r0, #0
	mov r1, #0
	mov r2, #0
	
	cmp r3, #LEVEL_E
	blt merge
	nop
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #6
	mov r1, #6
	mov r2, #5
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #8
	mov r1, #8
	mov r2, #6
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #10
	mov r1, #10
	mov r2, #7
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #12
	mov r1, #12
	mov r2, #8
	
	cmp r3, #LEVEL_S
	blt merge
	mov r0, #15
	mov r1, #15
	mov r2, #10
	b merge
	
	
@斧・理・闇
typeC:
	add	r0, r4
	add	r0, #40
	ldrb	r0, [r0]
	bl Get_WpLv
	mov r3, r0
	mov r0, #0
	mov r1, #0
	mov r2, #0
	
	cmp r3, #LEVEL_E
	blt merge
	nop
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #7
	mov r1, #5
	mov r2, #5
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #10
	mov r1, #6
	mov r2, #6
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #13
	mov r1, #7
	mov r2, #7
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #16
	mov r1, #8
	mov r2, #8
	
	cmp r3, #LEVEL_S
	blt merge
	mov r0, #20
	mov r1, #10
	mov r2, #10
	b merge
merge:
	add r4, #96
	ldrh r3, [r4]
	add r3, r0
	strh r3, [r4]
	
	add r4, #2
	ldrh r3, [r4]
	add r3, r1
	strh r3, [r4]
	
	add r4, #6
	ldrh r3, [r4]
	add r3, r2
	strh r3, [r4]
end:
	pop	{r4, pc}
	
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1
	
	
