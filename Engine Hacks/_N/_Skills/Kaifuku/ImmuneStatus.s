.thumb
    push {lr}
    mov r1, #0
    bl HasImmuneStatus
    pop {pc}
HasImmuneStatus:
ldr r2, addr
mov pc, r2

.align
.ltorg
addr:
