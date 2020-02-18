@ 08036784

.thumb
    push {r2, r3}

    ldr r0, [r4, #76]
    mov r1, #32
    and r0, r1
    cmp r0, #0
    bne got
    bl adept
    cmp r0, #1
    beq got
    ldr r0, =0x0803679a @end
    .short 0xE000
got:
    ldr r0, =0x0803678e @continue
    pop {r2, r3}
    mov pc, r0

adept:
        mov r0, r4
        ldr r1, =0x0203a568
        cmp r0, r1
        bne jump
        ldr r1, =0x0203a4e8
    jump:
        mov r2, #1  @獅子連判定用
        ldr r3, addr
        mov pc, r3

.align
.ltorg
addr:

