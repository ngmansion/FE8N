.thumb

@ 0802ab54
    mov r2, r0

    mov r0, #94
    ldrh r0, [r2, r0]
    lsl r0, r0, #1

    mov r1, #87
    ldsb r1, [r2, r1]
    add r0, r1

    mov r1, #25
    ldrb r1, [r2, r1]
    add r0, r1

    cmp r0, #0
    bge jump
    mov r0, #0
jump:
    mov r1, #98
    strh r0, [r2, r1]
    bx lr
