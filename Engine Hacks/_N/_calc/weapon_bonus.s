.equ LEVEL_E, (1)
.equ LEVEL_D, (2)
.equ LEVEL_C, (3)
.equ LEVEL_B, (4)
.equ LEVEL_A, (5)
.equ LEVEL_S, (6)

@0002acd6
.thumb
	cmp r0, #0
	beq typeA
	cmp r0, #1
	beq typeB
	cmp r0, #2
	beq typeC
	cmp r0, #3
	beq typeB
	cmp r0, #5
	beq typeC
	cmp r0, #6
	beq typeA
	cmp r0, #7
	beq typeC
	b end
@剣・光
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
	mov r0, #5
	mov r1, #7
	mov r2, #5
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #6
	mov r1, #10
	mov r2, #6
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #7
	mov r1, #13
	mov r2, #7
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #8
	mov r1, #16
	mov r2, #8
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #10
	mov r1, #20
	mov r2, #10
	
	cmp r3, #LEVEL_S
	blt merge
	nop
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
	mov r0, #6
	mov r1, #6
	mov r2, #5
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #8
	mov r1, #8
	mov r2, #6
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #10
	mov r1, #10
	mov r2, #7
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #12
	mov r1, #12
	mov r2, #8
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #15
	mov r1, #15
	mov r2, #10
	
	cmp r3, #LEVEL_S
	blt merge
	nop
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
	mov r0, #7
	mov r1, #5
	mov r2, #5
	
	cmp r3, #LEVEL_D
	blt merge
	mov r0, #10
	mov r1, #6
	mov r2, #6
	
	cmp r3, #LEVEL_C
	blt merge
	mov r0, #13
	mov r1, #7
	mov r2, #7
	
	cmp r3, #LEVEL_B
	blt merge
	mov r0, #16
	mov r1, #8
	mov r2, #8
	
	cmp r3, #LEVEL_A
	blt merge
	mov r0, #20
	mov r1, #10
	mov r2, #10
	
	cmp r3, #LEVEL_S
	blt merge
	nop
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
	pop	{r4}
	pop	{r0}
	bx	r0
	
Get_WpLv:
	ldr r1, =0x08016b04
	mov pc, r1
	
	
