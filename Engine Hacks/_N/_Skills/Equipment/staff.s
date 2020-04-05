.thumb

        mov r0, r3
        add r0, #40
        ldrb r1, [r2, #7]      @武器種類
        add r0, r0, r1
        ldrb r0, [r0, #0]
        mov r1, #0
        ldrb r2, [r2, #28]
        cmp r0, r2
        blt next
        mov r1, #1
        b end
    next:
        cmp r2, #250
        bgt end                 @S武器

        mov r0, r3
        mov r1, #0
        bl HAS_WIZARD
        .short 0xE000
    end:
        mov r0, r1
        pop {pc}

HAS_WIZARD:
    ldr r2, addr+0
    mov pc, r2


.align
.ltorg
addr:

