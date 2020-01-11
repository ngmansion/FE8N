PULSE_ID = (0x09)	@奥義の鼓動の状態異常
PULSE_RESET = (0x39)	@奥義の鼓動の状態異常

KORO_FLAG = (0xDC) @瞬殺目印
ORACLE_FLAG = (0xDD) @奥義目印
DEFENSE_FLAG = (0xDF) @防御目印
WAR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFE)	@フラグ

RETURN_ADR = 0x0802a4a6

@0802A490
.thumb
	lsl	r0, r0, #16
	lsr	r3, r0, #16
	lsl	r1, r1, #24
	asr	r2, r1, #24
	ldr r0, =0x0802a4b4
	ldr	r0, [r0]
	ldrh	r1, [r0, #0]
	mov	r0, #2
	and	r0, r1
	beq	start @独自処理
	mov	r0, r2
	bx	lr
start:
	mov r0, lr @戻りアドレス確認
@除外判定
	cmp r2, #0
	bne return @r2は謎。通常は0が入る筈。気味が悪いから0以外なら除外
	ldr r1, =0x0802b40B @必殺は対象外
	cmp r0, r1
	beq return
	ldr r1, =0x0802b607	@デビルアクスも対象外
	cmp r0, r1
	beq return
@除外判定終了
	push	{r3, r4, lr}
	mov	r3, sp
	ldr r2, =0x0802AFD1 @汎用
loop: @加攻撃者アドレス取得ループ
	ldr	r0, [r3]
	cmp	r0, r2
	beq	gotA @汎用
	add	r3, #4
	b	loop
return:
	push {lr}
	ldr	r0, =RETURN_ADR
	mov	pc, r0
	
gotA: @汎用
	sub r3, #4
	ldr r2, [r3] @加攻撃者アドレス取得
hokan:
	ldr r3, =0x0203a568 @被攻撃者アドレス補間
	cmp r2, r3
	bne check
	ldr r3, =0x0203a4e8 @被攻撃者アドレス補間
check:
@大盾チェック
	mov	r0, sp
	ldr	r0, [r0, #24]
	ldr	r1, =0x0802B3B9	@(元の)大盾は専用
	cmp	r0, r1
	beq	Reverse
@独自のディフェンスチェック
	mov r0, r10
	cmp r0, #DEFENSE_FLAG
	beq Reverse
	b nonTATE
Reverse:
	eor r3, r2
	eor r2, r3
	eor r3, r2
nonTATE:
@トライアングルチェック
	ldr r0, =0x0203a604
	ldr r0, [r0]
	ldr r0, [r0]
	mov r1, #128
	lsl r1, r1, #3
	and r0, r1
	beq nonTri
	mov r0, #0
	str r0, [sp] @r3
	b end
nonTri:
	mov r0, r10
	cmp r0, #KORO_FLAG
	bne notDeath	@瞬殺ではない
@■瞬殺独自判定
	ldr r0, [sp] @r3
	bl judgeDeath
	cmp r0, #1
	beq skipWar	@戦技の確定発動判定を飛ばす
	b FALSE

notDeath:

@■戦技判定
	bl judgeWar
	cmp r0, #1
	beq TRUE @発動率100%

@■ジェノサイド判定
	ldrb r0, [r3, #11]
	ldr r1, =0x0203a5e8 @ゲノ
	ldrb r1, [r1]
	cmp r0, r1
	beq FALSE		@相手がジェノサイド発動中
@■見切りチェック
	mov r0, r3
	mov r4, r2
		ldr r3, ADDRESS
		mov lr, r3
		.short 0xF800
	cmp r0, #1
	beq FALSE

	bl pulse_func	@■奥義の鼓動
	cmp r0, #1
	beq TRUE	@確定発動
@加算処理
	bl king_func	@■王の器チェック
	ldr r1, [sp]
	add r1, r0
	str r1, [sp]
	
	bl god_func	@■神の器チェック
	ldr r1, [sp]
	add r1, r0
	str r1, [sp]
	
	bl ace_func	@■勇将チェック
	ldr r1, [sp]
	add r1, r0
	str r1, [sp]
	
	b end

TRUE:
	mov r0, #100
	str r0, [sp]
	b end
FALSE:
	mov r0, #0
	str r0, [sp]
end:
	mov r2, #0
	pop {r3, r4}
	ldr r0, =RETURN_ADR
	mov pc, r0

judgeWar:
		push {r2, r3, lr}

		ldrb r0, [r2, #27]
		cmp r0, #0
		bne jumpWar
		ldr r0, [r2, #12]
		mov r1, #0x10
		and r0, r1
		cmp r0, r1
		beq falseWar @捕獲攻撃中なら終了
	jumpWar:
	
		mov r0, r10
		cmp r0, #ORACLE_FLAG
		bne falseWar	@奥義以外は除外

		mov r1, #WAR_ADR
		ldrb r0, [r2, r1]
		cmp r0, #0xFF
		bne falseWar

		mov r0, r2
		mov r1, #0
		bl hasSunder
		cmp r0, #0
		beq falseWar

		mov r0, #1   @発動率100%
		b endWar
	falseWar:
		mov r0, #0
	endWar:
		pop {r2, r3, pc}

ace_func:
		push {lr}
		mov r0, r4
			ldr r3, ADDRESS+8 @勇将
			mov lr, r3
			.short 0xF800
		cmp	r0, #0
		beq	falseAC

		ldrb	r0, [r4, #0x13]	@NOW
		ldrb	r1, [r4, #0x12]	@MAX
		lsl	r0, r0, #1
		cmp	r0, r1
		bgt	falseAC
		mov	r0, #50
		b endAC
	falseAC:
		mov r0, #0
	endAC:
		pop {pc}



god_func:
		push {lr}
		mov r0, r4
			ldr r3, ADDRESS+12 @神の器
			mov lr, r3
			.short 0xF800
		cmp r0, #0
		beq endGod
		mov r0, #40
	endGod:
		pop {pc}

king_func:
		push {lr}
		
		mov r0, r4
			ldr r3, ADDRESS+4 @王の器
			mov lr, r3
			.short 0xF800
		cmp r0, #0
		beq endKing
		mov r0, #20
	endKing:
		pop {pc}


pulse_func:
		push {lr}
		mov r0, #48
		ldrb r1, [r4, r0]
		cmp r1, #PULSE_ID
		bne falsePulse
	@独自の奥義チェック
		mov r0, r10
		cmp r0, #ORACLE_FLAG
		bne falsePulse
	@鼓動リセット
		mov r0, #48
		mov r1, #PULSE_RESET
		strb r1, [r4, r0] @状態異常治癒
	@状態異常治癒
		mov r0, #0xB
		ldrb r0, [r4, r0]
			ldr r1, =0x08019108	@部隊表IDから変換
			mov lr, r1
			.short 0xF800
		add r0, #48
		mov r1, #PULSE_RESET
		strb r1, [r0]
	truePulse:
		mov r0, #1
		b endPulse
	falsePulse:
		mov r0, #0
	endPulse:
		pop {pc}


judgeDeath:
@戦技チェック
	cmp r0, #0
	beq falseDeath	@0なら不発
	mov r1, #WAR_ADR
	ldrb r0, [r2, r1]
	
	mov r1, #WAR_FLAG
	and r0, r1
	cmp r0, r1
	bne falseDeath	@戦技ではないなら不発
	
	mov r0, #1
	b endDeath
falseDeath:
	mov r0, #0
endDeath:
	bx lr

hasSunder:
ldr r2, ADDRESS+16
mov pc, r2


@non
@	pop	{r3}
@	mov	r0, #0
@	bx	lr
@0x8反撃
@0x4追撃
.align
.ltorg
ADDRESS:

