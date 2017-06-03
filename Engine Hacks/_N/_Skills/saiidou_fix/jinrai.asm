@thumb
	
	cmp	r1, #3
	bgt	true
	cmp	r1, #1
	bgt	check
	cmp	r1, #1
	bge	false
true
	ldr	r0, =$0801CEDC
	mov	pc, r0
check
	ldr	r0, [r4]
	ldr	r0, [r0, #4]
	ldrb	r0, [r0, #4]
	cmp	r0, #0x23
	beq	true
	cmp	r0, #0x24
	beq	true
	cmp	r0, #0x02
	beq	true
	cmp	r0, #0x04
	beq	true
	
	ldr	r1, [r4]
	mov	r0, #29
	ldsb	r0, [r1, r0]	;ブーツ力
	ldr	r1, [r1, #4]		;クラスのアドレス
	ldrb	r1, [r1, #18]	;クラス基礎移動
	lsl	r1, r1, #24
	asr	r1, r1, #24
	add	r0, r0, r1
	ldrb	r1, [r2, #16]	;既に移動した分
	sub	r1, r0, r1
	cmp	r1, #2
	ble	jump
	sub	r0, #2
	strb	r0, [r2, #16]
jump
	ldr	r0, =$0801cef2
	mov	pc, r0
	
false
	ldr	r0, =$0801CEFC
	mov	pc, r0