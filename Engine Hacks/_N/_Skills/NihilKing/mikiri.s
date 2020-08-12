WAR_OFFSET = (67)	@書き込み先(AI1カウンタ)
ATTACK_FLG_OFFSET = (69)	@書き込み先(AI2カウンタ)
FIRST_ATTACKED_FLAG = (0b00010000)
RETURN_ADR = 0x0802a4a6

@ 0802A490
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
	beq	check @独自処理
	mov	r0, r2
	bx	lr
check:
	mov r0, lr @戻りアドレス確認
@除外判定
	cmp r2, #0
	bne return
	ldr r1, =0x0802b40B @必殺は対象外
	cmp r0, r1
	beq return
	ldr r1, =0x0802b607	@デビルアクスも対象外
	cmp r0, r1
	beq return
	b main	@除外判定終了
return:
	push {lr}
	ldr	r0, =RETURN_ADR
	mov	pc, r0
	
main:
	push {r3, r4, r5, lr}	@r3は確率。r4,r5は作業用
	mov r5, sp
	ldr r4, =0x0802AFD1
loop: @加攻撃者アドレス取得ループ
	ldr r0, [r5]
	cmp r0, r4
	beq normalPath

	bl JudgeGeneral
	cmp r0, #1
	beq general
	add	r5, #4
	b	loop

general:
	mov r5, r8
	ldr r4, =0x0203a4e8 @攻撃者アドレス補間
	cmp r4, r5
	bne endHokan
	ldr r4, =0x0203a568 @攻撃者アドレス補間
	b endHokan

normalPath:
	sub r5, #4
	ldr r4, [r5] @加攻撃者アドレス取得
hokan:
	ldr r5, =0x0203a568 @被攻撃者アドレス補間
	cmp r4, r5
	bne endHokan
	ldr r5, =0x0203a4e8 @被攻撃者アドレス補間
endHokan:
	bl judgeActive
	cmp r0, #1
	bne FALSE

	bl ReverseR4R5IfNeeded	@r4が発動判定者。r5が相手

	ldr r0, [sp] @r3
	cmp r0, #0
	beq FALSE	@確率0なら終了(瞬殺対策)

@■奥義確定発動判定
	bl JudgeCombat
	cmp r0, #1
	beq TRUE
	cmp r0, #0xFF
	beq FALSE

@■ジェノサイド判定
	ldrb r0, [r5, #11]
	ldr r1, =0x0203a5e8 @ゲノ
	ldrb r1, [r1]
	cmp r0, r1
	beq FALSE		@相手がジェノサイド発動中
@■見切りチェック
	mov r0, r5
	mov r1, #0
		ldr r3, ADDRESS
		mov lr, r3
		.short 0xF800
	cmp r0, #1
	beq FALSE

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
	mov r10, r2
	pop {r3, r4, r5}	@r3は確率
	ldr r0, =RETURN_ADR
	mov pc, r0

ReverseR4R5IfNeeded:
		push {lr}
	@独自のディフェンスチェック
		bl GetBigShieldID
		mov r1, r10
		cmp r0, r1
		bne notReverse
		bl GetHolyShieldID
		mov r1, r10
		cmp r0, r1
		bne notReverse
	Reverse:
		eor r5, r4
		eor r4, r5
		eor r5, r4
	notReverse:
		pop {pc}

judgeActive:
		push {lr}

        ldr r0, =0x0203a604
        ldr r0, [r0]
        ldr r0, [r0]
        mov r1, #128
        lsl r1, r1, #3
        and r0, r1
        bne inactive	@トライアングルアタック発動中は無効

        ldr r0, [r4, #76]
        mov r1, #0xC0
        and r0, r1
        bne inactive	@反撃不可武器と魔法剣は無効

		mov r0, r4
		add r0, #74
		ldrh r0, [r0]
		bl GetWeaponAbility
		cmp r0, #3
		beq inactive	@イクリプスは無効
		mov r0, #1
		b active

	inactive:
		mov r0, #0
	active:
		pop {pc}

GetWeaponAbility:
	ldr r1, =0x080174cc
	mov pc, r1

JudgeCombat:
		push {lr}
		ldrb r0, [r4, #11]
		mov r2, #0xC0
		and r2, r0
		bne falseWar            @自軍以外は通常確率計算

		ldr r2, =0x03004df0
		ldr r2, [r2]
		ldrb r2, [r2, #11]
		cmp r0, r2
		bne falseWar            @攻めてないので通常確率計算

		mov r0, #ATTACK_FLG_OFFSET
		ldrb r0, [r4, r0]
		mov r1, #FIRST_ATTACKED_FLAG
		tst r0, r1
		bne inactiveCombat      @初撃ではないので終了

		mov r0, #WAR_OFFSET
		ldrb r0, [r4, r0]
		cmp r0, #0
		beq falseWar            @戦技未選択なので通常確率計算

		mov r1, r10
		cmp r0, r1
		bne inactiveCombat      @戦技選択かつ不一致は、絶対不発

		bl JudgeAssassinate
		cmp r0, #1
		beq falseWar            @暗殺なので通常確率計算

		mov r0, #1
		b endWar                @確定発動

    inactiveCombat:
        mov r0, #0xFF
        b endWar

	falseWar:
		mov r0, #0
	endWar:
		pop {pc}


JudgeAssassinate:
		push {lr}

		bl GetAssassinateID

		mov r1, r10
		cmp r0, r1
		bne falseAssassinate	@暗殺ではないならジャンプ

		mov r0, #1
		.short 0xE000
	falseAssassinate:
		mov r0, #0
		pop {pc}

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

JudgeGeneral:
	ldr r1, =0x0802a385
	ldr r2, =0x08031e5b
	cmp r0, r1
	beq endGeneral
	cmp r0, r2
	beq endGeneral
	mov r0, #0
	.short 0xE000
endGeneral:
	mov r0, #1
	bx lr

GetAssassinateID:
ldr r0, ADDRESS+16
bx lr
GetBigShieldID:
ldr r0, ADDRESS+20
bx lr
GetHolyShieldID:
ldr r0, ADDRESS+24
bx lr


@non
@	pop	{r3}
@	mov	r0, #0
@	bx	lr
@0x8反撃
@0x4追撃
.align
.ltorg
ADDRESS:

