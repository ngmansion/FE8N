.thumb
    ldr	r0, =0x02003f06  @数字位置
        ldr r1, =0x0802A96C
        ldr r1, [r1]
        mov lr, r1
        .short 0xF800
    ldr r0, addr
    mov pc, r0

.align
.ltorg
addr:
