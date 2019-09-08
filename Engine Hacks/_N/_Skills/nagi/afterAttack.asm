
.equ STR_ADR, (67)	@書き込み先(AI1カウンタ)
.equ WAR_FLAG, (0xFF)	@フラグ

@;ORG 0x02b808
.thumb

@前処理
	cmp r0, #0
	bne START
	ldr	r1, =0x0203a604
	ldr	r0, [r1, #0]
	add	r0, #4	@;;スキルとかのアレをカウントアップ	
	str	r0, [r1, #0]
	mov r0, #0
START:
	push {r0}
	ldr r0, =0x0203a4d0
	ldrh r1, [r0, #0]
	mov r0, #2
	and r0, r1
	cmp r0, #0
	bne RETURN	@;戦闘予測時はスキップ
	
	bl WarSkill
	
RETURN:
	pop {r0}
	
	pop	{r4, r5, r6}
	pop	{r1}
	bx	r1

WarSkill:
	push {lr}
	mov r3, r13
	ldr r3, [r3, #16]	@;r8が相手のアドレス
	
	ldr r0, =0x03004df0
	ldr r0, [r0]
	ldrb r1, [r3, #11]
	ldrb r0, [r0, #11]
	cmp r0, r1
	bne endWar @;攻め者と攻撃者が違う
	mov r1, #STR_ADR
	ldrb r0, [r3, r1]
	cmp r0, #0xFF
	bne endWar
	mov r0, #0xFE
	strb r0, [r3, r1]
@命中チェック
	ldr	r1, =0x0203a604
	ldr	r0, [r1, #0]
	sub	r0, #4	@;;スキルとかのアレの前の状態を取る
	ldr r0, [r0]
	
	mov r1, #2	@;外れフラグ
	and r0, r1
	bne endWar	@;外れフラグオンでジャンプ

@武器は損処理
	mov r3, #0
	mov r1, r13
	ldr r1, [r1, #16]	@;r8が相手のアドレス
	add	r1, #72	@;装備中(74はトップアイテム)
	ldrh	r0, [r1]
	cmp r0, #0
	beq breakWar	@;もう壊れている
loop_top_break:
	bl func_break
	mov r1, r13
	ldr r1, [r1, #16]	@;r8が相手のアドレス
	add	r1, #72
	strh	r0, [r1]
	cmp r0, #0
	beq breakWar
	add r3, #1
	cmp r3, #4		@;4回壊す(通常合わせて5減る)
	blt loop_top_break
endWar:
	pop {pc}
	
breakWar:
	mov r1, r13
	ldr r1, [r1, #16]	@;r8が相手のアドレス
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

	