
WAR_ADR = (67)	@書き込み先(AI1カウンタ)
WAR_FLAG = (0xFF)	@フラグ

@ORG 0802b86C
.thumb

@前処理
	cmp r0, #0
	bne START
	ldr	r1, =0x0203a604
	ldr	r0, [r1, #0]
	add	r0, #4	@スキルとかのアレをカウントアップ	
	str	r0, [r1, #0]
	mov r0, #0
START:
	push {r0}
	ldr r0, =0x0203a4d0
	ldrh r1, [r0, #0]
	mov r0, #2
	and r0, r1
	cmp r0, #0
	bne RETURN	@戦闘予測時はスキップ
	
	bl WarSkill
	
RETURN:
	pop {r0}
	
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1

WarSkill:
	push {r5, lr}
	
	mov r3, r13
	ldr r3, [r3, #20]


	ldrb r0, [r3, #11]
	mov r2, #0xC0
	and r2, r0
	bne endWar @自軍以外は終了

	ldr r2, =0x03004df0
	ldr r2, [r2]
	ldrb r1, [r2, #0xB]
	cmp r0, r1
	bne endWar	@選択者と攻撃者が違う

	mov r0, #WAR_ADR
	ldrb r0, [r3, r0]
	cmp r0, #0
	beq endWar	@戦技なし
	cmp r0, #0xFF
	beq endWar	@戦技なし

	mov r0, r13
	ldr r0, [r0, #20]
	bl RagingStorm
	mov r0, r13
	ldr r0, [r0, #20]
	bl Lunge
	mov r0, r13
	ldr r0, [r0, #20]
	bl GetDecreaseNum
	mov r0, r13
	ldr r3, [r0, #20]

	mov r1, #WAR_ADR
	mov r0, #0xFF
	strb r0, [r3, r1]
@無限の武器
	mov r0, r13
	ldr r0, [r0, #20]	@r8が相手のアドレス
	mov	r1, #72	@装備中(74はトップアイテム)
	ldrh r1, [r1, r0]
	bl Infinity
	cmp r0, #1
	beq endWar
@命中チェック
	ldr	r2, =0x0203a604
	ldr	r2, [r2]
	sub	r2, #4	@スキルとかのアレの前の状態を取る
	ldr r0, [r2]
	
	mov r1, #2	@外れフラグ
	and r1, r0
	bne endWar	@外れフラグオンでジャンプ
	
	mov r1, #0x80
	lsl r1, r1, #7
	orr r0, r1
	str r0, [r2]
	
@武器は損処理
	cmp r5, #1
	ble endWar	@COSTが1以下なので追加減少はない
	mov r3, #1	@通常減る分
	mov r1, r13
	ldr r1, [r1, #20]	@r8が相手のアドレス
	add	r1, #72	@装備中(74はトップアイテム)
	ldrh	r0, [r1]
	lsr r2, r0, #8
	beq breakWar	@もう壊れている
loop_top_break:
	bl func_break
	mov r1, r13
	ldr r1, [r1, #20]	@r8が相手のアドレス
	add	r1, #72
	strh	r0, [r1]
	lsr r2, r0, #8
	beq breakWar
	add r3, #1
	cmp r3, r5		@規定回数分壊す
	blt loop_top_break
endWar:
	pop {r5, pc}
	
breakWar:
	mov r1, r13
	ldr r1, [r1, #20]	@r8が相手のアドレス
	add	r1, #125
	mov	r0, #1
	strb	r0, [r1, #0]
	b endWar
	
func_break:
	push {r3, lr}
	ldr r3, =0x08016894
	mov lr, r3
	.short 0xF800
	pop {r3, pc}

LUNGE_FLAG    = (0b00010000) @切り込みフラグ

Lunge:
        push {r4, lr}
		mov r4, r0

		ldr	r2, =0x0203a604
		ldr	r2, [r2]
		sub	r2, #4	@スキルとかのアレの前の状態を取る
		ldr r0, [r2]
		
		mov r1, #2	@外れフラグ
		and r1, r0
		bne falseLunge	@外れフラグオンでジャンプ

    @スキルを持っているか
        mov r0, r4
		mov r1, #0
        bl HasLunge
        cmp r0, #0
        beq falseLunge

		mov r0, r4
		add r0, #69
		ldrb r1, [r0]

		mov r2, #LUNGE_FLAG
		orr r1, r2
		strb r1, [r0] @切り込み

        mov r0, #1
        .short 0xE000
    falseLunge:
        mov r0, #0
        pop {r4, pc}

STORM    = (0b00100000) @狂嵐フラグ

@アイムール
RagingStorm:
        push {r4, lr}
		mov r4, r0

		ldr	r2, =0x0203a604
		ldr	r2, [r2]
		sub	r2, #4	@スキルとかのアレの前の状態を取る
		ldr r0, [r2]
		
		mov r1, #2	@外れフラグ
		and r1, r0
		bne falseStorm	@外れフラグオンでジャンプ

    @スキルを持っているか
        mov r0, r4	@r1は既にセット済み
		mov r1, #0
        bl HasRagingStorm
        cmp r0, #0
        beq falseStorm

		mov r0, r4
		add r0, #69
		ldrb r1, [r0]

		mov r2, #STORM
		orr r1, r2

		strb r1, [r0] @狂嵐発動

        mov r0, #1
        .short 0xE000
    falseStorm:
        mov r0, #0
        pop {r4, pc}

COMBAT_LIST = (addr+8)
COMBAT_LIST_SIZE = (addr+12)

GetDecreaseNum:
		add r0, #WAR_ADR
		ldrb r0, [r0]
		ldr r1, COMBAT_LIST_SIZE
		mul r0, r1
		ldr r1, COMBAT_LIST
		add r0, r1

		ldrb r5, [r0, #4]
		bx lr


HAS_RASINGSTORM = (addr+4)
HAS_LUNGE = (addr+16)

HasLunge:
ldr r2, HAS_LUNGE
mov pc, r2

HasRagingStorm:
ldr r2, HAS_RASINGSTORM
mov pc, r2

Infinity:
	ldr r3, addr
	mov pc, r3
.align
.ltorg
addr:

	