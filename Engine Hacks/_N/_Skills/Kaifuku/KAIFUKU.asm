@thumb
;@org	$08019f28
	mov	r2, r0
	ldr	r1, [r5]
	ldrh	r1, [r1, #0x26]	;;ユニット0x1000
	lsl	r1, r1, #19
	bpl	classHeal
	mov	r3, #20
	b	end
classHeal:
@align 4
	ldr	r3, [adr]	;回復兵種アドレス
	ldr	r1, [r5, #4]
	ldrb	r1, [r1, #4]
loopHeal
	ldrb	r0, [r3]
	cmp	r0, #0
	beq	nonHeal
	cmp	r0, r1
	beq	gotHeal
	add	r3, #1
	b	loopHeal
gotHeal:
	mov	r3, #20
	b	end
nonHeal:
	mov	r3, #0
end:
	ldr	r1, =$08019f34
	ldr	r1, [r1]
	add	r0, r2, r1
	ldrb	r0, [r0]
	lsl	r0, r0, #24
	asr	r0, r0, #24
	add	r0, r0, r3
	bx	lr
@ltorg
adr: