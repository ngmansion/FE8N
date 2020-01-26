.thumb
push {r4, lr}
mov r4, r0
ldr r1, =0x080168d0
mov lr, r1
.short 0xF800
ldr r1, addr
mov pc, r1

.align
.ltorg
addr:

