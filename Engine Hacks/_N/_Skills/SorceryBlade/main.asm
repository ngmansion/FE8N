
@define MIKIRI_ADR (ADR+0)
@define MADOU_ADR (ADR+4)

@thumb
;@org 2aa02
	mov	r1, r4
	add	r1, #92
	strh	r0, [r1, #0]
	
	sub r5, #72
;スキル判定
;
;
	mov r0, r4
	bl MIKIRI
	cmp r0, #0
	bne RETURN
	
	mov r0, r5
	bl MADOU
	cmp r0, #0
	beq RETURN
	
	mov	r0, r4
	add	r0, #88
	ldrb	r0, [r0, #0]
	lsl	r0, r0, #24
	asr	r0, r0, #24
	mov	r2, #24
	ldsb	r2, [r4, r2]
	add r0, r0, r2
;魔法以外
	mov	r1, r4
	add	r1, #86
	ldrb	r1, [r1, #0]
	lsl	r1, r1, #24
	asr	r1, r1, #24
	mov	r2, #23
	ldsb	r2, [r4, r2]
	add r1, r1, r2
	
	cmp r0, r1
	bls jump
	mov r0, r1
jump:
	mov	r1, r4
	add	r1, #92
	strh	r0, [r1, #0]
RETURN:
	pop {r4, r5}
	pop {r0}
	bx r0
	
	
	
MIKIRI
@align 4
ldr r3, [MIKIRI_ADR]
mov pc, r3

MADOU:
@align 4
ldr r3, [MADOU_ADR]
mov pc, r3


	
@align 4
@ltorg
ADR:
