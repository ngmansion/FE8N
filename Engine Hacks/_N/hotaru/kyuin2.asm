;
;ジャンプ用
;70A26 > 87 46
;70a48 > XX XX XX 08
@thumb
	ldr	r1, =$08059EF5
	ldr	r2, [sp, #24]
	ldr	r0, =$000003D1
	cmp	r2, r1
	beq	kantu
	ldr	r0, =$00000100
kantu
	mov	r1, #128
	ldr	r2, =$08070a28
	mov	pc, r2