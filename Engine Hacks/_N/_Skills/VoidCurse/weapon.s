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
        
        bl Master
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

Master:
        push {r5, r6, lr}
        mov r6, #0

        mov r0, #80
        ldrb r0, [r7, r0]
        add r0, #40
        ldrb r0, [r7, r0]
        cmp r0, #0
        bgt endMaster           @経験値が既に1以上

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

        mov r5, r0
        bl Wizard
        orr r6, r0
        bl Arms
        orr r6, r0

    endMaster:
        mov r0, r6
        pop {r5, r6, pc}

Arms:
        push {lr}
        ldrb r0, [r5, #7]
        cmp r0, #0
        beq nextArms
        cmp r0, #1
        beq nextArms
        cmp r0, #2
        beq nextArms
        cmp r0, #3
        beq nextArms
        b falseArms
    nextArms:
        mov r0, r7
        mov r1, #0
        bl HAS_ARMS
        .short 0xE000
    falseArms:
        mov r0, #0
        pop {pc}

D_MAGIC = (0x02)
D_STAFF = (0x04)
D_MAGIC_AND_STAFF = (0x06)

Wizard:
        push {lr}
        ldr r0, [r5, #8]
        mov r1, #D_MAGIC_AND_STAFF
        and r0, r1
        beq falseWizard         @魔法じゃない

        mov r0, r7
        mov r1, #0
        bl HAS_WIZARD
        .short 0xE000
    falseWizard:
        mov r0, #0
        pop {pc}

HAS_WIZARD:
    ldr r2, addr+0
    mov pc, r2
HAS_ARMS:
    ldr r2, addr+4
    mov pc, r2

.align
.ltorg
addr:

