.thumb
@ 00018460
    ldr r2, [r6, #0]
    ldr r0, [r2, #12]
    mov r1, #2
    orr r0, r1
    str r0, [r2, #12]
    ldrb r0, [r2, #0xB]
    mov r1, #0xC0
    tst r0, r1
    beq skip

    ldr r0, =0x0203a954
    ldrb r0, [r0, #17]
    cmp r0, #0
    bne skip            @待機以外

    mov r0, r2
    bl WAIT_SKILLS
skip:
    ldr r0, =0x0801846a
    mov pc, r0

WAIT_SKILLS:
    ldr r2, addr+0
    mov pc, r2

.align
.ltorg
addr:



