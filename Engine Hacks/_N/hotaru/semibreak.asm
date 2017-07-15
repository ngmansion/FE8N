@thumb
;@org	$08070c30
	asr	r4, r0, #16
	mov	r1, r8
	lsl	r1, r1, #20
	lsr	r1, r1, #29
	cmp	r1, #2
	beq	nonbreak
;
;ゼロ距離なら問題なし
;
	ldr	r0,	=$0203a4d2
	ldrb	r0, [r0]	;距離
	cmp	r0, #1
	beq	nonbreak
;
;同時発動してなければ問題なし
;
	mov	r0, r7
	ldr	r1, =$0805af10, mov	lr, r1, @dcw	$F800
	mov	r1, r0
	ldrh	r0, [r7, #14]
	sub	r0, #1
	lsl	r0, r0, #1
	add	r0, r0, r1
	ldr	r1, =$08059864, mov	lr, r1, @dcw $F800
	mov	r1, #128
	lsl	r1, r1, #1
	tst	r1, r0
	bne	nashi	;貫通発動ならジャンプ
	lsl	r1, r1, #2
	and	r1, r0
	beq	nonbreak	;必的不発ならジャンプ
	
nashi
	ldr	r0, =$08070c66
	mov	pc, r0
nonbreak
	cmp	r4, #0
	blt	nashi
	ldr	r0, [r6, #76]
	ldr	r1, =$08070c38
	mov	pc, r1