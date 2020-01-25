SKL_TBL = ADR+0
CONTAINS_SKILL = ADR+4
JUDGE_UNIT_FUNC = ADR+8
WP_LV_SKL_TABLE = ADR+12
SKL_TBL_SIZE = ADR+16
CHECK_ITEM_FUNC = ADR+20

@
@	judgeSkillと横並びの作り
@
.thumb
@I	r0 = ベースアドレス
@	r1 = スキルID
@O	-
    push {r4, r5, lr}
    mov r4, r0
    lsl r1, r1, #24
    lsr r1, r1, #24
    mov r5, r1
@ダミーユニットチェック
	cmp r4, #0
    beq false
    ldr r0, [r4, #0]
    cmp r0, #0
    beq false
    ldr r0, [r4, #4]
    cmp r0, #0
    beq false
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
		beq falseLoop
		mov r2, r0
	whileLoop:
		ldrb r0, [r2]
		cmp r0, #0
		beq endLoop
		cmp r0, r1
		beq trueLoop
		add r2, #1
		b whileLoop
	falseLoop:
		mov r0, #0
		bx lr
	trueLoop:
		mov r0, #1
	endLoop:
		bx lr

judgeSkillInUnitData:
	ldr r3, JUDGE_UNIT_FUNC
	mov pc, r3
.align
.ltorg
ADR:
