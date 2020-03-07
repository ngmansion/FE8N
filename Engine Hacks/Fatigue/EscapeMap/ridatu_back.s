UNIT_MAX_NUM = (51)

.thumb

    push {r5, lr}
    mov r5, #0
outLoopUnit:
    add r5, #1
    cmp r5, #UNIT_MAX_NUM
    bgt return
    
    mov r0, r5
        ldr r1, =0x08019108
        mov lr, r1
        .short 0xF800
    ldr r1, [r0]
    cmp r1, #0
    beq return   @ユニットがもういない
    ldr r1, [r0, #0xC]
    ldr r2, =0x01000008
    mov r3, r1
    and r3, r2
    cmp r3, r2
    bne outLoopUnit
    bic r1, r2
    str r1, [r0, #0xC]
    mov r1, #0xFF
    strb r1, [r0, #16]
    b outLoopUnit
return:
    pop {r5, pc}

.align
.ltorg
ADDR:

