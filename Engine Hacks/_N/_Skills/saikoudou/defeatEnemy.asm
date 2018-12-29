@define RETURN_ADR ($0802b810)

@define DEFEAT (0xFF)
@define DEFEATED (0xFE)
@define DEFEAT2 (0x7F)
@define DEFEATED2 (0x7E)

@thumb
	
	
	ldr r0, =$0203a4d0
	ldrh r1, [r0, #0]
	mov r0, #2
	and r0, r1
	cmp r0, #0
	bne RETURN
	
	ldr r3, =$03004df0
	ldr r3, [r3]
	ldrb r0, [r3, 11]
	ldrb r1, [r6, 11]
	cmp r0, r1
	beq RETURN ;やられている？
	
	lsl r0, r0, #25
	lsr r0, r0, #30
	bne RETURN	;攻撃者が敵である
	
	mov r2, DEFEAT
	mov r0, r3
    add r0, #69
    ldrb	r1, [r0]
    cmp r1, DEFEATED
    bne normal
    mov r2, DEFEAT2	;疾風迅雷用
normal:
    strb	r2, [r0]
;	b RETURN
	
RETURN:
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	ldr r0, =RETURN_ADR
	mov pc, r0
