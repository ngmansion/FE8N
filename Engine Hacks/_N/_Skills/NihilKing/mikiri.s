.equ PULSE_ID, (0x09)	@奥義の鼓動の状態異常
.equ PULSE_RESET, (0x39)	@奥義の鼓動の状態異常

.equ KORO_FLAG, (0xDC) @瞬殺目印
.equ ORACLE_FLAG, (0xDD) @奥義目印
.equ DEFENSE_FLAG, (0xDF) @防御目印
.equ WAR_ADR, (67)	@書き込み先(AI1カウンタ)
.equ WAR_FLAG, (0xFE)	@フラグ


.equ RETURN_ADR, 0x0802a4a6

@0x2A490
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
@■しゅんころ判定
	mov r0, r10
	cmp r0, #KORO_FLAG
	bne goneDeath	@瞬殺ではない
	ldr r0, [sp] @r3
	bl isDeath
	cmp r0, #1
	beq isMikiri	@ジェノサイド・戦技はスキップして次へ
	b FALSE

goneDeath:
@■ジェノサイド判定
	ldrb r0, [r3, #11]
	ldr r1, =0x0203a5e8 @ゲノ
	ldrb r1, [r1]
	cmp r0, r1
	bne goneGeno
	mov r0, #0
	str r0, [sp] @r3
	b end
nonGeno:
@スキル100%効果
	ldrb r0, [r2, #11]
	cmp r0, r1
	bne goneGeno
	mov r0, #100
	str r0, [sp] @r3
	b end

goneGeno:
@■戦技判定
	mov r1, #WAR_ADR
	ldrb r0, [r2, r1]
	cmp r0, #0xFF
	b goneWarSkill

@発動率100%
	mov r0, #100
	str r0, [sp] @r3
	b end
goneWarSkill:
isMikiri:
@■見切りチェック
	mov r0, r3
	mov r4, r2
		ldr r3, ADDRESS
		mov lr, r3
		.short 0xF800
	cmp r0, #0
	beq pulse
	b FALSE

pulse:	@■奥義の鼓動
	mov r0, #48
	ldrb r1, [r4, r0]
	cmp r1, #PULSE_ID
	bne toking
@独自の奥義チェック
	mov r0, r10
	cmp r0, #ORACLE_FLAG
	bne toking
@鼓動リセット
	mov r0, #48
	mov r1, #PULSE_RESET
	strb r1, [r4, r0] @状態異常治癒
	mov r0, #100
	str r0, [sp] @r3
@状態異常治癒
	mov r0, #0xB
	ldrb r0, [r4, r0]
		ldr r1, =0x08019108	@部隊表IDから変換
		mov lr, r1
		.short 0xF800
	add r0, #48
	mov r1, #PULSE_RESET
	strb r1, [r0]
	b end
	
toking: @■王の器チェック
	mov r0, r4
		ldr r3, ADDRESS+4 @王の器
		mov lr, r3
		.short 0xF800
	cmp r0, #0
	beq togod
	ldr r0, [sp] @r3
	add r0, #20
	str r0, [sp] @r3
	
togod: @■神の器チェック
	mov r0, r4
		ldr r3, ADDRESS+12 @神の器
		mov lr, r3
		.short 0xF800
	cmp r0, #0
	beq toace
	ldr r0, [sp] @r3
	add r0, #40
	str r0, [sp] @r3
	
toace: @■勇将チェック
	mov r0, r4
		ldr r3, ADDRESS+8 @勇将
		mov lr, r3
		.short 0xF800
	cmp	r0, #0
	beq	end
gotAC:
	ldrb	r0, [r4, #0x13]	@NOW
	ldrb	r1, [r4, #0x12]	@MAX
	lsl	r0, r0, #1
	cmp	r0, r1
	bgt	end
	ldr	r0, [sp] @r3
	add	r0, #50
	str	r0, [sp] @r3
	b end
FALSE:
	mov r0, #0
	str r0, [sp]
end:
	mov r2, #0
	pop {r3, r4}
	ldr r0, =RETURN_ADR
	mov pc, r0
	
isDeath:
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
	
@non
@	pop	{r3}
@	mov	r0, #0
@	bx	lr
@0x8反撃
@0x4追撃

.ltorg
ADDRESS:

