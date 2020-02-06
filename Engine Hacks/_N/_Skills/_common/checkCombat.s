.thumb
HAS_NIHIL_FUNC = (ADR+0)
HAS_SKILL_FUNC = (ADR+4)

STR_ADR = (67)	@書き込み先(AI1カウンタ)
@
@r0 = skill_unit
@r1 = nihil_unit
@r2 = skill_id
@
    push {r4, r5, lr}
    mov r4, r0
    mov r5, r2
    mov r0, r1
@    bl hasNihil
@    cmp r0, #1
@    beq false

	ldrb r0, [r4, #11]
	mov r2, #0xC0
	and r2, r0
	bne false @自軍以外は終了

    ldr r2, =0x03004df0
    ldr r2, [r2]
    ldrb r2, [r2, #11]
    cmp r0, r2
    bne false

    mov r0, #STR_ADR
    ldrb r0, [r4, r0]
    cmp r0, r5
    bne false
    mov r0, #1
    pop {r4, r5, pc}
false:
    mov r0, #0
    pop {r4, r5, pc}
hasNihil:
    ldr r3, HAS_NIHIL_FUNC
    mov pc, r3
judgeSkill:
    ldr r3, HAS_SKILL_FUNC
    mov pc, r3
.align
.ltorg
ADR:

