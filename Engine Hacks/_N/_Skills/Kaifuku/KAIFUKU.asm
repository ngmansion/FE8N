@thumb
;@org	$08019f28


;個人スキルチェック
	ldr	r1, [r5]
	ldrh	r1, [r1, #0x26]	;;ユニット0x1000
	lsl	r1, r1, #19
	bpl	classHeal
	mov	r2, #20
	b	end
classHeal:
@align 4
	ldr	r2, [adr]	;回復クラスアドレス
	ldr	r1, [r5, #4]
	ldrb	r1, [r1, #4]
loopHeal
	ldrb	r0, [r2]
	cmp	r0, #0
	beq	nonHeal
	cmp	r0, r1
	beq	gotHeal
	add	r2, #1
	b	loopHeal
botHeal:
	mov	r2, #20
	b	end
nonHeal:
	mov	r2, #20
end:
	ldr	r1, =$08019f34
	ldr	r1, [r1]
	add	r0, r0, r1
	ldrb	r0, [r0, #0]
	lsl	r0, r0, #24
	asr	r0, r0, #24
	add	r0, r0, r2
	bx	lr
@ltorg
adr: