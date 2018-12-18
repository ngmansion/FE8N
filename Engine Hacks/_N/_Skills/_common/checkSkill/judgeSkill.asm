
@define SKL_TBL ADR+0
@define CONTAINS_SKILL ADR+4
@define DEDUP_UNIT ADR+8

@thumb
    push {r4, r5, lr}
    mov r4, r0
    lsl r1, r1, #24
    lsr r1, r1, #24
    mov r5, r1
;書チェック
    bl containsSkill
    cmp r0, #1
    beq oui
    mov r0, r4
    mov r1, r5
    bl dedupUnit
    cmp r0, #1
    beq oui
    
    mov r2, r5
@align 4
    ldr r3, [SKL_TBL]
    lsl r2, r2, #4
    add r3, r2, r3
;武器
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
    @dcw $E000
oui:
    mov r0, #1
    pop {r4, r5, pc}
@align 4
@ltorg

containsSkill:
    ldr r3, [CONTAINS_SKILL]
    mov pc, r3
dedupUnit:
    ldr r3, [DEDUP_UNIT]
    mov pc, r3
ADR: