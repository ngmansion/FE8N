.thumb
@08070c74
RETURN_ADR = (0x08070c7e)

GENOCIDE_WORK_ADR = adr

    mov r1, #58
    ldsh r0, [r6, r1]
    cmp r0, #1
    bne skip

    ldr r1, =0x0203a568 @ジェノサイドは受けだけ気にすれば十分
    ldrb r1, [r1, #0xB]
    ldr r2, GENOCIDE_WORK_ADR
    ldrb r2, [r2]
    cmp r2, r1
    beq skip    @ジェノサイド

    mov r0, r7
    mov r1, #12
        ldr r3, =0x0805587c
        mov lr, r3
        .short 0xF800
skip:
    ldr r3, =RETURN_ADR
    mov pc, r3
.align
.ltorg
adr:
