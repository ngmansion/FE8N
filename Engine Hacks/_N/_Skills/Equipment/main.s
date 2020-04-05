.thumb

    ldr r3, =0x080164c4
    ldr r3, [r3]
    
    mov r1, #255
    and r1, r5
    lsl r0, r1, #3
    add r0, r0, r1
    lsl r0, r0, #2
    add r0, r0, r3
    ldrb r2, [r0, #28]
    cmp r2, #250
    bgt return      @S武器

    bl main
    cmp r0, #0
    beq return
TRUE:
    mov r0, #1
    pop {r4, r5, pc}

main:
        push {r5, r6, lr}
        mov r5, r0
        mov r6, #0
        bl Arms
        orr r6, r0
        bl Wizard
        orr r6, r0

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
        mov r0, r4
        mov r1, #0
        bl HAS_ARMS
        .short 0xE000
    falseArms:
        mov r0, #0
        pop {pc}

D_MAGIC = (0x02)

Wizard:
        push {lr}
        ldr r0, [r5, #8]
        mov r1, #D_MAGIC
        and r0, r1
        beq falseWizard         @魔法じゃない

        mov r0, r4
        mov r1, #0
        bl HAS_WIZARD
        .short 0xE000
    falseWizard:
        mov r0, #0
        pop {pc}


return:
    ldr r3, =0x080164c4
    ldr r3, [r3]
    
    mov r1, #255
    and r1, r5
    lsl r0, r1, #3
    add r0, r0, r1
    lsl r0, r0, #2
    add r0, r0, r3
    ldrb r2, [r0, #28]

    ldr r1, =0x080164d6
    mov pc, r1

HAS_WIZARD:
    ldr r2, addr+0
    mov pc, r2
HAS_ARMS:
    ldr r2, addr+4
    mov pc, r2

.align
.ltorg
addr:
