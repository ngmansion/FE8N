.thumb

DEAD_EYE_ID = (0x4C)

HAS_GOD_SHIELD_FUNC = (adr+8)
HAS_NIHIL_FUNC = (adr+16)
SET_SKILLANIME_DEF_FUNC = (adr+20)

@.org	0802b490 > 00 4A 97 46 XX XX XX 08
@
@
@備考：
@戦闘予測のダメージ計算は 08036a3a～で実施
	bl Invincible
	cmp r0, #1
	beq zero

	mov r1, #4
	ldsh r0, [r4, r1]
	cmp r0, #0
	ble zero

	mov r0, r8
	ldrb r0, [r0, #0xB]
		ldr r1, =0x08019108
		mov lr, r1
		.short 0xF800
	cmp r0, #0
	beq end	@壁
	
	bl DistantGuard @遠距離無効
	cmp r0, #0
	bne zero

	bl Divide
	bl ImpregnableWall
	bl Deflect

	bl Xeno
	cmp r0, #1
	beq end

	bl Pray
	cmp r0, #1
	beq end

	bl Amulet
	cmp r0, #1
	beq end
@以下、確率発動処理
	bl checkSkip
	cmp r0, #1
	beq end	@確率発動処理をスキップ

	bl HolyShield
	cmp r0, #1
	beq end

	bl BigShield
	
	b end

zero:
	mov	r0, #0
	strh	r0, [r4, #4]
end:
	ldr r0, =0x0802b49a
	mov pc, r0

checkSkip:
		mov r1, r9
		cmp r1, #DEAD_EYE_ID
		beq trueSkip	@必的チェック
		ldr r0, =0x0203a604
		ldr r0, [r0]
		ldr r0, [r0]
		mov r1, #128
		lsl r1, r1, #3
		and r0, r1
		bne trueSkip	@トライアングルチェック
		mov r0, #0
		bx lr
	trueSkip:
		mov r0, #1
		bx lr

ImpregnableWall:
        push {lr}

        bl checkSkip
        cmp r0, #1
        beq falseWall

        mov r0, r8
        ldrb r0, [r0, #0xb]
        ldr r1, =0x03004df0
        ldr r1, [r1]
        ldrb r1, [r1, #0xb]
        cmp r0, r1
        beq falseWall

		mov r0, r8
		ldrb r0, [r0, #11]
			ldr r3, =0x08019108
			mov lr, r3
			.short 0xF800
		ldrb r1, [r0, #0x13]     @戦闘前のHP
		mov r0, r8
		ldrb r0, [r0, #0x13]    @今のHP
		cmp r0, r1
		blt falseDeflect    @HPが減っていれば終わり

        mov r0, r8
        mov r1, r7
        bl HAS_IMPREGNABLE_WALL
        cmp r0, #0
        beq falseWall

        ldrh r0, [r4, #4]
        bl divide4
        strh r0, [r4, #4]

        mov r0, #1
        .short 0xE000
    falseWall:
        mov r0, #0
        pop {pc}




Divide:	@神盾+守備隊形
		push {lr}
		bl checkSkip
		cmp r0, #1
		beq falseDivide

		ldrh r0, [r4, #4]
		mov r1, r7
		mov r2, r8
		bl DefDivide
		strh r0, [r4, #4]
		mov r0, #1
		b endDivide

	falseDivide:
		mov	r0, #0
	endDivide:
		pop	{pc}

Invincible:
		push {lr}

		mov r0, r8
		mov r1, #0
		bl hasInvincible
		cmp r0, #0
		beq falseInvincible
@
		mov r1, r7
		add r1, #100
		ldrh r0, [r1]
		cmp r0, #100
		blt jumpInvincible
		mov r0, #99
		strh r0, [r1] @命中99
	jumpInvincible:
		ldr r0, =0x0203a4d0
		ldrh r1, [r0, #0]
		mov r0, #2
		and r0, r1
		cmp r0, #0
		bne falseInvincible @戦闘予測時はスキップ
@
		mov r3, r8
		ldrb r1, [r3, #19]
		ldrh r0, [r4, #4]
		cmp r0, r1
		blt falseInvincible @一撃で死なないなら終了
@
		ldr r3, =0x0203a604
		ldr r3, [r3, #0]
		ldr r2, [r3, #0]
		lsl r1, r2, #13
		lsr r1, r1, #13
		mov r0, #2
		orr r1, r0
		ldr r0, =0xfff80000
		and r0, r2
		orr r0, r1
		str r0, [r3, #0]	@回避

		mov r0, #1
		b endInvincible
	falseInvincible:
		mov r0, #0
	endInvincible:
		pop {pc}

Deflect:
		push {lr}
		ldr r0, =0x0203a4d0
		ldrh r0, [r0]
		mov r1, #0x20
		and r0, r1
		bne falseDeflect @闘技場チェック

		bl checkSkip
		cmp r0, #1
		beq falseDeflect

		mov r0, r8
		ldrb r0, [r0, #11]
			ldr r3, =0x08019108
			mov lr, r3
			.short 0xF800
		ldrb r1, [r0, #0x13] @戦闘前のHP
		mov r0, r8
		ldrb r0, [r0, #0x13] @今のHP
		cmp r0, r1
		bge falseDeflect @HP減少(被攻撃)が無ければ終わり

		mov r0, r8
        mov r1, r7
        bl HAS_DEFLECT
		cmp r0, #0
		beq falseDeflect
		
		ldrh r0, [r4, #4]
		bl divide4
		strh r0, [r4, #4]
		mov r0, #1
		.short 0xE000
	falseDeflect:
		mov r0, #0
		pop {pc}
	
	
	
	DistantGuard:
		push {lr}
		mov r0, r8
			ldr r1, adr+24 @遠距離無効
			mov lr, r1
			.short 0xF800
		cmp r0, #0
		beq endDistantGuard
		
		ldr r0, =0x0203a4d2
		ldrb r0, [r0] @距離
		cmp r0, #1
		beq endDistantGuard
		mov r0, #0
		mov r1, #90
		strh r0, [r7, r1]	@攻撃力0
		mov r0, #1
		.short 0xE000
	endDistantGuard:
		mov r0, #0
		pop {pc}
		

BigShield:
	push {lr}
	
	mov	r0, #0x50
	ldrb	r0, [r7, r0]	@魔法判定
	cmp	r0, #0
	beq	ouiShield
	cmp	r0, #1
	beq	ouiShield
	cmp	r0, #2
	beq	ouiShield
	cmp	r0, #3
	beq	ouiShield
	b falseShield
ouiShield:
	mov r0, r8
	mov r1, r7
	bl HasBigShield
	cmp r0, #0
	beq falseShield

	ldr r1, HAS_BIG_SHIELD_FUNC
	mov r10, r1

	mov	r3, r8
	ldrb	r0, [r3, #21]	@技
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	falseShield
	ldrh	r0, [r4, #4]
	bl divide5
	strh	r0, [r4, #4]
	
    mov r0, r8
    ldr r1, HAS_BIG_SHIELD_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_DEF_FUNC
        mov lr, r2
        .short 0xF800
	
	mov	r0, #1
	b endShield
falseShield:
	mov	r0, #0
endShield:
	pop	{pc}
	
	
HolyShield:
	push {lr}

	mov	r0, #0x50
	ldrb	r0, [r7, r0]	@物理判定
	cmp	r0, #0
	beq	falseHoly
	cmp	r0, #1
	beq	falseHoly
	cmp	r0, #2
	beq	falseHoly
	cmp	r0, #4
	beq	falseHoly

	mov r0, r8
	mov r1, r7
	bl HasHolyShield
	cmp r0, #0
	beq falseHoly

    ldr r1, HAS_HOLY_SHIELD_FUNC
	mov r10, r1

	mov	r3, r8
	ldrb	r0, [r3, #21]	@技
	mov	r1, #0
	bl	random
	cmp	r0, #0
	beq	falseHoly
	ldrh	r0, [r4, #4]
	bl divide5
	strh	r0, [r4, #4]
	
    mov r0, r8
    ldr r1, HAS_HOLY_SHIELD_FUNC
    ldr r1, [r1, #12]
        ldr r2, SET_SKILLANIME_DEF_FUNC
        mov lr, r2
        .short 0xF800
	
	mov	r0, #1
	pop	{pc}

falseHoly:
	mov	r0, #0
	pop	{pc}
	
	
Pray:
	push {lr}

	bl checkSkip
	cmp r0, #1
	beq falsePray
	mov r3, r8
	ldrb r1, [r3, #19]
	ldrh r0, [r4, #4]
	cmp r0, r1
	blt falsePray @一撃で死なないなら終了
	
	bl JudgePray
	cmp r0, #1
	beq getPray

	bl JudgePrayOld
	cmp r0, #1
	bne falsePray

getPray:
@祈り効果
	mov	r0, r8
	ldrb	r0, [r0, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
	
        mov r0, r8
        ldr r1, HAS_INORI_FUNC
        ldr r1, [r1, #12]
            ldr r2, SET_SKILLANIME_DEF_FUNC
            mov lr, r2
            .short 0xF800
	
	mov	r0, #1
	b endPray
falsePray:
	mov	r0, #0
endPray:
	pop	{pc}


JudgePray:
		push {lr}
		mov r0, r8
		mov r1, r7
		bl HasPray
		cmp r0, #0
		beq	inactivePray
		mov r0, r8
		ldrb r0, [r0, #0xb]
		bl Get_Status
		mov r3, r0

    	mov r0, #0x13
    	ldrb r0, [r3, r0]	@戦闘前現在HP

    	mov r1, #0x12
    	ldrb r1, [r3, r1]	@最大HP
    	lsl r0, r0, #1
    	cmp r0, r1
    	blt inactivePray
		mov r3, r8
    	mov r0, #0x13
    	ldrb r0, [r3, r0]	@現在HP
		cmp r0, #1
		ble inactivePray
		b activePray

JudgePrayOld:
		push {lr}
		mov r0, r8
		mov r1, r7
		bl HasPrayOld
		cmp r0, #0
		beq	inactivePray
		mov r3, r8
    	mov r0, #0x13
    	ldrb r0, [r3, r0]	@現在HP
		cmp r0, #1
		ble inactivePray

	activePray:
		mov r0, #1
		pop {pc}
	inactivePray:
		mov r0, #0
		pop {pc}

Amulet:
	push {r5, lr}
	mov	r3, r8
	ldrb	r1, [r3, #19]	@現在HP
@一撃で死ぬか
	ldrh	r0, [r4, #4]	@ダメージ
	cmp	r0, r1
	blt	endAmulet

	mov	r5, #0x1C
loopAmulet:
	add	r5, #2
	cmp	r5, #40
	beq	endAmulet
	mov	r3, r8
	ldrh	r0, [r3, r5]
	cmp	r0, #0
	beq	loopAmulet
		ldr	r1, =0x08017314
		mov	lr, r1
		.short 0xF800
	mov r2, r0
	lsl	r0, r2, #5	@盾パッチの下の下
	bmi	ouiAmulet
	b	loopAmulet
	
ouiAmulet:
	ldrh r0, [r3, r5]
	lsr r1, r0, #8
	cmp r1, #0xFF
	beq loopAmulet	@壊れているので次へ(エリクサー用)
	cmp r1, #0
	beq loopAmulet	@壊れているので次へ(エリクサー用)

	lsl	r1, r2, #27	@特殊・売却不可
	bmi	gotElixir	@エリクサーはここでは破損処理はしない

	push {r3}
	bl $08016894
	pop {r3}
	strh r0, [r3, r5]	@破損処理

gotElixir:
	ldrb	r0, [r3, #19]
	sub	r0, #1
	strh	r0, [r4, #4]
	
        mov r0, r8
        ldr r1, HAS_INORI_FUNC
        ldr r1, [r1, #12]
            ldr r2, SET_SKILLANIME_DEF_FUNC
            mov lr, r2
            .short 0xF800
	
	mov	r0, #1
	pop	{r5, pc}
endAmulet:
	mov	r0, #0
	pop	{r5, pc}

Xeno:
		mov r2, r8
		ldrb r0, [r2, #11]
		ldr r1, =0x0203a5e8 @ジェノサイド
		ldrb r1, [r1]
		cmp r0, r1
		bne falseXeno @不発
		ldrh r0, [r4, #4]
		ldrb r1, [r2, #19]	@現在HP
	@一撃で死ぬか
		cmp r0, r1
		blt falseXeno
		sub r1, #1
		strh r1, [r4, #4]
		mov r0, #1
		b endXeno
	falseXeno:
		mov r0, #0
	endXeno:
		bx lr

divide5:
        asr r0, r0, #1
        cmp r0, #0
        bgt not_div5
        mov r0, #1
    not_div5:
        bx lr


divide4:
        lsl r1, r0, #1
        add r0, r1
        mov r1, #5
        swi #6      @4割
        cmp r0, #0
        bgt not_div4
        mov r0, #1
    not_div4:
        bx lr

HAS_BIG_SHIELD_FUNC = (adr+0)
HAS_HOLY_SHIELD_FUNC = (adr+4)
DEF_DIVIDE_FUNC = (adr+8)
HAS_INORI_FUNC = (adr+12)
HAS_INVINCIBLE_FUNC = (adr+28)

HasBigShield:
	ldr	r3, HAS_BIG_SHIELD_FUNC
	mov	pc, r3

HasHolyShield:
	ldr	r3, HAS_HOLY_SHIELD_FUNC
	mov	pc, r3

DefDivide:
	ldr	r3, DEF_DIVIDE_FUNC
	mov	pc, r3

hasInvincible:
	ldr	r2, HAS_INVINCIBLE_FUNC
	mov	pc, r2

HasPray:
ldr r2, HAS_INORI_FUNC @祈り
mov pc, r2

HAS_DEFLECT:
ldr r2, (adr+32)
mov pc, r2

HAS_IMPREGNABLE_WALL:
ldr r2, (adr+36)
mov pc, r2

HasPrayOld:
ldr r2, (adr+40)
mov pc, r2

Get_Status:
	ldr r1, =0x08019108
	mov pc, r1

$08016894:
ldr	r1, =0x08016894
mov	pc, r1

random:
	ldr	r2, =0x0802a490
	mov	pc, r2
.align
.ltorg
adr:
