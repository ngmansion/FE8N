.thumb
    mov r1, #0
    b merge
    mov r1, #1
    b merge
    mov r1, #2
    b merge
    mov r1, #3
    b merge
    mov r1, #4
    b merge
    mov r1, #5
    b merge
    mov r1, #6
    b merge
    mov r1, #7
merge:
    push {r4, r5, lr}
    ldr r2, ADDR+16
    strb r1, [r2]       @now_selecting

    ldr r2, ADDR+0
    ldrb r5, [r2, r1]
    cmp r5, #0
    beq end
    add r0, #76
    mov r4, r0
    mov r0, r5
    bl ConvSkillID2HelpID
    strh r0, [r4]

    mov r0, r5
    bl GET_COMBAT_ARTS_TYPE
    cmp r0, #1
    beq trueCombat
    cmp r0, #2
    beq trueCombat
    b end
trueCombat:
    ldr r0, =0xFD01       @武器ID(ダミー)
    strh r0, [r4, #2]
end:
    pop {r4, r5, pc}

ConvSkillID2HelpID:
        ldr r1, ADDR+4
        ldr r2, ADDR+8
        mul r0, r2
        ldrh r0, [r1, r0]
        bx lr
GET_COMBAT_ARTS_TYPE:
    ldr r1, ADDR+12
    mov pc, r1
.align
.ltorg
ADDR:
