@破壊された盾(回数255)を消す or 0にする
@エリクサーは、効果を発揮させて減らす

.thumb
@ 0802aec8

	ldr	r0, [sp, #0]
	bl HASON
	ldr	r0, [sp, #4]
	bl HASON
retrun:
	ldr	r0, =0x0203a604
	ldr	r3, [r0, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	
	lsr	r1, r1, #27
	mov	r0, #16
	orr	r1, r0
	lsl	r1, r1, #3
	
	ldr	r0, =0x0802aed0
	mov	pc, r0

BREAK_NUM = (0xFF)

HASON:
	push	{r4, r5, lr}
	mov	r5, r0
	
	mov	r4, #28
HASON_loop:
	add	r4, #2
	cmp	r4, #40
	beq	end
	
	ldrh	r0, [r5, r4]
	cmp	r0, #0
	beq	HASON_loop	@アイテムなし
	
		ldr	r1, =0x08017314
		mov	lr, r1
		.short 0xF800
	
	lsl	r1, r0, #28
	bmi	HASON_loop	@破損不可なら次へ
	lsl	r1, r0, #5
	bpl	notElixir	@お守り以外ならジャンプ
	lsl	r1, r0, #27
	bpl	notElixir	@売却可能ならジャンプ
	
@エリクサー処理
	ldrb	r0, [r5, #19]
	cmp r0, #1
	bgt notElixir	@HP1以外はジャンプ
	ldrb r0, [r5, #18]
	strb r0, [r5, #19]	@最大HPをストア
	
	ldrh r0, [r5, r4]
	bl $08016894	@破損処理
	cmp r0, #0x00
	bne notBreak
	ldrh r0, [r5, r4]
	mov r1, #BREAK_NUM	@消滅フラグ
	lsl r1, r1, #8
	orr r0, r1
notBreak:
	strh	r0, [r5, r4]
@エリクサー効果ここまで
notElixir:
	ldrh	r0, [r5, r4]
	lsr	r1, r0, #8
	cmp r1, #BREAK_NUM
	bne	HASON_loop	@回数0xFF以外はジャンプ
	bl CheckBreak
    cmp r0, #0
    beq jumpBreak
	ldrh r0, [r5, r4]
	lsl r0, r0, #24
	lsr r0, r0, #24
jumpBreak:
	strh	r0, [r5, r4]	@FF回数のアイテム消滅
	b	HASON_loop
end:
	pop	{r4, r5, pc}


CheckBreak:
    push {lr}
    ldr r1, =0x080172c0
    mov lr, r1
    .short 0xF800
    mov r0, r1
    bl NEED_BREAK_FUNC
    pop {pc}


$08016894:
ldr	r1, =0x08016894
mov	pc, r1


NEED_BREAK_FUNC:
ldr r1, addr
mov pc, r1

.align
.ltorg
addr:
