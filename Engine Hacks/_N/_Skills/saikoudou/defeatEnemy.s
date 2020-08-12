RETURN_ADR = (0x0802b810)
RETURN2_ADR = (0x0802b812)



@ORG 0x02b808
.thumb
	ldr r0, =0x0203a4d0
	ldrh r1, [r0, #0]
	mov r0, #2
	and r0, r1
	cmp r0, #0
	bne RETURN	@戦闘予測時はスキップ
	
	ldr r0, =0x0203a568	@DEF側
	ldrb r0, [r0, #0xB]
		ldr r1, =0x08019108
		mov lr, r1
		.short 0xF800
	cmp r0, #0
	beq RETURN	@壁
	
	bl defeat_flag
	bl Alina_back
	cmp r0, #1
	beq UNDEAD
	
RETURN:
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	ldr r0, =RETURN_ADR
	mov pc, r0
	
UNDEAD:
	ldr	r3, [r4, #0]
	ldr	r1, [r3, #0]
	lsl	r1, r1, #8
	lsr	r1, r1, #27
	mov r0, #0
	ldr r2, =RETURN2_ADR
	mov pc, r2

Alina_back:
@闘技場は死なない
	ldr	r0, =0x0203a4d0
	ldrh r0, [r0]
	mov r1, #0x20
	and r0, r1
	beq falseAlina	@闘技場以外は終了
	
	ldrb r0, [r6, #11]	@部隊表ID
	lsl r0, r0, #24
	bmi falseAlina	@敵は無視
	
	mov r0, #1
	strb r0, [r6, #19]	@現在HP
	b endAlina
falseAlina:
	mov r0, #0
endAlina:
	bx lr

DEFEAT   = (0b10000000) @撃破フラグ
@DEFEATED = (0b01000000) @迅雷済みフラグ


defeat_flag:
@撃破していたらフラグをオン
@
		ldr r3, =0x03004df0
		ldr r3, [r3]
		ldrb r0, [r3, #11]
		ldrb r1, [r6, #11]
		cmp r0, r1
		beq endJinrai @やられている？
		
		lsl r0, r0, #24
		lsr r0, r0, #30
		bne endJinrai	@攻撃者が敵である
		
		mov r0, r3
		add r0, #69
		ldrb	r1, [r0]
	
		mov r2, #DEFEAT
		orr r2, r1
	
		strb	r2, [r0]
	
	endJinrai:
		bx lr
	
	
