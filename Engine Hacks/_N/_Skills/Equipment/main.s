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

    ldr r0, [r0, #8]
    mov r1, #2
    and r0, r1
    cmp r0, #0
    beq return      @魔法じゃない
    mov r0, r4
    mov r1, #0
    bl HAS_WIZARD
    cmp r0, #0
    beq return
    mov r0, #1
    pop {r4, r5, pc}

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

.align
.ltorg
addr:
