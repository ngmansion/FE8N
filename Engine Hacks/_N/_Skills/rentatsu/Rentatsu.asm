@thumb
;@org	$080169a4 > 00 48 87 46 XX XX XX 08

	mov r5, r3
	ldr	r0, =$0203a568
	cmp	r0, r4
	bne	nonchange
	ldr	r0, =$0203a4e8
nonchange
;見切りチェック
	@align 4
	ldr r1, [adr+4]
	mov lr, r1
	@dcw $F800
	cmp r0, #0
	bne NIHIL
;練達個人
	mov r0, r4
@align 4
	ldr	r1, [adr]
	mov lr, r1
	@dcw $F800
	
	cmp	r0, #0
	bne zero
NIHIL:
	ldr	r0, [r4, #4]
	ldrb	r2, [r0, #4]
	mov r3, r5
	
	mov	r0, #255
	and	r0, r3
	lsl	r1, r0, #3
	add	r1, r1, r0
@align 4
	ldr	r5, =$080169ac
	mov	pc, r5
zero
	mov	r0, #0
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
@ltorg
adr:
;memo
;R04=0203a4e8
;R05=0203a568