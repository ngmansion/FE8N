
SKL_TBL = ADR+0
CONTAINS_SKILL = ADR+4
JUDGE_UNIT_FUNC = ADR+8
WP_LV_SKL_TABLE = ADR+12
SKL_TBL_SIZE = ADR+16
CHECK_ITEM_FUNC = ADR+20

@
@	judgeUnitと横並びの作り
@
.thumb
@ユニットデータとスキルIDから、発動可能かを判定する
    push {r4, r5, lr}
    mov r4, r0
    lsl r1, r1, #24
    lsr r1, r1, #24
    mov r5, r1
@ダミーユニットチェック
	cmp r4, #0
    beq false
    ldr r0, [r4, #4]
    cmp r0, #0
    beq false
    ldrb r0, [r4, #19]
    cmp r0, #0
    beq false
@書チェック
    mov r0, r4
    mov r1, r5
    bl containsSkill
    cmp r0, #1
    beq true
@ユニットデータチェック
    mov r0, r4
    mov r1, r5
    bl judgeSkillInUnitData
    cmp r0, #1
    beq true
@リストチェック
    mov r0, r4
    mov r1, r5
    bl judgeList
    cmp r0, #1
    beq true
@武器レベルチェック
    mov r0, r4
    mov r1, r5
    bl JudgeWpLv
    cmp r0, #1
    beq true
false:
    mov r0, #0
    b return
true:
    mov r0, #1
return:
    pop {r4, r5, pc}


judgeList: @リストチェック
		push {r6, lr}
		ldr r6, SKL_TBL
		ldr r0, SKL_TBL_SIZE
		mul r0, r5
		add r6, r0
	@ユニット
		add r6, #4
		ldr r0, [r6]
		ldr r1, [r4]
		ldrb r1, [r1, #4]
		bl Listfunc
		cmp r0, #1
		beq trueList
	@クラス
		add r6, #4
		ldr r0, [r6]
		ldr r1, [r4, #4]
		ldrb r1, [r1, #4]
		bl Listfunc
		cmp r0, #1
		beq trueList
	@武器
		add r6, #4
		
		mov r0, r4
		bl getWeapon
		lsl r1, r0, #24
		lsr r1, r1, #24

		ldr r0, [r6]
		bl Listfunc
		cmp r0, #1
		beq trueList
	@アイテム
		add r6, #4
		mov r0, r4
		ldr r1, [r6]
		bl checkItemList	@5か所判定するので1層潜る
		cmp r0, #1
		beq trueList

		mov r0, #0
		b endList
	trueList:
		mov r0, #1
	endList:
		pop {r6, pc}

Listfunc:
@r0 = リスト先頭ポインタ
@r1 = 検索キー
		cmp r0, #0
		beq endLoop
		cmp r1, #0
		beq endLoop
		mov r2, r0
	whileLoop:
		ldrb r0, [r2]
		cmp r0, #0
		beq falseLoop
		cmp r0, r1
		beq trueLoop
		add r2, #1
		b whileLoop
	falseLoop:
		mov r0, #0
		b endLoop
	trueLoop:
		mov r0, #1
	endLoop:
		bx lr

getWeapon:
		push {lr}
		ldr r1, =0x0203a4e8
		cmp r0, r1
		beq notWeapon
		ldr r1, =0x0203a568
		cmp r0, r1
		beq notWeapon
			ldr r1, =0x080168d0
			mov lr, r1
			.short 0xF800
		b endWeapon
	notWeapon:
		mov r1, #74
		ldrh r0, [r0, r1]
	endWeapon:
		pop {pc}

JudgeWpLv:
	push {r4, r5, r6, lr}
	mov r5, r0
	mov r6, r1
	mov r4, #0
loopJudgeWpLv:
	mov r0, r5
	mov r1, r6
	bl CheckWp
	cmp r0, #1
	beq endJudgeWpLv
	add r4, #1
	cmp r4, #8	@無効武器
	blt loopJudgeWpLv
	mov r0, #0
endJudgeWpLv:
	pop {r4, r5, r6, pc}

CheckWp:
	push {lr}

	add	r0, #40
	ldrb	r0, [r0, r4]
		ldr r1, =0x08016b04
		mov lr, r1
		.short 0xF800
	ldr r3, WP_LV_SKL_TABLE
	cmp r0, #1
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	
	add r3, #8
	cmp r0, #2
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	
	add r3, #8
	cmp r0, #3
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	
	add r3, #8
	cmp r0, #4
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	
	add r3, #8
	cmp r0, #5
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	
	add r3, #8
	cmp r0, #6
	blt falseCheckWp
	ldrb r1, [r3, r4]
	cmp r6, r1
	beq trueCheckWp
	b falseCheckWp
	
trueCheckWp:
	mov r0, #1
	b endCheckWp
falseCheckWp:
	mov r0, #0
endCheckWp:
	pop {pc}

containsSkill:
    ldr r3, CONTAINS_SKILL
    mov pc, r3
judgeSkillInUnitData:
	ldr r3, JUDGE_UNIT_FUNC
	mov pc, r3
checkItemList:
	ldr r3, CHECK_ITEM_FUNC
	mov pc, r3
.align
.ltorg
ADR:

