@thumb
;@org	$08E4B3C0
	;;叫喚がエフェクト表示に対応
	
	ldr	r2, [r6, #0]
	ldr	r0, [r2, #0]
	lsl	r0, r0, #13
	lsr	r0, r0, #13
	mov	r1, #128
	lsl	r1, r1, #9
	and	r0, r1
	beq	end
	ldr	r0, [r7, #4]
	ldrb	r0, [r0, #4]
	cmp	r0, #0
	beq	dragon
	cmp	r0, #0x40	;;ヲリア
	beq	meido
	cmp	r0, #0x43	;;バサカ
	beq	revenge
	cmp	r0, #0x21	;ドラマス
	beq	stan
	cmp	r0, #0x49
	beq	stone
gecko
	asr	r4, r4, #1
	b	end
stan
	mov	r2, r8
	ldr	r1, [r2, #4]
	ldrb	r0, [r1, #4]
	cmp	r0, #0x66	;;魔王に無効
	beq	end
	ldr	r2, [r2]
	ldr	r2, [r2, #40]
	ldr	r1, [r1, #40]
	orr	r1, r2
	lsl	r1, r1, #16
	bmi	end
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x24		;;状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b	effect
stone
	mov	r2, r8
	ldr	r1, [r2, #4]
	ldrb	r0, [r1, #4]
	cmp	r0, #0x66	;;魔王に無効
	beq	end
	ldr	r2, [r2]
	ldr	r2, [r2, #40]
	ldr	r1, [r1, #40]
	orr	r1, r2
	lsl	r1, r1, #16
	bmi	end
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x2B		;;状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
effect
	ldr	r3, =$0203A604
	ldr	r3, [r3]
	ldr	r2, [r3]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #64
	orr	r1, r0
	ldr	r0, =$FFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]
	
	mov	r3, r8
	mov	r0, #48
	ldrb	r0, [r3, r0]
	mov	r1, #15
	and	r1, r0
	cmp	r1, #11
	beq	ouistone
	cmp	r1, #13
	bne	end
ouistone
	ldr	r0, [r3, #12]
	mov	r1, #3
	neg	r1, r1
	and	r0, r1
	str	r0, [r3, #12]
	b	end
revenge
	ldrb r1, [r7, #18]
	ldrb r0, [r7, #19]
	sub r0, r1, r0
	asr	r0, r0, #1
	b	jump
dragon
	mov	r0, r9
	asr	r0, r0, #1
	b	jump
meido
	ldr	r0, [r7]
	ldrb	r0, [r0, #19]
	ldr	r1, [r7, #4]
	ldrb	r1, [r1, #17]
	add	r0, r0, r1
jump
	add	r9, r0
	
end
	mov	r1, r9
	sub	r0, r1, r4
	strh	r0, [r5, #4]
	ldr	r1, =$0802b3f0
	mov	pc, r1