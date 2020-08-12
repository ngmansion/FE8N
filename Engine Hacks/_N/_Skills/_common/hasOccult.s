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
        push {r4, lr}
        mov r4, r0
        mov r1, #0
            ldr r2, ADR+0 @奥義の書
            mov lr, r2
            .short 0xF800
        cmp r0, #1
        beq end
        
        mov r0, #0x50
        ldrb r0, [r4, r0]
        cmp r0, #7
        bgt false
        add r0, #40
        ldrb r0, [r4, r0]
        cmp r0, #250
        bls false
        mov r0, #1
        .short 0xE000
    false:
        mov r0, #0
    end:
        pop {r4, pc}

judgeSkill:
    ldr r3, HAS_SKILL_FUNC
    mov pc, r3
.align
.ltorg
ADR:

