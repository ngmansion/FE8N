@thumb
;@org	$0801ca04 > 00 4A 97 46 XX XX XX XX

	mov	r2, r0
	ldr	r0, =$03004DF0
	ldr	r0, [r0]
	cmp	r0, #0
	beq	danger	;危険状態はジャンプ(何も無い)
	ldrb	r1, [r0, #11]	;所属ID
	lsr	r1, r1, #6
	beq	normal	;自軍はジャンプ
	
	ldrh	r1, [r2, #8]
	lsl	r1, r1, #30
	bmi	cancel
	lsl	r1, r1, #1
	bpl	next	;
;Aで矢印
	ldrb	r1, [r0 #28]
	mov	r2, #0x80
	orr	r1, r2
	strb	r1, [r0 #28]
	b	delete
cancel:
	ldrb	r1, [r0 #28]
	lsl	r1, r1, #25
	lsr	r1, r1, #25
	strb	r1, [r0 #28]
	b	delete
next
;チェンジ判定
	ldrh	r1, [r2, #8]
	lsl	r1, r1, #22	;L押しはチェンジ
	bpl	maru
change
	ldr	r0, =$0801c99c
	mov	pc, r0
danger
	ldrh	r1, [r2, #4]
	lsl	r1, r1, #30
	bmi	maru	;押しっぱなしは消さない
	b	delete
normal
	ldrh	r1, [r2, #8]
	lsl	r2, r1, #30
	bpl	maru	;B押してないならジャンプ
delete
	mov	r4, #2
	ldr	r0, [r0, #12]
	mov	r1, #64
	and	r0, r1
	beq	jump
	mov	r4, #0
jump
	ldr	r2, =$0801ca4a
	mov	pc, r2
maru
	ldr	r2, =$0801CA30
	mov	pc, r2