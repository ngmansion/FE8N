.thumb
HAS_OCCULT_FUNC = (ADR+0)
HAS_SKILL_FUNC = (ADR+4)

    push {r4, r5, lr}
    mov r4, r0
    mov r5, r1  @ID
    bl judgeOccult
    cmp r0, #0
    beq ret
    mov r10, r5

    mov r0, r4
    mov r1, r5  @ID
    bl judgeSkill
ret:
    pop {r4, r5, pc}

judgeOccult:
        push {lr}
        mov r1, #0
            ldr r2, ADR+0 @奥義の書
            mov lr, r2
            .short $F800
        cmp r0, #0
        bne end
        
        mov r0, #72
        ldrh r0, [r4, r0]
            ldr r1, =0x080172f0 @武器種類
            mov lr, r1
            .short $F800
        cmp r0, #7
        bgt false
        add r0, #40
        ldrb r0, [r4, r0]
        cmp r0, #250
        bls false
        mov r0, #1
        pop {pc}
    false:
        mov r0, #0
    end:
        pop {pc}

judgeSkill:
    ldr r3, HAS_SKILL_FUNC
    mov pc, r3
.align
.ltorg
ADR:

