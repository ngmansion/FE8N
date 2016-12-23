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
	ldrh	r1, [r2, #4]
	lsl	r1, r1, #31
	bpl	delete	;押してなければ消す
	
	ldrh	r1, [r2, #8]
	lsl	r2, r1, #30
	bpl	maru
change
	ldr	r0, =$0801c99c
	mov	pc, r0
danger
	ldrh	r1, [r2, #4]
	lsl	r2, r1, #30
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