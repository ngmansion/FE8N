@thumb
    push {r4, lr}
    mov r4, r0
    mov r0, r5
        @align 4
        ldr r1, [adr] ;回復
        mov lr, r1
    mov r2, r0
    mov r0, r4
    ldr r1, =$08019f44
    ldr r1, [r1]
    add r0, r0, r1
    ldrb r0, [r0, #0]
    lsl r0, r0, #24
    asr r0, r0, #24
    orr r0, r2
    pop {r4, pc}
    bx lr
@ltorg
adr: