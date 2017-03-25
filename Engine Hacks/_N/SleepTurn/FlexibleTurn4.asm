@thumb
;@org	$08017680 > 00 4A 97 46 XX XX XX XX
;クラス性能に経験値ゼロがついていた場合、状態異常無効
	ldr	r3, [r0, #4]
	ldr	r3, [r3, #40]
	lsl	r2, r3, #7
	bpl	Normal
	bx	lr
Normal:
	ldr	r2, [r0]
	ldr	r2, [r2, #40]
	orr	r2, r3
	ldrb	r3, [r0, #11]	;所属ID
	add	r0, #48
	cmp	r1, #0
	beq	end
	lsl	r2, r2, #16
	bpl	noone
	mov	r2, #0xF
	and	r1, r2
	add	r1, #0x10	;敵将は1ターン
	b	end
noone
	mov	r2, #0xF0
	and	r2, r1
	bne	end	;ターン指定があるならジャンプ
	add	r1, #0x30	;3ターン
	lsr	r3, r3, #6
	lsl	r3, r3, #30
	beq	end
	add	r1, #0x20	;自軍以外は2ターン追加
end
	strb	r1, [r0]
	bx	lr