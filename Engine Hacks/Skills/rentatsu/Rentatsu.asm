@thumb
;@org	$080169a4 > 00 48 87 46 XX XX XX 08

	ldr	r1, =$0203a568
	cmp	r1, r4
	bne	nonchange
	ldr	r1, =$0203a4e8
nonchange
;見切りチェック
	ldrh	r0, [r1, #0x3A]
	lsl r0, r0, #29	;見切りの書
	bmi	NIHIL
	ldr	r0, [r1, #4]
	ldr	r1, [r1, #0]
	ldr	r0, [r0, #40]
	ldr	r1, [r1, #40]
	orr	r0, r1
	lsl	r0, r0, #8
	bmi	NIHIL
;練達個人
	ldr	r1, [r4]
	ldrh	r1, [r1, #0x26]
	ldrh	r0, [r4, #0x3A]
	orr r1, r0
	lsl	r1, r1, #28	;;ユニット0x8練達
	bmi	zero
;練達兵種
@align 4
	ldr	r5, [adr]
	ldr	r1, [r4, #4]
	ldrb	r0, [r1, #4]
loop
	ldrb	r1, [r5]
	cmp	r0, r1
	beq	zero
	add	r5, #1
	cmp	r1,	#0
	bne	loop
NIHIL
	mov	r0, #255
	and	r0, r3
	lsl	r1, r0, #3
	add	r1, r1, r0
	ldr	r5, =$080169ac
	mov	pc, r5
zero
	mov	r0, #0
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1
adr:
;memo
;R04=0203a4e8
;R05=0203a568