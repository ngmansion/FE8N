@thumb
	

	cmp	r3, #0
	bne	Start
	strb	r3, [r6, #8]
	ldr	r0, =$0801a1ea
	mov	pc, r0
;
;索敵マップ無効
;
Start:
	ldrb	r0, [r4, #11]
	lsr	r0, r0, #6
	bne	Jump
	ldr	r0, =$0202BCF9
	ldrb	r0, [r0]
	cmp	r0, #0
	bne	nonPass
;
;謎のバグ防止
;
Jump:
	mov	r0, r13
	ldr	r1, =$03007d18
	cmp	r0, r1
	beq	nonPass
;
;個人スキルチェック
;
	ldr	r0, [r4, #0]
	ldrh	r0, [r0, #38]
	lsl	r0, r0, #20
	bmi	ouiPass
;
;兵種スキルチェック
;
@align 4
	ldr	r2, [adr]	;すり抜け兵種ドレス
	ldr	r1, [r4, #4]
	ldrb	r1, [r1, #4]
loopPass:
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	nonPass
	cmp	r0, r1
	beq	ouiPass
	add	r2, #1
	b	loopPass
nonPass:
	mov	r0, #1
	b	Return
ouiPass:
	mov	r0, #0
Return:
	ldr	r1, =$0801a1e6
	mov	pc, r1
@ltorg
adr: