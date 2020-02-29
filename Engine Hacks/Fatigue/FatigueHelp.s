.thumb

VALID_BIT =         0b0011

        ldr r0, =0x02003bfc
        ldr r0, [r0, #12]
        add r0, #71
        ldrb r0, [r0]
        mov r1, #VALID_BIT
        and r0, r1
        cmp r0, #1
        blt fresh
        ldr r0, addr
        b return
    fresh:
        ldr r0, =0x0808ad20
        ldr r0, [r0]
    return:
        mov r1, r2
        add r1, #76
        ldr r3, =0x0808ad88
        mov pc, r3
.align
.ltorg
addr:
