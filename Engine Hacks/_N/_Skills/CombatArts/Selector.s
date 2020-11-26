.thumb

push	{r4, r5, r6, lr}
mov	r5, r0
bl main
mov	r2, r5
add	r2, #97
ldr r0, =0x08050010
mov pc, r0

main:
        push {lr}
        bl VanishCharacter
        ldr r1, ADDR
        ldrb r0, [r1]
        cmp r0, #0
        beq false
        bl CheckHelp
        cmp r0, #0
        beq false

        bl Left
        cmp r0, #1
        beq true
        bl Right
        cmp r0, #1
        beq true
    false:
        pop {pc}
    true:
        bl Sound
        pop {pc}

KEY_RIGHT = (16)
KEY_LEFT = (32)

Left:
        push {lr}
        ldr r1, =0x085775cc
        ldr r3, [r1, #0]
        ldrh r0, [r3, #6]
        mov r1, #KEY_LEFT
        and r0, r1
        cmp r0, #0
        beq falseMove

        bl Decrease
        pop {pc}

Right:
        push {lr}
        ldr r1, =0x085775cc
        ldr r3, [r1, #0]
        ldrh r0, [r3, #6]
        mov r1, #KEY_RIGHT
        and r0, r1
        cmp r0, #0
        beq falseMove

        bl Increase
        pop {pc}

    falseMove:
        mov r0, #0
        pop {pc}

Increase:
    ldr r1, ADDR
    ldrb r0, [r1]
    cmp r0, #7
    bge falseCount
    ldr r3, ADDR+4
    sub r3, #1
    ldrb r2, [r3, r0]
    cmp r2, #0
    beq falseCount
    add r0, #1
    strb r0, [r1]
    b trueCount

Decrease:
    ldr r1, ADDR
    ldrb r0, [r1]
    cmp r0, #1
    ble falseCount
    ldr r1, ADDR
    ldrb r0, [r1]
    sub r0, #1
    strb r0, [r1]
    b trueCount
falseCount:
    mov r0, #0
    bx lr
trueCount:
    mov r0, #1
    bx lr

CheckHelp:  @ヘルプ中は動けなくする
        ldr r2, =0x0203E7AA
        ldrb r0, [r2]
        ldrb r1, [r2, #1]
            cmp r0, #0
            bne falseHelp
            cmp r1, #0
            beq trueHelp
            cmp r1, #6
            beq trueHelp
            b falseHelp
    trueHelp:
        mov r0, #1
        .short 0xE000
    falseHelp:
        mov r0, #0
        bx lr




Sound:
mov r0, #102
ldr r1, =0x080d4ef4
mov pc, r1

VanishCharacter:
ldr r0, ADDR+8
mov pc, r0

.align
.ltorg
ADDR:
