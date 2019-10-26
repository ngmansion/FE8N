.thumb
@org	0x08E4B3C0
@@月光処理を独立

STR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFF)	@フラグ
WAR_FLAG2 = (0xFE)	@フラグ

NIHIL = (adr+28)	@見切りアドレス

	
	ldr	r2, [r6, #0]
	ldr	r0, [r2, #0]
	lsl	r0, r0, #13
	lsr	r0, r0, #13
	mov	r1, #128
	lsl	r1, r1, #9
	and	r0, r1
	beq	start	@月光なしで開始
	b	retrun
start:
	ldr	r0, [r7, #4]
	ldrb	r0, [r0, #4]
	
	ldr	r2, adr
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Dragon
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Dragon

	ldr	r2, adr+4
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Meido
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Meido

	ldr	r2, adr+8
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Revenge
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Revenge

	ldr	r2, adr+12
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Stan
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Stan

	ldr	r2, adr+16
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Stone
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Stone

	ldr	r2, adr+20
	ldrb	r1, [r2]
	cmp	r0, r1
	beq	Flower
	ldrb	r1, [r2, #1]
	cmp	r0, r1
	beq	Flower

    b retrun
	
Revenge:
	bl	Gecko
	ldrb r1, [r7, #18]
	ldrb r0, [r7, #19]
	sub r0, r1, r0
	asr	r0, r0, #1
	b	jump
	
Dragon:
	bl	Gecko
	mov	r0, r9
	asr	r0, r0, #1
	b	jump
	
Meido:
	cmp	r3, #0xAA
	beq	magicMeido
	bl	Gecko
	ldrb	r0, [r7, #26]
	b	jump
magicMeido:
	bl	Gecko
	ldr	r0, [r7]
	ldrb	r0, [r0, #19]
	ldr	r1, [r7, #4]
	ldrb	r1, [r1, #17]
	add	r0, r0, r1
	b	jump
	
Flower:
	bl	Gecko
	mov	r0, #0x50
	ldrb	r0, [r7, r0]	@物理判定
	cmp	r0, #7
	beq	addStrength
	cmp	r0, #6
	beq	addStrength
	cmp	r0, #5
	beq	addStrength
	ldrb r0, [r7, #0x1A]
	asr	r0, r0, #1
	b	jump
addStrength:
	ldrb r0, [r7, #0x14]
	asr	r0, r0, #1
	b	jump
	
Stan:	@戦技化
	mov r0, r7
	add r0, #STR_ADR
	ldrb r0, [r0]
	mov r1, #WAR_FLAG
	cmp r0, r1
	bne retrun

	mov	r2, r8
	ldr	r1, [r2, #4]
	ldrb	r0, [r1, #4]
	cmp	r0, #0x66	@@魔王に無効
	beq	retrun
	ldr	r2, [r2]
	ldr	r2, [r2, #40]
	ldr	r1, [r1, #40]
	orr	r1, r2
	lsl	r1, r1, #16
	bmi	retrun	@敵将に無効
	mov r0, r8
		ldr r1, NIHIL
		mov lr, r1
		.short 0xF800
	cmp r0, #1
	beq false @見切り持ち
	
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x24		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
	b	Effect
Stone:	@戦技化
	mov r0, r7
	add r0, #STR_ADR
	ldrb r0, [r0]
	mov r1, #WAR_FLAG
	cmp r0, r1
	bne retrun

	mov	r2, r8
	ldr	r1, [r2, #4]
	ldrb	r0, [r1, #4]
	cmp	r0, #0x66	@@魔王に無効
	beq	retrun
	ldr	r2, [r2]
	ldr	r2, [r2, #40]
	ldr	r1, [r1, #40]
	orr	r1, r2
	lsl	r1, r1, #16
	bmi	retrun		@敵将に無効
	mov r0, r8
		ldr r1, NIHIL
		mov lr, r1
		.short 0xF800
	cmp r0, #1
	beq false @見切り持ち
	
	mov	r1, r8
	add	r1, #111
	mov	r0, #0x2B		@@状態異常(2スリプ,3サイレス,4バサク,Bストン)
	strb	r0, [r1, #0]
Effect:	@状態異常特殊エフェクト
@@	ldr	r3, =0x0203A604
	ldr	r3, [r6]
	ldr	r2, [r3]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #64
	orr	r0, r1
	str	r0, [r3, #0]
noEffect:
	mov	r3, r8
	mov	r0, #48
	ldrb	r0, [r3, r0]
	mov	r1, #15
	and	r1, r0
	cmp	r1, #11
	beq	ouiStone
	cmp	r1, #13
	bne	retrun
ouiStone:
	ldr	r0, [r3, #12]
	mov	r1, #3
	neg	r1, r1
	and	r0, r1
	str	r0, [r3, #12]
	b	retrun
jump:
	add	r9, r0
retrun:
	mov	r1, r9
	sub	r0, r1, r4
	strh	r0, [r5, #4]
	ldr	r1, =0x0802b3f0
	mov	pc, r1
	
Gecko:
	push	{lr}
    mov r0, r7
        ldr r1, adr+24 @奥義判定
        mov lr, r1
        .short 0xF800
    cmp r0, #0
    beq false @奥義無し

	ldrb	r0, [r7, #0x15]	@奥義発動率
	mov	r1, #0
	ldr	r2, =0x0802a490 @r0=確率, r1=#0 乱数
	mov	lr, r2
	.short	0xF800
	
	cmp	r0, #1
	beq	ouiGecko
false:
	pop	{r0}
	b	retrun

ouiGecko:
	ldr	r3, [r6]
	ldr	r2, [r3]
	lsl	r1, r2, #13
	lsr	r1, r1, #13
	mov	r0, #128
	lsl	r0, r0, #9
	orr	r1, r0
	ldr	r0, =0xFFF80000
	and	r0, r2
	orr	r0, r1
	str	r0, [r3, #0]
	pop	{pc}
WEAPON:
	ldr	r3, =0x080172f0
	mov	pc, r3
.align
.ltorg
.align
adr:

