@thumb
;@org	$080896ac


	ldr	r2, [r4, #12]
	ldr	r5, [r2, #0xC]
	lsl	r5, r5, #26
	lsr	r5, r5, #31	;黒星
	bne	black
	mov	r5, #2	;星の色
black:
	ldr	r2, [r2]
	mov	r1, #0x25
	ldrb	r2, [r2, r1]
	cmp	r2, #0
	beq	jump
backSTAR:
	ldr	r0	=$08009fa8
	mov	lr, r0
	
	cmp	r2, #5
	beq	five
	cmp	r2, #4
	beq	four
	cmp	r2, #3
	beq	three
	cmp	r2, #2
	beq	two
	cmp	r2, #1
	beq	one
miracleSTAR:
	ldr	r0, =$02003f06
	ldr	r1, =$08004a9c
	mov	lr, r1
	mov	r1, r5		;★数字の色
	cmp	r2, #10
	blt	Hitoketa
	add	r0, #0x2
Hitoketa:
	@dcw	$F800
	mov	r2, #1
	b	backSTAR:
	
	
one:
	mov	r0, $74	;文字
	b	nextSTAR
two:
	mov	r0, $73	;文字
	b	nextSTAR
three:
	mov	r0, $72	;文字
	b	nextSTAR
four:
	mov	r0, $71	;文字
	b	nextSTAR
five:
	mov	r0, $70	;文字
nextSTAR:
	@dcw	$F800
	
	ldr	r3	=$080043b8
	mov	lr, r3
	
	mov	r3, r0
	ldr	r0, =$02003CEC	;指揮（元救出）
	

	mov	r1, #0x18	;横位置なのは確か
	mov	r2, r5		;星の色
	@dcw	$F800
	b	end
	
jump:
	mov	r2, #255
	ldr	r0, =$02003f06
	ldr	r1, =$08004a9c
	mov	lr, r1
	mov	r1, r5		;数字の色
	@dcw	$F800
	b	end

end:
	ldr	r1, =$080896d8
	mov	pc, r1