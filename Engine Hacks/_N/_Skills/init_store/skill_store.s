.thumb

    bl main
    mov r1, r6
    add r1, #12
    ldrb r0, [r6, #12]
    cmp r0, #0
    ldr r3, =0x08017ae8
    mov pc, r3

main:
    push {lr}
    mov r0, r5
    mov r1, #0
    ldrb r2, [r6, #6]
    bl SET_SKILL
    pop {pc}

.align
SET_SKILL:
    ldr r3, addr
    mov pc, r3

.align
.ltorg
addr:

