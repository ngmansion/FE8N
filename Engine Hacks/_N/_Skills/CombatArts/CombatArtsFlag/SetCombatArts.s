.thumb
@
@r1 = status_addr
@
    ldr r2, addr
    strb r0, [r2]
    bx lr
.align
.ltorg
addr:
