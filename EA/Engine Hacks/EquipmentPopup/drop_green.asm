@thumb
;@org	$0808eae8
;所属チェック
	ldr	r2, [sp, #0]
	ldrb	r1, [r2, #11]
	lsl	r1, r1, #24
	lsr	r1, r1, #31
	beq	not
;アイテムドロップ
	ldrb	r1, [r2, #13]
	lsl	r1, r1, #27
	bpl	not
	mov	r2, #4
	b	end
not
	mov	r2, #5
end	
ldr	r1, =$08003d98
mov	lr, r1
	mov	r1, r6
@dcw	$F800
	ldr	r0, =$0808eaf0
	mov	pc, r0
	
;	ldrh	r1, [r2, #32]
;	cmp	r1, #0
;	beq	not		;;アイテムの持ちチェック
;	mov	r2, #0
;	b	end