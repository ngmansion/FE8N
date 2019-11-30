.thumb
HAS_OCCULT_FUNC = (ADR+0)
HAS_SKILL_FUNC = (ADR+4)

    push {r4, r5, lr}
    mov r4, r0
    mov r5, r1
    bl judgeOccult
    cmp r0, #0
    beq ret
    mov r0, r4
    mov r1, r5
    bl judgeSkill
ret:
    pop {r4, r5, pc}
judgeOccult:
    ldr r3, HAS_OCCULT_FUNC
    mov pc, r3
judgeSkill:
    ldr r3, HAS_SKILL_FUNC
    mov pc, r3
.align
.ltorg
ADR:

