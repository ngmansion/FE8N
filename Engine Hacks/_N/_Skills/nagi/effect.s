.thumb
    ldr r1, =0xFFFFFFFF
    cmp r0, r1
    beq jump
    ldr r1, =0xFFFF
    cmp r0, r1
    beq jump
    .short 0xE000
jump:
    ldr r0, addr
    pop {r4, pc}

.align
.ltorg
addr:

