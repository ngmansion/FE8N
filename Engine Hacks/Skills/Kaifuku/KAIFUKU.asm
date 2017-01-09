@thumb
;@org	$08019f28

	ldr	r1, =$08019f34
	ldr	r1, [r1]
	add	r0, r0, r1
	ldrb	r0, [r0, #0]
	lsl	r0, r0, #24
	asr	r0, r0, #24
;個人スキルチェック
	ldr	r1, [r5]
	ldrh	r1, [r1, #0x26]	;;ユニット0x1000
	lsl	r1, r1, #19
	bpl	non
	add	r0, #20
non:
	ldr	r1, [r5, #4]
	ldrb	r1, [r1, #4]
	cmp	r1, #0x66	;魔王
	@dcw $D100
	add	r0, #20
	cmp	r1, #0x29	;マージナイト
	@dcw $D100
	add	r0, #20
	cmp	r1, #0x2A	;マージナイト
	@dcw $D100
	add	r0, #20
	bx	lr