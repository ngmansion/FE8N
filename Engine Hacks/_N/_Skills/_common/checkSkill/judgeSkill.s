
SKL_TBL = ADR+0
CONTAINS_SKILL = ADR+4
JUDGE_UNIT = ADR+8
WP_LV_SKL_TABLE = ADR+12
RECORD_SKILLANIME_ID_FUNC = ADR+16	@record_skillanime_id 保持しているとされたスキルを記録 その後発動すれば、エフェクト付きで表示する.

.thumb
    push {r4, r5, lr}
    mov r4, r0
    lsl r1, r1, #24
    lsr r1, r1, #24
    mov r5, r1
@ダミーユニットチェック
    ldr r2, [r0, #4]
    cmp r2, #0
    beq jump3

@書チェック
    bl containsSkill
    cmp r0, #1
    beq oui
    mov r0, r4
    mov r1, r5
    bl judgeUnit
    cmp r0, #1
    beq oui
    mov r0, r4
    mov r1, r5
    bl JudgeWpLv
    cmp r0, #1
    beq oui
    
    mov r2, r5
    ldr r3, SKL_TBL
    lsl r2, r2, #4
    add r3, r2, r3
@武器
    ldr r2, [r3, #12]
    cmp r2, #0
    beq jump3
    mov r1, #74
    ldrb r1, [r4, r1]
loop3:
    ldrb r0, [r2]
    cmp r0, #0
    beq jump3
    cmp r0, r1
    beq oui
    add r2, #1
    b loop3
jump3:
    mov r0, #0
    b end
oui:
	mov r0, r4	 @RAM上へのユニットポインタ
	mov r1, r5	 @持っているスキルID
	bl record_skillanime_id
    mov r0, #1
end:
    pop {r4, r5, pc}

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
	cmp r4, #9	@無効武器
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
judgeUnit:
    ldr r3, JUDGE_UNIT
    mov pc, r3
record_skillanime_id:
	ldr r2, RECORD_SKILLANIME_ID_FUNC
	mov pc, r2
.align
.ltorg
ADR:

