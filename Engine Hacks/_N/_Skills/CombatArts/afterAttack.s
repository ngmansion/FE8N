RAGING_STORM_FLAG     = (2)
COMBAT_HIT            = (1)
FIRST_ATTACKED_FLAG   = (0)

@ORG 0802b868
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

	mov r0, r13
	ldr r0, [r0, #20]
	bl Hit_Func

	mov r3, r13
	ldr r3, [r3, #20]
	ldrb r0, [r3, #11]
	ldr r2, =0x03004df0
	ldr r2, [r2]
	ldrb r1, [r2, #0xB]
	cmp r0, r1
	bne endWar	@選択者と攻撃者が違う

	mov r0, r13
	ldr r0, [r0, #20]
	bl GET_COMBAT_ART

	cmp r0, #0
	beq endWar	@戦技なし
	cmp r0, #0xFF
	beq endWar	@戦技なし

	mov r0, #FIRST_ATTACKED_FLAG
	mov r1, r13
	ldr r1, [r1, #20]
	bl IS_TEMP_SKILL_FLAG
    cmp r0, #1
	beq endWar	@フラグオンなのでジャンプ

	mov r0, r13
	ldr r0, [r0, #20]
	bl GetDecreaseNum   @r5に減少数取得

	mov r0, #FIRST_ATTACKED_FLAG
	mov r1, r13
	ldr r1, [r1, #20]
	bl TURN_ON_TEMP_SKILL_FLAG

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

    ldr r0, =0x0203a568
    mov r1, r13
    ldr r1, [r1, #20]
    bl HAS_CORROSION
    cmp r0, #0
    beq notCorrosion
    lsl r5, #1      @消費2倍
    sub r5, #1      @通常減る分は除く
notCorrosion:

@武器破損処理
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



Hit_Func:
        push {r4, lr}
        mov r4, r0

        ldr	r2, =0x0203a604
        ldr	r2, [r2]
        sub	r2, #4      @スキルとかのアレの前の状態を取る
        ldr r0, [r2]

        mov r1, #2      @外れフラグ
        and r1, r0
        bne endCombat     @外れフラグオンでジャンプ

        mov r0, #COMBAT_HIT
        mov r1, r4
        bl TURN_ON_TEMP_SKILL_FLAG

    endCombat:
        pop {r4, pc}

GetDecreaseNum:
        push {lr}
        bl GET_COMBAT_ART
        ldr r1, COMBAT_LIST_SIZE
        mul r0, r1
        ldr r1, COMBAT_LIST
        add r0, r1

        ldrb r5, [r0, #4]
        pop {pc}

COMBAT_LIST = (addr+8)
COMBAT_LIST_SIZE = (addr+12)

Infinity:
    ldr r3, addr
    mov pc, r3
HAS_CORROSION:
    ldr r3, addr+28
    mov pc, r3
GET_COMBAT_ART:
    ldr r2, addr+32
    mov pc, r2
IS_TEMP_SKILL_FLAG:
    ldr r2, addr+36
    mov pc, r2
TURN_ON_TEMP_SKILL_FLAG:
    ldr r2, addr+40
    mov pc, r2
.align
.ltorg
addr:

	