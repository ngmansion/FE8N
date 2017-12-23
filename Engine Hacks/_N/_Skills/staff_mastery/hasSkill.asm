@thumb
	mov	r3, r0
@align 4
	ldr	r2, [adr]
	ldr	r1, [r3, #4]
	ldrb	r1, [r1, #4]
loop:
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	unit
	cmp	r0, r1
	beq	oui
	add	r2, #1
	b	loop
;ユニットチェック
unit:
	ldr	r1, [r3]
	add	r1, #0x31
	ldrb	r0, [r1]
@align 4
	ldr	r1, [adr+4]
	lsl	r1, r1, #24
	lsr	r1, r1, #24
	cmp r0, r1
	bne	non
oui:
	mov	r0, #1
	bx	lr
non:
	mov	r0, #0
	bx	lr
@align 4
adr: