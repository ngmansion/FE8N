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
        bl VoidCurse
        cmp r0, #1
        beq end
        
        bl Wizard
    end:
        pop {pc}

VoidCurse:
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
        bx lr

Wizard:
        push {lr}

        ldr r3, =0x080164c4
        ldr r3, [r3]

        mov r0, #72
        ldrh r0, [r7, r0]
        mov r1, #255
        and r1, r0
        lsl r0, r1, #3
        add r0, r0, r1
        lsl r0, r0, #2
        add r0, r0, r3
        ldr r0, [r0, #8]
        mov r1, #2
        and r0, r1
        cmp r0, #0
        beq endWizard   @魔法ではない

        mov r0, r7
        mov r1, #0
        bl HAS_WIZARD
    endWizard:
        pop {pc}

HAS_WIZARD:
    ldr r2, addr+0
    mov pc, r2

.align
.ltorg
addr:

