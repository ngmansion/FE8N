
@thumb
@org	$0802c9d0
	push {lr}
	ldr r1, [(ADR+12)+4]
	ldrh r1, [r1, #12]	;最後に押したボタン格納
	lsl r1, r1, #28
	bpl non_off
	mov	r0, #1
	pop {pc}
non_off:
;スタートボタン以外
;
	ldr	r0, [(ADR+0)+4]	;$0202bcec
	add	r0, #66
	ldrb	r0, [r0]
	lsl	r0, r0, #29
	lsr	r0, r0, #30
	cmp	r0, #2
	bne	$0802ca2a		;個別以外は終了。オフ=1, 背景=3
;;個別の処理
	ldr	r2, [ADR+4]	;$0203a4e8
	mov	r0, #11
	ldsb	r0, [r2, r0]
	lsl	r0, r0, #24
	bmi	next
	ldr	r0, [(ADR+8)+4]	;$0203a568
	mov	r1, #0x0B
	ldsb	r0, [r0, r1]
	lsl	r0, r0, #24
	bmi	$0802ca24
	ldr	r0, [ADR+4]	;$0203a4e8
	b	$0802ca24
next
	ldr	r2, [ADR+8]	;$0203a568
	mov	r0, #11
	ldsb	r0, [r2, r0]
	lsl	r0, r0, #24
	bpl	$0802ca24
	mov	r0, #1
	b	$0802ca2a
@ltorg
ADR:
@dcd	$0202bcec
@dcd	$0203a4e8
@dcd	$0203a568
@dcd	$02024CC0
