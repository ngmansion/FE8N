.thumb
HAS_NIHIL_FUNC = (ADR+0)
HAS_SKILL_FUNC = (ADR+4)
@
@r0 = skill_unit
@r1 = nihil_unit
@r2 = skill_id
@
    push {r4, r5, lr}
    mov r4, r0
    mov r5, r2
    bl hasNihil
    cmp r0, #1
    beq false

    mov r0, r4
    mov r1, r5
    bl judgeSkill

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

