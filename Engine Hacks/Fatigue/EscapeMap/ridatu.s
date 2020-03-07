.thumb

@400D0000
    push {lr}
    ldr  r0, =0x03004df0
    ldr  r0, [r0]
    ldrb r1, [r0, #0xB]
    lsr  r1, r1, #6
    bne  end                            @自軍ではないなら終了

    ldrb r1, [r0, #0xC]
    lsl  r1, r1, #27
    bpl  skip                           @担いでいない
    ldrb r0, [r0, #0x1B]
        ldr  r1, =0x08019108
        mov  lr, r1
        .short 0xF800
    ldr  r1, [r0]
    ldrb r1, [r1, #4]
    ldr  r2, =0x030004B0
    ldr  r2, [r2, #4]
    cmp  r1, r2
    beq  end
    
    bl Stay
skip:
    ldr  r0, =0x03004df0
    ldr  r0, [r0]
    bl Stay
end:
    pop  {pc}


Stay:
    mov r1, #0x0
    strb r1, [r0, #19]
    str r1, [r0, #60]

    ldr r1, [r0, #0xC]
    ldr r2, =0x01000008
    orr r1, r2
    str r1, [r0, #0xC]
    bx lr

