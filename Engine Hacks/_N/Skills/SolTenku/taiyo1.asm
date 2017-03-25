@thumb
;ヒット後にブレイク
	ldr	r0, [r5, #92]
bl	b5AF10
	mov	r1, #1
	sub	r0, r0, #1
	neg	r0, r0
	and	r0, r1
	ldr	r1, =$0203E14E
	cmp	r0, #0
	beq	number1
	lsl	r0, r0, #1
	add	r0, r0, r1
	ldrb	r0, [r0]
	lsl	r0, r0, #1
	add	r0, r0, #1
	lsl	r0, r0, #1
	b	number2
;だいたいこっちにくる(光る処理？？？)
number1
	add	r0, r0, r1
	ldrb	r0, [r0]
	lsl	r0, r0, #2
number2
	ldr	r1, =$0203AB20	;(勝手な太陽フラグ)
	add	r0, r0, r1
	ldrb	r1, [r0]
	cmp	r1, #1
	bne	number8
;回復する
	mov	r1, #0
	strb	r1, [r0]
	ldr	r1, [next+4]		;次の処理の先頭+1（HP上昇の処理か？）
	b	number9
;回復しない
number8
	mov	r1, #0
number9
	str	r1, [r5, #12]
	mov	r0, r5
	ldr	r1, =$080531F0
	mov	pc, r1
b5AF10
	ldr	r1, =$0805af10
	mov	pc, r1
@ltorg

next

