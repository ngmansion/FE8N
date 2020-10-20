.thumb
    push {lr}
    bl HasSoulblade
    cmp r0, #0
    beq false
    mov r0, #1
    b end

false:
    mov r0, #0
end:
    pop {pc}


HasSoulblade:
    ldr r2, addr
    mov pc, r2

.align
.ltorg
addr:
