.thumb
        push {r4-r7, lr}
        mov r7, r0
        bl main
        cmp r0, #1
        beq zero
        mov r0, #11
        ldsb r0, [r7, r0]
        ldr r1, =0x0802c004
        mov pc, r1
    zero:
        ldr r0, =0x0802c05a
        mov pc, r0

main:
        push {lr}
        ldr r0, =0x0203a4e8
        cmp r0, r7
        bne jump
        ldr r0, =0x0203a568
    jump:
        ldr r1, [r0, #0]
        ldr r2, [r0, #4]
        ldr r1, [r1, #40]
        ldr r2, [r2, #40]
        orr r1, r2
        lsr r1, r1, #24
        mov r0, #1
        and r0, r1
        pop {pc}


