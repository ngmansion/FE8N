@thumb
;0801c9e2 d132     	bne	$0001ca4a			;;‚±‚±‚ðÁ‚·‚Æí‚ÉñØ‚è‘Ö‚¦
;@org	$0801B5C0 > 00 48 87 46 B0 A6 E4 08
	
	ldr	r0, =$0202bcac
	add	r0, #62
	ldrb	r0, [r0]
	lsl	r0, r0, #30
	lsr	r0, r0, #30
	beq	CHECK
	cmp	r0, #1
	beq	DRW
	cmp	r0, #3
	beq	STDRW
;2
	ldr	r0, [r4, #28]
	lsl	r0, r0, #24
	bpl	non
STDRW
	ldr	r0, =$0801b2f4
	mov	lr, r0
	mov	r0, r4
	@dcw	$F800
non
	ldr	r0, =$0801b5ea
	mov	pc, r0
CHECK
	ldr	r0, [r4, #28]
	lsl	r0, r0, #24
	bpl	non
DRW
	ldr	r0, =$0801b5e4
	mov	pc, r0

