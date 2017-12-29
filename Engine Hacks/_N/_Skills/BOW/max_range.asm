@thumb
;@org	$0801743c
	mov		r0, r13
	ldr		r2, =$03007D6C
	cmp		r0, r2
	beq		end
	ldr		r0, [r0, #4]
	ldr		r2, =$0802A833	;(スタック確認)
	cmp		r0, r2
	beq		five
	mov		r0, #0x1
	lsl		r0, r0, #16
	cmp		r6, r0
	bgt		six
	cmp		r5, r0
	blt		zero
five:
	mov		r0, r5
	b		kit
six:
	mov		r0, r6
	b		kit
zero:
	ldr		r0, =$03004DF0
	ldr		r0, [r0]
kit:
	cmp		r0, #0
	beq		end		;error

;;;;;;;▽撃破捕獲▽
	push	{r3}
	ldr		r3, [r0, #12]	;捕獲
	mov		r2, #0x80
	lsl		r2, r2, #0x17
	tst		r3, r2
	pop		{r3}
	bne		one
;;;;;;;△撃破捕獲△

	ldr		r0, [r0, #4]
	ldrb	r0, [r0, #4]
	cmp		r0, #0x1B	;スナイパー
	beq		sagi
	cmp		r0, #0x1C	;スナイパー
	bne		end
sagi:
	cmp		r1, #0x22
	bne		end
	add		r1, #1
	b	end
one:
	mov		r1, #0x11
	b		end
end:
	mov		r0, #0xF
	and		r0, r1
	bx		lr

	