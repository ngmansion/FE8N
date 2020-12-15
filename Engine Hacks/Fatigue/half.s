.thumb




    push {r4, lr}
    mov r4, r0

    bl GET_FATIGUE_NUM

    ldr r1, FATIGUE_LEVEL1
    cmp r0, r1
    blt false
    ldr r1, FATIGUE_LEVEL2
    cmp r0, r1
    blt half

quarter:
    ldrb r0, [r4, #18]
    asr r1, r0, #2
    sub r0, r1
    neg r0, r0
    b end
half:
    ldrb r0, [r4, #18]
    asr r1, r0, #1 @半減
    sub r0, r1
    neg r0, r0
    b end
false:
    mov r0, #0
end:
    pop {r4, pc}

FATIGUE_LEVEL1=addr+0
FATIGUE_LEVEL2=addr+4
GET_FATIGUE_NUM:
    ldr r1, addr+8
    mov pc, r1

.align
.ltorg
addr:
