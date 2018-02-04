;
;ジャンプ用
;70A26 > 87 46
;70a48 > XX XX XX 08
@thumb
	ldr	r1, =$08059EF5
	ldr	r2, [sp, #24]
	@align 4
	ldr r0, [adr]
	cmp	r2, r1
	beq	kantu
	@align 4
	ldr r0, [adr+4]
kantu
	mov	r1, #128
	ldr	r2, =$08070a28
	mov	pc, r2
@ltorg
adr: